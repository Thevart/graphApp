//
//  DrawableGraph.m
//  ver
//
//  Created by Arthur Thevenet on 19/02/14.
//
//

#import "DrawableGraph.h"

@interface DrawableGraph()

@property (readwrite) DrawableVertex* selectedOrigin;
@property (readwrite) DrawableEdge* selectedEdge;
@property (readwrite) UIView* graphView;

@end

@implementation DrawableGraph

- (id) init
{
    if (self = [super init]) {
        self.graphView = [[UIView alloc] init];
        self.selectedOrigin = [[DrawableVertex alloc] init];
        self.selectedEdge = [[DrawableEdge alloc] init];
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


/******Color changing Method*******/
-(void) switchSelectedVertex: (DrawableVertex*) newOrigin
{
    if (newOrigin != nil) {
        [newOrigin setColor:[Color initFromRGB:0 g:0 b:255]];
        [self switchSelectedEdge:nil];
    }

    [self.selectedOrigin setColor:[Color initFromRGB:255 g:0 b:0]];
    self.selectedOrigin = newOrigin;
    [self.graphView setNeedsDisplay];
}

-(void) switchSelectedEdge: (DrawableEdge*) drawEdge
{
    if (drawEdge != nil) {
        drawEdge.edgeView.color = [UIColor colorWithRed:255.0/255.0 green: 0.0/255.0 blue: 0.0/255.0 alpha: 1.0];

        [drawEdge.edgeView setNeedsDisplay];
        [self switchSelectedVertex:nil];
    }

    self.selectedEdge.edgeView.color = [UIColor colorWithRed:0.0/255.0 green: 0.0/255.0 blue: 255.0/255.0 alpha: 1.0];
    [self.selectedEdge.edgeView setNeedsDisplay];
    self.selectedEdge = drawEdge;
}

/*****Hit test Method of the DrawableGraph*******/
- (DrawableEdge*) edgeAtLocation: (CGPoint) location
{
    DrawableEdge *realEdge = nil;
    for (DrawableEdge* edge in self.edges) {
        if ([edge.edgeView containPoint:location]) {
            return edge;
        }
    }
    return realEdge;
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

-(void) setNeedsDisplay:(DrawableVertex*) vertex
{
    for (DrawableEdge *edge in vertex.neighbours) {
        [edge.edgeView setNeedsDisplay];
    }
}

-(void) setNeedsDisplay {
    [self.graphView.subviews makeObjectsPerformSelector:@selector(setNeedsDisplay)];
    [self.graphView setNeedsDisplay];
}

@end

