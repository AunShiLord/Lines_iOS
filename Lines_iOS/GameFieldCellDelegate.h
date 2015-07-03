//
//  GameFieldCellDelegate.h
//  Lines_iOS
//
//  Created by robert on 03/07/15.
//  Copyright (c) 2015 A'Shi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GameFieldCell;

@protocol GameFieldCellDelegate <NSObject>

-(void)gameFieldCelltapped:(GameFieldCell *)gameFieldCell;

@end
