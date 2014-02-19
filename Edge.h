//
//  Edge.h
//  GraphModel
//
//  Created by Arthur THEVENET on 1/30/14.
//  Copyright (c) 2014 Arthur THEVENET. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vertex.h"

@interface Edge : NSObject

@property NSString* label;
@property Vertex* origin;
@property Vertex* target;
@property int weight;

- (id)initWithVertices:(Vertex *) origin target:(Vertex *) target;
@end
