//
//  GameFieldCell.h
//  Lines_iOS
//
//  Created by robert on 30/06/15.
//  Copyright (c) 2015 A'Shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/* This class describes one cell on the GameField. Cell may contain ColorBall or be empty.
 Cell is a part of the GameField and on the the N * M cell. Cell might be highlighted */
@interface GameFieldCell : NSObject

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSString *index;
@property BOOL isHighlighted;

-(id)initWithIndex:(NSString *)index;
-(void)highlight;
-(void)unhighlight;

@end
