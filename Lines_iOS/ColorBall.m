//
//  ColorBall.m
//  Lines_iOS
//
//  Created by robert on 30/06/15.
//  Copyright (c) 2015 A'Shi. All rights reserved.
//

#import "ColorBall.h"

@implementation ColorBall

-(id)initWithColor:(ColorBallColor)color
{
    self = [super init];
    if (self)
    {
        self.color = color;
        NSString *colorName = @"";
        switch (color)
        {
            case ColorBallColorGreen:
                colorName = @"Green";
                break;
            case ColorBallColorOrange:
                colorName = @"Orange";
                break;
            case ColorBallColorViolet:
                colorName = @"Violet";
                break;
            case ColorBallColorRed:
                colorName = @"Red";
                break;
            case ColorBallColorBlue:
                colorName = @"Blue";
                break;
            case ColorBallColorSkyBlue:
                colorName = @"SkyBlue";
                break;
            case ColorBallColorYellow:
                colorName = @"Yellow";
                break;
            default:
                break;
        }
        self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@Ball", colorName]];
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.index = nil;
    }
    
    return self;
}

-(void)setIndex:(NSString *)index
{
#warning incomplite implementation
}

-(void)removeFromGameField
{
#warning incomplite implementation
}
@end
