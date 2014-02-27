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

- (void) addEdge:(Edge*) edge
{
    [self _doAddEdge:edge];

    if (!self.oriented) {
        Edge* returnEdge = [[[edge class] alloc] initWithVertices:edge.target target:edge.origin];
        returnEdge.weight = edge.weight;
        returnEdge.label = [NSString stringWithFormat:@"%@_%@", returnEdge.origin.id, returnEdge.target.id];

        [self _doAddEdge:returnEdge];
    }
}

- (void) _doAddEdge: (Edge*) edge
{
    if (![self.edges containsObject:edge]) {
        [self.edges addObject:edge];
    }

    [edge.origin addNeighbour:edge];
}

- (void) removeEdge: (Edge*) edge
{
    [edge.origin removeNeighbourVertex:edge.target];

    if (!self.oriented) {
        Edge* removedEdge = [edge.target removeNeighbourVertex:edge.origin];
        [self _doRemoveEdge:removedEdge];
    }

    [self _doRemoveEdge:edge];
}

- (void) _doRemoveEdge: (Edge*) edge
{
    [self.edges removeObject:edge];
}

- (void) removeVertex: (Vertex*) vertex
{
    NSArray *neighboursToUpdate = [[NSArray alloc] initWithArray:vertex.neighbours];

    for (Edge* edge in neighboursToUpdate) {
        [self removeEdge:edge];
    }

    [self.vertices removeObjectForKey:vertex.id];
}
@end
