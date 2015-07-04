//
//  GameField.m
//  Lines_iOS
//
//  Created by robert on 30/06/15.
//  Copyright (c) 2015 A'Shi. All rights reserved.
//

#import "ColorBall.h"
#import "GameField.h"
#import "GameFieldCell.h"
#import "PathFindNode.h"

// for arc4random_uniform
#include <stdlib.h>


@interface GameField() <GameFieldCellDelegate>

@property (nonatomic, readwrite) CGFloat width;
@property (nonatomic, readwrite) CGFloat height;
@property NSMutableArray *gameFieldCells;

@end;

@implementation GameField

-(id)initEmptyFieldWithRows:(int)numberOfRows columns:(int)numberOfColumns margin:(int)margin
{
    self = [super init];
    if (self)
    {
        // init N*M array
        //self.gameFieldCells = (int **)malloc(numberOfRows * sizeof(int *));
        self.gameFieldState = (int **)malloc(numberOfRows * sizeof(int *));
        
        for (int i = 0; i < numberOfRows; ++i)
            self.gameFieldState[i] = (int *)malloc(numberOfColumns * sizeof(int));
        
        // init NSMutableArray where all gameFieldCells are will be kept
        self.gameFieldCells = [NSMutableArray new];
        for (int i = 0; i < numberOfRows; i++)
        {
            [self.gameFieldCells addObject:[NSMutableArray new]];
            for (int j = 0; j < numberOfColumns; j++)
            {
                [self.gameFieldCells[i] addObject: [NSNull null]];
            }
        }
        
        // setting currently selectet cell to nil
        self.currentlySelectedCellIndex = nil;
        
        // setting spawned balls to zero, number of columns and rows
        self.spawnedBalls = 0;
        self.numberOfRows = numberOfRows;
        self.numberOfColumns = numberOfColumns;
        
        self.backgroundColor = [UIColor blackColor];
        // init new game field frame
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        self.width = screenRect.size.width - margin*2;
        self.height = self.width * (float)numberOfRows/(float)numberOfColumns;
        CGFloat navigationBarHeight = 64;
        CGRect gameFieldRect = CGRectMake(margin,
                                          screenRect.size.height - margin - self.height - navigationBarHeight,
                                          self.width,
                                          self.height);
        
        NSLog(@"\n\nScreen Height: %f\nHeight: %f\nGameFieldRect Y: %f", screenRect.size.height, self.height, gameFieldRect.origin.y);
        
        self.frame = gameFieldRect;
        //self.bounds = gameFieldRect;
        
        // size of each side of the gameFieldCell
        CGFloat gameFieldCellsize = self.width / numberOfColumns;
        
        // now, when game field is set on the bottom of the screen,
        // filling it with gameCells
        for (int i=0; i<numberOfRows; i++)
        {
            for (int j=0; j<numberOfColumns; j++)
            {
                CGRect gameFieldRect = CGRectMake(gameFieldCellsize * j + 1,
                                                  gameFieldCellsize * i + 1,
                                                  gameFieldCellsize - 2,
                                                  gameFieldCellsize - 2);
                NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:j];
                GameFieldCell *cell = [[GameFieldCell alloc] initWithIndex: index andRect:gameFieldRect];
                cell.delegate = self;
                [self addSubview:cell];
                self.gameFieldState[i][j] = -1;
                self.gameFieldCells[i][j] = cell;
            }
        }
        //NSIndexPath *index = [NSIndexPath indexPathForRow:3 inSection:3];
        //NSLog(@"\nCHECK INDEX: %d", (int)[self.gameFieldState objectForKey:index]);
        
    }

    NSLog(@"\n\n GAME FIELD Frame: %@\nBounds: %@\n\n", NSStringFromCGRect(self.frame), NSStringFromCGRect(self.bounds));
    
    return self;
}

-(void)spawnBallsWithColors:(NSArray *)colors
{
    NSLog(@"\n\nGot balls:%d\nMaximum balls:%d", self.spawnedBalls + (int)[colors count], self.numberOfColumns * self.numberOfRows);
    for (NSNumber *color in colors)
    {
        if (self.spawnedBalls == self.numberOfColumns * self.numberOfRows)
        {
            // if no more room to spawn balls
            [self.delegate gameFieldOverloaded:self];
            break;
        }
        else
        {
            int randomRow, randomColumn, emptyCellCount, i;
            
            randomRow = 0;
            // finding random row
            emptyCellCount = 0;
            while (emptyCellCount == 0)
            {
                randomRow = arc4random_uniform(self.numberOfRows);
                // counting how many empty places in the row
                for (i = 0; i < self.numberOfColumns; i++)
                    if (self.gameFieldState[randomRow][i] == -1)
                        emptyCellCount++;
            }
            
            // finding random Column
            while (randomColumn != 1234)
            {
                randomColumn = arc4random_uniform(self.numberOfColumns);
                if (self.gameFieldState[randomRow][randomColumn] == -1)
                {
                    // place ball in index
                    GameFieldCell *cell = self.gameFieldCells[randomRow][randomColumn];
                    [cell spawnBallwithColor:color.intValue];
                    self.gameFieldState[randomRow][randomColumn] = color.intValue;
                    self.spawnedBalls++;
                    if (self.spawnedBalls == self.numberOfColumns * self.numberOfRows)
                        // if no more room to spawn balls
                        [self.delegate gameFieldOverloaded:self];
                    break;
                }
            }
        }

    }
}

-(int)scanForLinesAndGetScorePoints
{
    int scorePoints = 0;
    int minLineLenght = 5;
    int i, j, k, g;
    BOOL isPossibleLine = TRUE;
    int numberOfMatches = 0;
    int currentColor;
    
    NSMutableArray *posibleIndexes = [NSMutableArray new];
    NSMutableArray *linesToDelete = [NSMutableArray new];
    
    
    for (i = 0; i < self.numberOfRows; i++)
    {
        for (j = 0; j < self.numberOfColumns; j++)
        {
            currentColor = self.gameFieldState[i][j];
            // check if cell is not empty
            if (currentColor != -1)
            {
                [posibleIndexes removeAllObjects];
                isPossibleLine = TRUE;
                numberOfMatches = 1;
                [posibleIndexes addObject:[NSIndexPath indexPathForRow:i inSection:j]];
                
                // check right
                k = j;
                while (k<self.numberOfColumns)
                {
                    k++;
                    if (k<self.numberOfColumns)
                    {
                        if (self.gameFieldState[i][k] == currentColor)
                        {
                            numberOfMatches++;
                            [posibleIndexes addObject:[NSIndexPath indexPathForRow:i inSection:k]];
                            if (numberOfMatches == minLineLenght)
                            {
                                linesToDelete = [self addNewIndexesToArray:linesToDelete fromArray:posibleIndexes];
                            }
                            if (numberOfMatches > minLineLenght)
                            {
                                [linesToDelete addObject:[NSIndexPath indexPathForRow:i inSection:k]];
                            }
                        }
                        else
                        {
                            break;
                        }
                    }
                }
                [posibleIndexes removeAllObjects];
                numberOfMatches = 1;

                // check down
                [posibleIndexes addObject:[NSIndexPath indexPathForRow:i inSection:j]];
                k = i;
                while (k<self.numberOfRows)
                {
                    k++;
                    if (k<self.numberOfRows)
                    {
                        if (self.gameFieldState[k][j] == currentColor)
                        {
                            numberOfMatches++;
                            [posibleIndexes addObject:[NSIndexPath indexPathForRow:k inSection:j]];
                            if (numberOfMatches == minLineLenght)
                            {
                                linesToDelete = [self addNewIndexesToArray:linesToDelete fromArray:posibleIndexes];
                            }
                            if (numberOfMatches > minLineLenght)
                            {
                                [linesToDelete addObject:[NSIndexPath indexPathForRow:k inSection:j]];
                            }
                        }
                        else
                        {
                            break;
                        }
                    }

                }
                [posibleIndexes removeAllObjects];
                numberOfMatches = 1;
                
                // check up right
                [posibleIndexes addObject:[NSIndexPath indexPathForRow:i inSection:j]];
                k = i;
                g = j;
                while (k<self.numberOfRows & g<self.numberOfColumns)
                {
                    k++;
                    g++;
                    if (k<self.numberOfRows & g<self.numberOfColumns)
                    {
                        if (self.gameFieldState[k][g] == currentColor)
                        {
                            numberOfMatches++;
                            [posibleIndexes addObject:[NSIndexPath indexPathForRow:k inSection:g]];
                            if (numberOfMatches == minLineLenght)
                            {
                                linesToDelete = [self addNewIndexesToArray:linesToDelete fromArray:posibleIndexes];
                            }
                            if (numberOfMatches > minLineLenght)
                            {
                                [linesToDelete addObject:[NSIndexPath indexPathForRow:k inSection:g]];
                            }
                        }
                        else
                        {
                            break;
                        }
                    }
                }
                [posibleIndexes removeAllObjects];
                numberOfMatches = 1;
                
                // check down right
                [posibleIndexes addObject:[NSIndexPath indexPathForRow:i inSection:j]];
                k = i;
                g = j;
                while (k<self.numberOfRows & g>0)
                {
                    k++;
                    g--;
                    if (k<self.numberOfRows & g>0)
                    {
                        if (self.gameFieldState[k][g] == currentColor)
                        {
                            numberOfMatches++;
                            [posibleIndexes addObject:[NSIndexPath indexPathForRow:k inSection:g]];
                            if (numberOfMatches == minLineLenght)
                            {
                                linesToDelete = [self addNewIndexesToArray:linesToDelete fromArray:posibleIndexes];
                            }
                            if (numberOfMatches > minLineLenght)
                            {
                                [linesToDelete addObject:[NSIndexPath indexPathForRow:k inSection:g]];
                            }
                        }
                        else
                        {
                            break;
                        }
                    }
                }
                [posibleIndexes removeAllObjects];
                numberOfMatches = 1;
            }
        }
    }
    
    
    // count scorePoints
    scorePoints = 2 * [linesToDelete count];
    self.spawnedBalls -= [linesToDelete count];
    for (NSIndexPath *index in linesToDelete)
    {
        GameFieldCell *cell = self.gameFieldCells[index.row][index.section];
        [cell removeBall];
        self.gameFieldState[index.row][index.section] = -1;
        NSLog(@"\nIndex to delete: row: %d col: %d \n", index.row, index.section);
    }
    
    return scorePoints;
}

-(NSMutableArray *)addNewIndexesToArray:(NSMutableArray *)firstArray fromArray:(NSMutableArray *)secondArray
//-(NSMutableArray *)addNewIndexesToArray:(NSMutableArray *)firstArray fromArray:
{
    BOOL isUnique = YES;
    NSMutableArray *resultArray = [NSMutableArray new];
    for (NSIndexPath *firstIndex in secondArray)
    {
        isUnique = YES;
        for (NSIndexPath *secondIndex in firstArray)
        {
            if (firstIndex.row == secondIndex.row || firstIndex.section == secondIndex.section)
            {
                isUnique = NO;
                break;
            }
        }
        if (isUnique)
        {
            [resultArray addObject:firstIndex];
        }
    }
    
    [resultArray addObjectsFromArray:firstArray];
    
    return resultArray;
}

# pragma mark GameFieldCell delegate methods
-(void)gameFieldCelltapped:(GameFieldCell *)gameFieldCell
{
    if (self.currentlySelectedCellIndex)
    {
        // if this cell is already selected than unselect it
        if (gameFieldCell.index == self.currentlySelectedCellIndex)
        {
            [gameFieldCell unhighlight];
            self.currentlySelectedCellIndex = nil;
        }
        // if another cell is already selected, than check state of the the selected cell
        // and if it is empty, than move color ball and unselect
        else
        {
            if (gameFieldCell.currentState == -1)
            {
                // check if there is the way to pass from one cell to another
                if ([self findPathAtStartX:self.currentlySelectedCellIndex.section
                                    startY:self.currentlySelectedCellIndex.row
                                      endX:gameFieldCell.index.section
                                      endY:gameFieldCell.index.row])
                {
                    GameFieldCell *currentlySelectedCell = self.gameFieldCells[self.currentlySelectedCellIndex.row][self.currentlySelectedCellIndex.section];
                    [currentlySelectedCell unhighlight];
                    
                    [gameFieldCell spawnBallwithColor:currentlySelectedCell.currentState];
                    [currentlySelectedCell removeBall];
                    
                    // remember ball positions in gameFieldState
                    self.gameFieldState[self.currentlySelectedCellIndex.row][self.currentlySelectedCellIndex.section] = -1;
                    self.gameFieldState[gameFieldCell.index.row][gameFieldCell.index.section] = gameFieldCell.currentState;
                    self.currentlySelectedCellIndex = nil;
                    
                    // delegate method that informs GameScene controller that turn is over
                    [self.delegate gameField:self movedBallFrom:currentlySelectedCell to:gameFieldCell];
                }
            }
            // if the cell is not empty, than reselect it
            else
            {
                GameFieldCell *cell = self.gameFieldCells[self.currentlySelectedCellIndex.row][self.currentlySelectedCellIndex.section];
                [cell unhighlight];
                [gameFieldCell highlight];
                self.currentlySelectedCellIndex = gameFieldCell.index;
            }
        }
    }
    // if cell is not yet selected, than select it
    else
    {
        if (gameFieldCell.currentState != -1)
        {
            self.currentlySelectedCellIndex = gameFieldCell.index;
            [gameFieldCell highlight];
        }
    }
}

-(void)testPrintGameFieldState
{
    NSMutableString *result = [NSMutableString stringWithString:@""];
    for (int i = 0; i < self.numberOfRows; i++)
    {
        for (int j = 0; j < self.numberOfColumns; j++)
        {
            [result appendString:[NSString stringWithFormat:@"%d ", self.gameFieldState[i][j]]];
        }
        [result appendString:@"\n"];
    }
    NSLog(@"\n\n_____________________\n%@\n____________________\n\n", result);
}

#pragma - A star algorithm methods
// the code bellow is from
// http://humblebeesoft.com/blog/?p=18
// It was modified a bit, to fit my needs. A'Shi.

-(BOOL)spaceIsBlocked:(int)x :(int)y;
{
    //general-purpose method to return whether a space is blocked
    if(self.gameFieldState[y][x] != -1)
        return YES;
    else
        return NO;
}

-(PathFindNode*)nodeInArray:(NSMutableArray*)a withX:(int)x Y:(int)y
{
    //Quickie method to find a given node in the array with a specific x,y value
    NSEnumerator *e = [a objectEnumerator];
    PathFindNode *n;
    
    while((n = [e nextObject]))
    {
        if((n->nodeX == x) && (n->nodeY == y))
        {
            return n;
        }
    }
    
    return nil;
}
-(PathFindNode*)lowestCostNodeInArray:(NSMutableArray*)a
{
    //Finds the node in a given array which has the lowest cost
    PathFindNode *n, *lowest;
    lowest = nil;
    NSEnumerator *e = [a objectEnumerator];
    
    while((n = [e nextObject]))
    {
        if(lowest == nil)
        {
            lowest = n;
        }
        else
        {
            if(n->cost < lowest->cost)
            {
                lowest = n;
            }
        }
    }
    return lowest;
}

-(BOOL)findPathAtStartX:(int)startX startY:(int)startY endX:(int)endX endY:(int)endY
{
    //find path function. takes a starting point and end point and performs the A-Star algorithm
    //to find a path, if possible. Once a path is found it can be traced by following the last
    //node's parent nodes back to the start
    
    [self testPrintGameFieldState];
    
    int x,y;
    int newX,newY;
    int currentX,currentY;
    NSMutableArray *openList, *closedList;
    
    if((startX == endX) && (startY == endY))
        return NO; //make sure we're not already there
    
    //openList = [NSMutableArray array]; //array to hold open nodes
    openList = [NSMutableArray array];
    
    closedList = [NSMutableArray array]; //array to hold closed nodes
    
    PathFindNode *currentNode = nil;
    PathFindNode *aNode = nil;
    
    //create our initial 'starting node', where we begin our search
    PathFindNode *startNode = [PathFindNode node];
    startNode->nodeX = startX;
    startNode->nodeY = startY;
    startNode->parentNode = nil;
    startNode->cost = 0;
    //add it to the open list to be examined
    [openList addObject: startNode];
    
    while([openList count])
    {
        //while there are nodes to be examined...
        
        //get the lowest cost node so far:
        currentNode = [self lowestCostNodeInArray: openList];
        
        if((currentNode->nodeX == endX) && (currentNode->nodeY == endY))
        {
            //if the lowest cost node is the end node, we've found a path
            
            //********** PATH FOUND ********************
            
            //*****************************************//
            //NOTE: Code below is for the Demo app to trace/mark the path
//            aNode = currentNode->parentNode;
//            while(aNode->parentNode != nil)
//            {
//                self.gameFieldState[aNode->nodeX][aNode->nodeY] = TILE_MARKED;
//                aNode = aNode->parentNode;
//            }
            return YES;
            //*****************************************//
        }
        else
        {
            //...otherwise, examine this node.
            //remove it from open list, add it to closed:
            [closedList addObject: currentNode];
            [openList removeObject: currentNode];
            
            //lets keep track of our coordinates:
            currentX = currentNode->nodeX;
            currentY = currentNode->nodeY;
            
            //check all the surrounding nodes/tiles:
            for(y=-1;y<=1;y++)
            {
                newY = currentY+y;
                for(x=-1;x<=1;x++)
                {
                    newX = currentX+x;
                    //if(y || x) //avoid 0,0
                    if (abs(x)!=abs(y)) // avoid 0,0 and diagonal elements
                    {
                        //simple bounds check for the demo app's array
                        if((newX>=0)&&(newY>=0)&&(newX<self.numberOfColumns)&&(newY<self.numberOfRows))
                        {
                            //if the node isn't in the open list...
                            if(![self nodeInArray: openList withX: newX Y:newY])
                            {
                                //and its not in the closed list...
                                if(![self nodeInArray: closedList withX: newX Y:newY])
                                {
                                    //and the space isn't blocked
                                    if(![self spaceIsBlocked: newX :newY])
                                    {
                                        //then add it to our open list and figure out
                                        //the 'cost':
                                        aNode = [PathFindNode node];
                                        aNode->nodeX = newX;
                                        aNode->nodeY = newY;
                                        aNode->parentNode = currentNode;
                                        aNode->cost = currentNode->cost + 1;
                                        
                                        //Compute your cost here. This demo app uses a simple manhattan
                                        //distance, added to the existing cost
                                        aNode->cost += (abs((newX) - endX) + abs((newY) - endY));
                                        
                                        [openList addObject: aNode];
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    //**** NO PATH FOUND *****
    return NO;
}


-(void)dealloc
{
    free(self.gameFieldState);
}

@end
