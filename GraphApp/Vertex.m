//
//  Vertex.m
//  Prog
//
//  Created by Arthur THEVENET on 1/30/14.
//  Copyright (c) 2014 Arthur THEVENET. All rights reserved.
//

#import "Vertex.h"

#import "Coord.h"

@implementation Vertex


- (id)init
{
    self = [super init];
    
    if (self) {
        self.coord = [[Coord alloc] init];
    }
    
    return self;
}

- (id)initWithId:(NSString *) id
{
    if ( self = [super init] ) {
        self.id = id;
        self.label = id;
        return self;
    }
    
    return nil;
}

@end