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

@end
@implementation DrawableGraph

- (id) init{
    if (self = [super init]) {
        
    }
    
    return self;

}
- (void) addDrawableVertex : (DrawableVertex*) vertex{
    NSLog(@"We add a vertex");
    [self.drawableVertices setValue:vertex forKey:vertex.id];
    [super addVertex:vertex];

}

- (void) removeDrawableVertex : (DrawableVertex*) drawvertex{
    NSLog(@"We delete a vertex");
    [drawvertex.vertexView removeFromSuperview];
    for (DrawableEdge* edge in drawvertex.neighbours) {
        [self removeDrawableEdge:edge];
    }
    [self.drawableVertices removeObjectForKey:drawvertex.id];
    [super removeVertex:drawvertex];
}


- (void) addDrawableEdge: (DrawableEdge*) edge{
    NSLog(@"We add a edge");
    [self.drawableEdges addObject:edge];
    [super addEdge:edge];

}

- (void) removeDrawableEdge : (DrawableEdge*) drawedge{
    NSLog(@"We remove a edge");
    [drawedge.edgeView removeFromSuperview];
    [self.drawableEdges removeObject:drawedge];
}


/******Color changing Method*******/
-(void) switchSelectedVertex: (DrawableVertex*) newOrigin{
    if(newOrigin!=nil){
        newOrigin.color=[Color initFromRGB:0 g:136 b:255];
    }
    self.selectedOrigin.color=[Color initFromRGB:255 g:0 b:0];
    self.selectedOrigin=newOrigin;
    [self switchSelectedEdge:nil];
}

-(void) switchSelectedEdge : (DrawableEdge*)drawEdge{
    if(drawEdge!=nil){
        drawEdge.edgeView.color=[UIColor colorWithRed:255.0/255.0 green: 0.0/255.0 blue: 0.0/255.0 alpha: 1.0];
    }
    self.selectedEdge.edgeView.color=[UIColor colorWithRed:0.0/255.0 green: 0.0/255.0 blue: 255.0/255.0 alpha: 1.0];
    self.selectedEdge=drawEdge;
    [self switchSelectedVertex:nil];
}

/*****Hit test Method of the DrawableGraph*******/
- (Edge*) edgeAtLocation:(CGPoint) location{
    Edge *realEdge=nil;
    for (DrawableEdge* edge in self.drawableEdges) {
        if([edge.edgeView containPoint: location]){
            realEdge=edge;
        }
    }
    return realEdge;
}

- (DrawableVertex*) vertexAtLocation:(CGPoint) location{
    DrawableVertex* realVertex = nil;
    for(DrawableVertex* vertex in self.drawableVertices)
    {
        if (CGRectContainsPoint(vertex.vertexView.frame,location)) {
            realVertex = vertex;
        }
    }
    return realVertex;
}

@end

