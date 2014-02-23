//
//  ViewController.m
//  ver
//
//  Created by Michel Martin on 20/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#include <stdlib.h>
#import "ViewController.h"
#import "DrawableVertex.h"
#import "DrawableEdge.h"
#import "Vertex.h"
#import "DrawableEntityFactory.h"
#import "GraphParser.h"
#import "DumperProtocol.h"
#import "LayoutCreatorProtocol.h"
#import "RandomLayoutCreator.h"
#import "AlgorithmProtocol.h"
#import "DijkstraAlgorithm.h"
#import "GreedyColoringAlgorithm.h"
#import "DotDumper.h"

@implementation ViewController

@synthesize vertexCountLabel;
@synthesize vertexMenu;
@synthesize edgeMenu;
BOOL dragging;
float oldX, oldY;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    //you touched the deleteVertexButton

    if(CGRectContainsPoint(vertexMenu.frame,location)){
        [self deleteVertex];
        [self undisplayEdgeMenu];
    
    }
    else if (CGRectContainsPoint(edgeMenu.frame, location)){
        [self deleteEdge];
    }
    else{
        touchedEdge = [self edgeAtLocation:location];
        touchedVertex = [self vertexAtLocation:location];
        //if we touched a Vertex
        if(touchedVertex!=nil){
            if(origin!=nil){
                //we add a edge if origin=-destination
                if([origin.id isEqual:touchedVertex.id]){
                    origin=nil;
                    [self undisplayVertexMenu];
                }
                else{
                    destination=touchedVertex;
                    [self undisplayVertexMenu];
                    [self addEdge];
                }
            }
            else{
                origin=touchedVertex;
                [self displayVertexMenu];
            }
            [self changeColor];
            dragging = YES;
            oldX=location.x;
            oldY=location.y;
        
            touchedEdge=nil;
        
            [self changeEdgeColor];
            [self undisplayEdgeMenu];
        }
        else if(touchedVertex==nil && dragging==NO && touchedEdge!=nil){
        
            [self changeEdgeColor];
            [self displayEdgeMenu];
            [self setNeedsDisplay];

        
        }else {
            
            touchedEdge=nil;
            [self addVertex:location.x y:location.y];
            origin = nil;
            destination = nil;
            [self changeColor];
        
            [self changeEdgeColor];
            [self undisplayVertexMenu];
            [self undisplayEdgeMenu];
        }
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    dragging = NO;
    touchedVertex = nil;
}
-(void) changeEdgeColor
{
    UIColor* color;

    NSArray *edges = [[NSArray alloc] initWithArray:graph.edges];
    for (DrawableEdge* edge in edges) {
        
        if ([edge.origin.id isEqualToString:touchedEdge.origin.id] && [edge.target.id isEqualToString:touchedEdge.target.id]) {
            color = [UIColor colorWithRed:255.0/255.0 green: 0.0/255.0 blue: 0.0/255.0 alpha: 1.0];
        }else {
            color = [UIColor colorWithRed:0.0/255.0 green: 0.0/255.0 blue: 255.0/255.0 alpha: 1.0];
        }
        
        edge.edgeView.color = color;
       		
        [self setNeedsDisplay];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];

    // modify the coordinates of the vertex and the edges while your finger is moving
    if (dragging && touchedVertex!=nil) {
        [self undisplayVertexMenu];
        [touchedVertex setPosition:touchLocation.x y:touchLocation.y];
        [self setNeedsDisplay];
    }
}


- (DrawableVertex*) vertexAtLocation:(CGPoint) location
{
    DrawableVertex* realVertex = nil;
    DrawableVertex* vertex ;
    for (NSString* id in graph.vertices) {
        vertex=[graph.vertices objectForKey:id];
        if (CGRectContainsPoint(vertex.vertexView.frame,location)) {
            vertexCountLabel.text = [NSString stringWithFormat: @"You touch my VertexTrala"];
            realVertex = vertex;
        }
    }
    
    return realVertex;
}

- (Edge*) edgeAtLocation:(CGPoint) location{
    Edge *realEdge=nil;
    NSArray *edgesToDelete = [[NSArray alloc] initWithArray:graph.edges];
    
    for (Edge* edge in edgesToDelete) {
        int xE=edge.origin.coord.x;
        int xB=edge.target.coord.x;
        int yE=edge.origin.coord.y;
        int yB=edge.target.coord.y;
        int xM=location.x;
        int yM=location.y;
        /*if(edge.origin.coord.xedge.target.coord.x){
            xE=edge.origin.coord.x;
            xB=edge.target.coord.x;
            yE=edge.origin.coord.y;
            yB=edge.target.coord.y;
        }else{
            xE=edge.target.coord.x;
            xB=edge.origin.coord.x;
            yE=edge.target.coord.y;
            yB=edge.origin.coord.y;
        }*/
        float s;
        // coordonnées a,b du vecteur EB
        int a=xE-xB;
        int b=yE-yB;
// équation de la perpendiculaire D1 en B à (EB): ax+by+w1
        int w1=-a*xB-b*yB;
// équation de la perpendiculaire D2 en E à (EB): ax+by+w2
        int w2=-a*xE-b*yE;
// équation de la droite (EB) : bx-ay+w3
        int w3= a*yB-b*xB;
//puissance de M par rapport à D1
        int PMD1=a*xM+b*yM+w1;
// puissance de M par rapport à D2
        int PMD2=a*xM+b*yM+w2;
        //puissance de B par rapport à D2
        int PBD2=a*xB+b*yB+w2;
//puissance de E par rapport à D1
        int PED1=a*xE+b*yE+w1;
// A ce stade encore ni racine ni quotient
        if (PMD1*PED1 <0){//M et E de part et d'autre de D1
            s= sqrt((xM-xB)*(xM-xB)+(yM-yB)*(yM-yB));
        }
        else if (PMD2*PBD2 <0){ //#M et B de part et d'autre de D2
            s= sqrt((xM-xE)*(xM-xE)+(yM-yE)*(yM-yE));
        }else{
            s=abs(b*xM-a*yM+w3)/sqrt(a*a+b*b);
        }
        if(s<10){
            realEdge=edge;
        }

        
    }
    return realEdge;
}

- (void) displayVertexMenu
{
    CGRect frame = vertexMenu.frame;
    frame.origin.x = origin.coord.x+15;
    frame.origin.y = origin.coord.y+15;
    vertexMenu.frame= frame;
    vertexMenu.enabled=true;
    vertexMenu.hidden=false;
    [self setNeedsDisplay];
}

- (void) undisplayVertexMenu
{
    vertexMenu.hidden = true;
    vertexMenu.enabled = false;
}
- (void) displayEdgeMenu
{
    CGRect frame = edgeMenu.frame;
    frame.origin.x = (touchedEdge.origin.coord.x+touchedEdge.target.coord.x)/2+15;
    
    frame.origin.y = (touchedEdge.origin.coord.y+touchedEdge.target.coord.y)/2+15;
    edgeMenu.frame= frame;
    edgeMenu.enabled=true;
    edgeMenu.hidden=false;
    [self setNeedsDisplay];
}
- (void) undisplayEdgeMenu
{
    edgeMenu.hidden = true;
    edgeMenu.enabled = false;
}

//must be called each time you touche the screen
- (void) changeColor
{
    UIColor *color;
    DrawableVertex* vertex;

    for (NSString* id in graph.vertices) {
        vertex = [graph.vertices objectForKey:id];

        if ([vertex.id isEqual:origin.id]) {
            color = [UIColor colorWithRed:255.0/255.0 green: 0.0/255.0 blue: 0.0/255.0 alpha: 1.0];
        } else if ([vertex.id isEqual:destination.id]) {
            color = [UIColor colorWithRed:197.0/255.0 green: 259.0/255.0 blue: 40.0/255.0 alpha: 1.0];
        } else {
            color = [UIColor colorWithRed:0.0/255.0 green: 136.0/255.0 blue: 255.0/255.0 alpha: 1.0];
        }

        vertex.vertexView.color = color;
        [self setNeedsDisplay];
    }
}

//need to be refactor
-(void) addEdge
{
    DrawableEdge* edge = [[DrawableEdge alloc] initWithVertices:origin target:destination];
    [edge setPosition: self.view.frame.size.width y:self.view.frame.size.height];

    [graph addEdge:edge];

    [self.view addSubview:edge.edgeView];
    [self.view sendSubviewToBack:edge.edgeView];
    [edge.edgeView setNeedsDisplay];

    vertexCountLabel.text = [NSString stringWithFormat: @"You add a edge"];
    origin = nil;
    destination = nil;
}

- (void) addVertex:(int) x y:(int) y
{
    DrawableVertex* vertex = [[DrawableVertex alloc] initWithCoord:x y:y];
    [graph addVertex:vertex];
    [self.view addSubview:vertex.vertexView];
    [self.view bringSubviewToFront:vertex.vertexView];
    
    [self setNeedsDisplay];
    vertexCountLabel.text = [NSString stringWithFormat: @" %i ...", [graph.vertices count]];
}

- (void) deleteVertex
{

    DrawableVertex *removedVertex = (DrawableVertex*) [graph getVertex:origin.id];
    [removedVertex.vertexView removeFromSuperview];
    NSLog(@"i delete a vertex");
    NSArray *edgesToDelete = [[NSArray alloc] initWithArray:graph.edges];
    
    for (Edge* edge in edgesToDelete) {
        if ([edge.origin.id isEqualToString:origin.id] || [edge.target.id isEqualToString:origin.id]) {
            DrawableEdge *edgeToRemove = (DrawableEdge *) edge;
            [edgeToRemove.edgeView removeFromSuperview];
        }
    }

    [graph removeVertex:origin];
    [self undisplayEdgeMenu];
    origin = nil;
}
-(void) deleteEdge
{
    NSLog(@"coord oroigin touchedEdge : %d",  touchedEdge.origin.coord.x);
        NSArray *edgesToDelete = [[NSArray alloc] initWithArray:graph.edges];
    for (Edge* edge in edgesToDelete) {
        if ([edge.origin.id isEqualToString:touchedEdge.origin.id] && [edge.target.id isEqualToString:touchedEdge.target.id]) {
            DrawableEdge *edgeToRemove = (DrawableEdge *) edge;
            [edgeToRemove.edgeView removeFromSuperview];
            [graph removeEdge:touchedEdge];

	        }
    }

    touchedEdge=nil;
        [self undisplayEdgeMenu];

}
- (void) viewDidLoad
{
    [super viewDidLoad];

    [self readSampleGraph];
}

- (void) readSampleGraph
{
    DrawableEntityFactory* factory = [[DrawableEntityFactory alloc] init];
    GraphParser *parser = [GraphParser create:factory];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"graph" ofType:@"xgmml"];

    graph = [parser parse:path];

    // the file could not be read (no parser found, error opening it, ...)
    if (graph == nil) {
        graph = [[Graph alloc] init];
    }

    // fix the layout
    id<LayoutCreatorProtocol> layoutCreator = [[RandomLayoutCreator alloc] init];
    [layoutCreator createLayout:graph x:self.view.frame.size.width y:self.view.frame.size.height];

    // display the loaded vertices
    for (NSString* id in graph.vertices) {
        DrawableVertex* vertex = [graph.vertices objectForKey:id];
        [self.view addSubview:vertex.vertexView];
        [self.view bringSubviewToFront:vertex.vertexView];
    }

    // display the loaded edges
    for (DrawableEdge* edge in graph.edges) {
        [edge setPosition:self.view.frame.size.width y:self.view.frame.size.height];
        [self.view addSubview:edge.edgeView];
         [self.view sendSubviewToBack:edge.edgeView];
        NSLog(@"coord x origin : %d", edge.origin.coord.x);
    }

    //[graph removeVertex:[graph getVertex:@"1"]];

    // test for graph dumpers
    id<DumperProtocol> dumper = [[DotDumper alloc] init];
    //NSLog([dumper dump:graph]);

    // and start a computation
    NSThread* thread = [[NSThread alloc] initWithTarget:self
                                                 selector:@selector(threadedComputation:)
                                                   object:nil];
    [thread start];
}

- (void) threadedComputation: (id) args	
{
    //id<AlgorithmProtocol> algo = [[DijkstraAlgorithm alloc] init];
    id<AlgorithmProtocol> algo = [[GreedyColoringAlgorithm alloc] init];
    [algo execute:graph];

    NSLog(@"End");
}

- (void) viewDidUnload
{
    [super viewDidUnload];

    self.vertexCountLabel = nil;
    graph = nil;
    origin=nil;
    destination=nil;
    

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void) setNeedsDisplay {

    [self.view.subviews makeObjectsPerformSelector:@selector(setNeedsDisplay)];
    [super.view setNeedsDisplay];
}


@end
