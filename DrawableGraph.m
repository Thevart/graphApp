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
@property (readwrite) NSMutableDictionary* drawableVertices;
@property (readwrite) NSMutableArray* drawableEdges;

@end
@implementation DrawableGraph

- (id) init{
    if (self = [super init]) {
        self.graphView=[[UIView alloc] init];
        self.drawableVertices = [[NSMutableDictionary alloc] init];
        self.drawableEdges = [[NSMutableArray alloc] init];
        self.selectedOrigin=[[DrawableVertex alloc]init];
        self.selectedEdge=[[DrawableEdge alloc]init];
    }
    
    return self;

}
- (void) addDrawableVertex : (DrawableVertex*) vertex{
    NSLog(@"We add a vertex");
    [self.drawableVertices setValue:vertex forKey:vertex.id];
    [super addVertex:vertex];
    [self.graphView bringSubviewToFront:vertex.vertexView];

    [self.graphView addSubview:vertex.vertexView];

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
    [self.graphView addSubview:edge.edgeView];
    [self.graphView sendSubviewToBack:edge.edgeView];


}

- (void) removeDrawableEdge : (DrawableEdge*) drawedge{
    NSLog(@"We remove a edge");
    [drawedge.edgeView removeFromSuperview];
    [self.drawableEdges removeObject:drawedge];
}


/******Color changing Method*******/
-(void) switchSelectedVertex: (DrawableVertex*) newOrigin{
    if(newOrigin!=nil){
        [newOrigin setColor:[Color initFromRGB:0 g:0 b:255]];
        [self switchSelectedEdge:nil];
    }
    [self.selectedOrigin setColor:[Color initFromRGB:255 g:0 b:0]];
    self.selectedOrigin=newOrigin;
    [self.graphView setNeedsDisplay];
}

-(void) switchSelectedEdge : (DrawableEdge*)drawEdge{
    if(drawEdge!=nil){
        drawEdge.edgeView.color=[UIColor colorWithRed:255.0/255.0 green: 0.0/255.0 blue: 0.0/255.0 alpha: 1.0];
        [drawEdge.edgeView setNeedsDisplay];
        [self switchSelectedVertex:nil];
    }
    self.selectedEdge.edgeView.color=[UIColor colorWithRed:0.0/255.0 green: 0.0/255.0 blue: 255.0/255.0 alpha: 1.0];
    [self.selectedEdge.edgeView setNeedsDisplay];
    self.selectedEdge=drawEdge;
}

/*****Hit test Method of the DrawableGraph*******/
- (DrawableEdge*) drawableEdgeAtLocation:(CGPoint) location{
    DrawableEdge *realEdge=nil;
    for (DrawableEdge* edge in self.drawableEdges) {
        if([edge.edgeView containPoint: location]){
            NSLog(@"We detetect that you touched a edge.");
            [self switchSelectedEdge:edge];
            return edge;
        }
    }
    return realEdge;
}

- (DrawableVertex*) drawableVertexAtLocation:(CGPoint) location{
    DrawableVertex* vertex = nil;

    for(NSString* id in self.drawableVertices)
    {
        vertex=[self.drawableVertices objectForKey:id];
        if (CGRectContainsPoint(vertex.vertexView.frame,location)) {
            NSLog(@"We detetect that you touched a vertex.");
            if([vertex isEqual:self.selectedOrigin]){
                [self switchSelectedVertex:nil];
                
            }
            else{
                [self switchSelectedVertex:vertex];
            }
            return vertex;

            
        }
    }
    return nil;
}
-(void) setNeedsDisplay {
    
    [self.graphView.subviews makeObjectsPerformSelector:@selector(setNeedsDisplay)];
    [self.graphView setNeedsDisplay];
}

@end

