//
//  Edge.m
//  GraphModel
//
//  Created by Arthur THEVENET on 1/30/14.
//  Copyright (c) 2014 Arthur THEVENET. All rights reserved.
//

#import "Edge.h"

@implementation Edge

- (id)initWithLabel:(NSString *) label
{
    if ( self = [super init] ) {
        self.label = label;
        return self;
    }
    
    return nil;
}

-(id) initWithVertices:(Vertex *)originVertex destination:(Vertex *)destinationVertex
{
    if ( self = [super init] ) {
        self.origin = originVertex;
        self.target = destinationVertex;
        return self;
    }
    
    return nil;
}

@end
