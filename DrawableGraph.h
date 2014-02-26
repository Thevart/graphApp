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
@property (readonly) NSMutableDictionary* drawableVertices;
@property (readonly) NSMutableArray* drawableEdges;
@property (readonly) DrawableEdge* selectedEdge;
@property (readonly) DrawableVertex* selectedOrigin;
@property (readonly) DrawableVertex* selectedTarget;
@property (readonly) UIView *graphView;



- (void) addDrawableVertex : (DrawableVertex*) vertex;
- (void) removeDrawableVertex : (DrawableVertex*) vertex;

- (void) addDrawableEdge: (DrawableEdge*) edge;
- (void) removeDrawableEdge : (DrawableEdge*) edge;
-(void) switchSelectedEdge: (DrawableEdge*) newOrigin;
-(void) switchSelectedVertex: (DrawableVertex*) newOrigin;

- (DrawableEdge*) drawableEdgeAtLocation:(CGPoint) location;
- (DrawableVertex*) drawableVertexAtLocation:(CGPoint) location;

-(void) setNeedsDisplay;

@end
