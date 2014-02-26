//
//  Edge.m
//  GraphModel
//
//  Created by Arthur THEVENET on 1/30/14.
//  Copyright (c) 2014 Arthur THEVENET. All rights reserved.
//

#import "Edge.h"

@implementation Edge

- (id) init
{
    if (self = [super init]) {
        self.label = @"";
        self.weight = 1;

        return self;
    }
    
    return nil;
}

- (id) initWithVertices:(Vertex *) origin target:(Vertex *) target
{
    if (self = [self init]) {
        self.origin = origin;
        self.target = target;

        return self;
    }
    
    return nil;
}

@end
