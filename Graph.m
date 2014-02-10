//
//  Graph.m
//  Prog
//
//  Created by Arthur THEVENET on 1/30/14.
//  Copyright (c) 2014 Arthur THEVENET. All rights reserved.
//

#import "Graph.h"

@interface Graph ()

@property (readwrite) NSString* label;
@property (readwrite) NSMutableDictionary* vertices;
@property (readwrite) NSMutableArray* edges;

@end


@implementation Graph {
    
}

- (id) init
{
    if (self = [super init]) {
        self.oriented = false;
        self.vertices = [[NSMutableDictionary alloc] init];
        self.edges = [[NSMutableArray alloc] init];
    }

    return self;
}

- (void) addVertex : (Vertex*) vertex
{
    [self.vertices setValue:vertex forKey:vertex.id];
}


- (BOOL) hasVertex: (NSString *) id
{
    return [self.vertices objectForKey:id] != nil;
}

- (Vertex*) getVertex: (NSString *) id
{
    return [self.vertices objectForKey:id];
}

- (void) addEdge : (Edge*) edge
{
    [self.edges addObject:edge];
}

- (void) removeEdge : (Edge*) edge
{
    [self.edges removeObjectIdenticalTo:edge];
}

- (void) removeVertex : (Vertex*) vertex
{
    [self.vertices removeObjectForKey:vertex.id];
}
@end
