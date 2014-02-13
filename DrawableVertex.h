//
//  DrawableVertex.h
//  ver
//
//  Created by Kévin Gomez on 09/02/14.
//
//
#import <Foundation/Foundation.h>

#import "Vertex.h"
#import "VertexView.h"

@interface DrawableVertex : Vertex
@property (readonly) VertexView* vertexView;
- (id) initWithCoord:(int)x y:(int)y;
- (void) setPosition: (int)x y:(int) y;
@end