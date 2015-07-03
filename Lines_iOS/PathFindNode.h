//
//  PathFindNode.h
//  Lines_iOS
//
//  Created by Admin on 03.07.15.
//  Copyright (c) 2015 A'Shi. All rights reserved.
//

// the code bellow is from
// http://humblebeesoft.com/blog/?p=18

#import <Foundation/Foundation.h>

@interface PathFindNode : NSObject
{
@public
    int nodeX,nodeY;
    int cost;
    PathFindNode *parentNode;
}

+(id)node;

@end
