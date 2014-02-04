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

- (id)initWithLabel:(NSString *) label
{
    if ( self = [super init] ) {
        self.label = label;
        return self;
    }
    
    return nil;
}

@end