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
    ColorBallColorSkyBlue,
    ColorBallColorBlue,
    ColorBallColorViolet
} ColorBallColor;

@interface ColorBall : UIImageView

#warning maybe some custom type?
// Type represents position in the GameField.
@property (strong, nonatomic) NSIndexPath *index;

@property (assign, nonatomic) ColorBallColor color;

-(id)initWithFrame:(CGRect)frame andColor:(ColorBallColor)color;
-(void)setIndex;
-(void)removeFromGameField;

@end

