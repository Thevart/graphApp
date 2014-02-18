//
//  Vertex.m
//  Prog
//
//  Created by Arthur THEVENET on 1/30/14.
//  Copyright (c) 2014 Arthur THEVENET. All rights reserved.
//

#import "Vertex.h"

#import "Coord.h"

static int nextVertexId = 1;

@implementation Vertex


- (id) init
{
    self = [super init];
    
    if (self) {
        self.id = [NSString stringWithFormat:@"%d", nextVertexId];
        self.label = [NSString stringWithFormat:@"%d", nextVertexId];
        self.coord = [[Coord alloc] init];

        nextVertexId += 1;
    }
    
    return self;
}

- (id)initWithId:(NSString *) id
{
    if (self = [self init]) {
        self.id = id;
        self.label = id;
        
        return self;
    }
    
    return nil;
}


- (void) setPosition: (int)x y:(int) y
{
    self.coord.x = x;
    self.coord.y = y;
}


- (BOOL) hasPosition
{
    return self.coord.x != 0 && self.coord.y != 0;
}

@end