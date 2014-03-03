//
//  DrawableGraph.m
//  ver
//
//  Created by Arthur Thevenet on 19/02/14.
//
//

#import "DrawableGraph.h"

@interface DrawableGraph()

@property (readwrite) UIView* graphView;

@end

@implementation DrawableGraph

- (id) init
{
    if (self = [super init]) {
        self.graphView = [[UIView alloc] init];
    }

    return self;
}

- (void) addVertex: (Vertex*) vertex
{
    [super addVertex:vertex];

    DrawableVertex* dVertex = (DrawableVertex*) vertex;

    [self.graphView bringSubviewToFront:dVertex.vertexView];
    [self.graphView addSubview:dVertex.vertexView];
}

- (void) removeVertex: (Vertex*) vertex
{
    [super removeVertex:vertex];

    [((DrawableVertex*) vertex).vertexView removeFromSuperview];
}

- (void) _doAddEdge: (Edge*) edge
{
    [super _doAddEdge:edge];

    DrawableEdge* dEdge = (DrawableEdge*) edge;

    [self.graphView addSubview:dEdge.edgeView];
    [self.graphView sendSubviewToBack:dEdge.edgeView];
    [dEdge.edgeView setNeedsDisplay];
}

- (void) _doRemoveEdge: (Edge*) edge
{
    [super _doRemoveEdge:edge];

    [((DrawableEdge*) edge).edgeView removeFromSuperview];
}

/*****Hit test Method of the DrawableGraph*******/

- (DrawableEdge*) edgeAtLocation:(CGPoint) location
{
    for (DrawableEdge* edge in self.edges) {
        if ([edge.edgeView containPoint:location]) {
            return edge;
        }
    }

    return nil;
}

- (DrawableVertex*) vertexAtLocation:(CGPoint) location
{
    DrawableVertex* vertex = nil;

    for (NSString* id in self.vertices) {
        vertex = [self.vertices objectForKey:id];

        if (CGRectContainsPoint(vertex.vertexView.frame,location)) {
            return vertex;
        }
    }
    return nil;
}


-(void) setNeedsDisplay
{
    [self.graphView.subviews makeObjectsPerformSelector:@selector(setNeedsDisplay)];
    [self.graphView setNeedsDisplay];
}

@end

