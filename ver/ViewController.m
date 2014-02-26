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
#import "DijkstraInput.h"
#import "GreedyColoringAlgorithm.h"
#import "SVGDumper.h"

@implementation ViewController

@synthesize vertexCountLabel;
@synthesize vertexMenu;
@synthesize edgeMenu;
DrawableVertex *touchedVertex;
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
    [self undisplayVertexMenu];
    [self undisplayEdgeMenu];
    DrawableVertex *retourHitTest=[drawableGraph drawableVertexAtLocation:location];
    if(retourHitTest!=nil){
        [drawableGraph switchSelectedEdge: nil];
        //déselection d'un vertex
        if([retourHitTest.id isEqualToString: touchedVertex.id]){
            [drawableGraph switchSelectedVertex:nil];
            touchedVertex=nil;
            [self undisplayVertexMenu];
        }else if(touchedVertex!=nil){
            //add an edge between touchedVertx and retourHitTest
            DrawableEdge* edge = [[DrawableEdge alloc] initWithVertices:touchedVertex target:retourHitTest];
            [edge setPosition: self.view.frame.size.width y:self.view.frame.size.height];
            [drawableGraph addDrawableEdge:edge];
            [drawableGraph switchSelectedVertex:nil];
            touchedVertex=nil;
            [self undisplayVertexMenu];
        }
        else{
            //selection d'un vertex
            [drawableGraph switchSelectedVertex:retourHitTest];
            touchedVertex=retourHitTest;
            [self displayVertexMenu];
            dragging = YES;
            

        }
    }else{
        touchedEdge = [drawableGraph drawableEdgeAtLocation:location];
        if(touchedEdge){
            [self displayEdgeMenu];
        }
        else{
            DrawableVertex* vertex = [[DrawableVertex alloc] initWithCoord:location.x y:location.y];
            [drawableGraph addDrawableVertex:vertex];
            [drawableGraph switchSelectedVertex:nil];

        }
    }
        
    
    [self.view setNeedsDisplay];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    dragging = NO;

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    [self undisplayVertexMenu];
    if (dragging && touchedVertex!=nil) {
        
        [touchedVertex setPosition:touchLocation.x y:touchLocation.y];
        [drawableGraph setNeedsDisplay];
        [self setNeedsDisplay];
    }
}

- (void) displayVertexMenu
{
    CGRect frame = vertexMenu.frame;
    frame.origin.x = touchedVertex.coord.x+15;
    frame.origin.y = touchedVertex.coord.y+15;
    vertexMenu.frame= frame;
    vertexMenu.enabled=true;
    vertexMenu.hidden=false;
    [self setNeedsDisplay];

}

- (void) undisplayVertexMenu
{
    NSLog(@"In the undisplay;");
    vertexMenu.hidden = true;
    vertexMenu.enabled = false;
    [self setNeedsDisplay];

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



//need to be refactor
-(void) addEdge
{
    DrawableEdge* edge = [[DrawableEdge alloc] initWithVertices:origin target:destination];
    [edge setPosition: self.view.frame.size.width y:self.view.frame.size.height];

    [graph addEdge:edge];

    [self.view addSubview:edge.edgeView];
    [edge.edgeView setNeedsDisplay];

    vertexCountLabel.text = [NSString stringWithFormat: @"You add a edge"];
    origin = nil;
    destination = nil;
}


- (void) viewDidLoad
{
    [super viewDidLoad];

    [self readSampleGraph];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SquGridLandscape.png"]] ;
    touchedVertex=nil;
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
}

- (void) readSampleGraph{
    DrawableEntityFactory* factory = [[DrawableEntityFactory alloc] init];
    GraphParser *parser = [GraphParser create:factory];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"petersen" ofType:@"xgmml"];
    
    graph = [parser parse:path];
    if (graph == nil) {
        graph = [[Graph alloc] init];
    }
    drawableGraph=[[DrawableGraph alloc]init];
    [self.view addSubview:drawableGraph.graphView];
    [self.view sendSubviewToBack:drawableGraph.graphView];
    id<LayoutCreatorProtocol> layoutCreator = [[RandomLayoutCreator alloc] init];
    [layoutCreator createLayout:graph x:self.view.frame.size.width y:self.view.frame.size.height];
    
    // display the loaded vertices
    for (NSString* id in graph.vertices) {
        DrawableVertex* vertex = [graph.vertices objectForKey:id];
        [drawableGraph addDrawableVertex:vertex];
    }
    
    // display the loaded edges
    for (DrawableEdge* edge in graph.edges) {
        [edge setPosition:self.view.frame.size.width y:self.view.frame.size.height];
        [drawableGraph addDrawableEdge:edge];
    }

    SVGDumper* dumper = [[SVGDumper alloc] init];
    NSLog([dumper dump:graph]);
    
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
    [algo execute:graph input:[DijkstraInput createWithVertices:[graph getVertex:@"0"] target:[graph getVertex:@"1"]]];

    NSLog(@"End algorithm");
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


- (IBAction)deleteEdge:(id)sender {
    [drawableGraph removeDrawableEdge:(DrawableEdge*)touchedEdge];
    touchedEdge = nil;
    [self undisplayEdgeMenu];

}

- (IBAction)deleteVertex:(id)sender {
    [drawableGraph removeDrawableVertex:drawableGraph.selectedOrigin];
    [self undisplayEdgeMenu];
    touchedVertex = nil;
    [self undisplayVertexMenu];
    
}
@end
