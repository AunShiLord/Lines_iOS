//
//  GameFieldCell.m
//  Lines_iOS
//
//  Created by robert on 30/06/15.
//  Copyright (c) 2015 A'Shi. All rights reserved.
//

#import "GameFieldCell.h"

@implementation GameFieldCell

-(id)initWithIndex:(NSString *)index andRect:(CGRect)rect
{
    self = [super init];
    if(self)
    {
        self.index = index;
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GameFieldCell"]];
        self.imageView.frame = rect;
        self.isHighlighted = NO;
        
    }
    
    return self;
}

-(void)highlight
{
    self.imageView.image = [UIImage imageNamed:@"GameFieldCellHighlighted"];
    self.isHighlighted = YES;
}

-(void)unhighlight
{
    self.imageView.image = [UIImage imageNamed:@"GameFieldCell"];
    self.isHighlighted = NO;
}
@end
