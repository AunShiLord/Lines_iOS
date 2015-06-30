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
    if (!self)
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
            case ColorBallColorPuple:
                colorName = @"Purple";
                break;
            case ColorBallColorRed:
                colorName = @"Red";
                break;
            case ColorBallColorSapphirineBlue:
                colorName = @"SapphirineBlue";
                break;
            case ColorBallColorWaterBlue:
                colorName = @"WaterBlue";
                break;
            case ColorBallColorYellow:
                colorName = @"Yellow";
                break;
            default:
                break;
        }
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@Ball", colorName]]];
#warning Need decision with index type
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
