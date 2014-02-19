//
//  Graph.h
//  Prog
//
//  Created by Arthur THEVENET on 1/30/14.
//  Copyright (c) 2014 Arthur THEVENET. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vertex.h"
#import "Edge.h"

@interface Graph : NSObject

@property (readwrite, getter = isOriented) BOOL oriented;
@property (readonly) NSString* label;
@property (readonly) NSMutableDictionary* vertices;
@property (readonly) NSMutableArray* edges;

- (void) addVertex : (Vertex*) vertex;
- (BOOL) hasVertex: (NSString *) id;
- (Vertex*) getVertex: (NSString *) id;
- (void) removeVertex : (Vertex*) vertex;

- (void) addEdge: (Edge*) edge;
- (void) removeEdge : (Edge*) edge;
@end
