//
//  Vertex.h
//  Prog
//
//  Created by Arthur THEVENET on 1/30/14.
//  Copyright (c) 2014 Arthur THEVENET. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coord.h"

@class Edge;

@interface Vertex : NSObject

@property NSString* id;
@property NSString* label;
@property Coord* coord;
@property NSMutableArray* neighbours;

@property id userData;

- (id) initWithId:(NSString *) id;
- (void) setPosition: (int)x y:(int) y;
- (BOOL) hasPosition;

- (void) addNeighbour:(Edge*) neighbour;
- (void) removeNeighbour:(Edge *)neighbour;
@end
