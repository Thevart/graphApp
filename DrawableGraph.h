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
@property (readonly) DrawableEdge* selectedEdge;
@property (readonly) DrawableVertex* selectedOrigin;
@property (readonly) DrawableVertex* selectedTarget;
@property (readonly) UIView *graphView;


-(void) switchSelectedEdge: (DrawableEdge*) newOrigin;
-(void) switchSelectedVertex: (DrawableVertex*) newOrigin;

- (DrawableEdge*) edgeAtLocation:(CGPoint) location;
- (DrawableVertex*) vertexAtLocation:(CGPoint) location;

-(void) setNeedsDisplay;
-(void) setNeedsDisplay:(DrawableVertex*) vertex;

@end
