//
//  ColorBall.h
//  Lines_iOS
//
//  Created by robert on 30/06/15.
//  Copyright (c) 2015 A'Shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// types of color of color balls
typedef enum colorBallColors
{
    ColorBallColorRed,
    ColorBallColorOrange,
    ColorBallColorYellow,
    ColorBallColorGreen,
    ColorBallColorWaterBlue,
    ColorBallColorSapphirineBlue,
    ColorBallColorPuple
} ColorBallColor;

@interface ColorBall : NSObject

@property (strong, nonatomic) UIImageView *imageView;

#warning maybe some custom type?
// Type represents position in the GameField.
@property (strong, nonatomic) NSString *index;

@property (assign, nonatomic) ColorBallColor color;

-(id)initWithColor:(ColorBallColor) color;
-(void)setIndex;
-(void)removeFromGameField;

@end

