//
//  Point.m
//  GraphModel
//
//  Created by Arthur THEVENET on 1/30/14.
//  Copyright (c) 2014 Arthur THEVENET. All rights reserved.
//

#import "Coord.h"

@implementation Coord

- (id) init
{
    self = [super init];
    
    if (self) {
        self.x = 0;
        self.y = 0;

    }
    
    return self;
}


- (id) initWithValues:(int) x y:(int) y
{
    self = [super init];

    if (self) {
        self.x = x;
        self.y = y;

    }

    return self;
}


@end
