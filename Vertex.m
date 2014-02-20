//
//  Vertex.m
//  Prog
//
//  Created by Arthur THEVENET on 1/30/14.
//  Copyright (c) 2014 Arthur THEVENET. All rights reserved.
//


#import "Coord.h"
#import "Vertex.h"

static int nextVertexId = 1;

@implementation Vertex

- (id) init
{
    self = [super init];
    
    if (self) {
        self.id = [NSString stringWithFormat:@"%d", nextVertexId];
        self.neighbours = [[NSMutableArray alloc] init];
        self.label = [NSString stringWithFormat:@"%d", nextVertexId];
        self.coord = [[Coord alloc] init];
        self.color = -1;

        nextVertexId += 1;
    }
    
    return self;
}

- (id) initWithId:(NSString *) id
{
    if (self = [self init]) {
        self.id = id;
        self.label = id;
        
        return self;
    }
    
    return nil;
}

- (void) setHexColor: (int) color
{
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

- (void) addNeighbour:(Edge*) neighbour
{
    [self.neighbours addObject:neighbour];
}

@end