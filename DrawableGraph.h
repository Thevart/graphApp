//
//  DrawableGraph.h
//  ver
//
//  Created by Arthur Thevenet on 19/02/14.
//
//

#import "Graph.h"
#import "DrawableEdge.h"
#import "DrawableVertex.h"

@interface DrawableGraph : Graph

@property (readonly) UIView *graphView;

- (DrawableEdge*) edgeAtLocation:(CGPoint) location;
- (DrawableVertex*) vertexAtLocation:(CGPoint) location;

-(void) setNeedsDisplay;

@end
