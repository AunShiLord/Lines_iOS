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
        self.image = [UIImage imageNamed:@"CellWithBorder"];
        self.frame = rect;
        self.isHighlighted = NO;
        
    }
    
    return self;
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
