//
//  GameFieldCell.m
//  Lines_iOS
//
//  Created by robert on 30/06/15.
//  Copyright (c) 2015 A'Shi. All rights reserved.
//

#import "GameFieldCell.h"

@implementation GameFieldCell

-(id)initWithIndex:(NSIndexPath *)index andRect:(CGRect)rect
{
    self = [super init];
    if(self)
    {
        self.index = index;
        self.currentState = -1;
        self.image = [UIImage imageNamed:@"CellWithBorder"];
        self.frame = rect;
        self.isHighlighted = NO;
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(handleCellTap:)];
        
        [self addGestureRecognizer:tapGesture];
        
    }
    
    NSLog(@"\n\n GAME FIELD CELL Frame: %@\nBounds: %@\n\n", NSStringFromCGRect(self.frame), NSStringFromCGRect(self.bounds));
    return self;
}

-(void)spawnBallwithColor:(ColorBallColor) colorBallColor
{
    // creating rect for ColorBall
    CGFloat margin = self.frame.size.width * 0.15;
    CGRect gameFieldCellRect = self.bounds;
    CGRect colorBallRect = CGRectMake(gameFieldCellRect.origin.x + margin,
                                       gameFieldCellRect.origin.y + margin,
                                       gameFieldCellRect.size.width - margin*2,
                                       gameFieldCellRect.size.height - margin*2);
    ColorBall *colorBall = [[ColorBall alloc] initWithFrame:colorBallRect andColor:colorBallColor];
    [self addSubview:colorBall];
    
    // change state
    self.currentState = colorBallColor;
}

-(void)removeBall
{
    if (self.currentState != -1)
    {
        self.currentState = -1;
        for (UIView *subview in self.subviews)
            [subview removeFromSuperview];
    }
}

-(void)handleCellTap:(UITapGestureRecognizer *)gestureRecognizer
{
//    if (self.currentState != -1)
//    {
//        if (self.isHighlighted)
//            [self unhighlight];
//        else
//            [self highlight];
//    }
    [self.delegate gameFieldCelltapped:self];
    
}

-(void)highlight
{
    self.image = [UIImage imageNamed:@"HighlightedCell"];
    self.isHighlighted = YES;
}

-(void)unhighlight
{
    self.image = [UIImage imageNamed:@"CellWithBorder"];
    self.isHighlighted = NO;
}
@end
