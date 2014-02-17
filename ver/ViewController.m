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
#import "DotDumper.h"

@implementation ViewController

@synthesize vertexCountLabel;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle
BOOL dragging;

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];

    touchedVertex = [self hasCollisioned:location];
    
    // if we touched a Vertex
    if (touchedVertex != nil) {
        if (origin != nil) {
            if ([origin.id isEqual:touchedVertex.id]) {
                origin = nil;
            } else {
                destination = touchedVertex;
                [self addEdge];
            }
        } else {
            origin = touchedVertex;
        }

        [self changeColor];
        dragging = YES;
    } else {
        [self addVertex:location.x y:location.y];
        origin = nil;
        destination = nil;
        [self changeColor];
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    dragging = NO;
    touchedVertex = nil;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    DrawableVertex *vertex;
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:touch.view];

    // modify the coordinates of the vertex and the edges while your finger is moving
    if (dragging && touchedVertex != nil) {
        vertex = [graph.vertices objectForKey:touchedVertex.id];

        [vertex setPosition: (int)touchLocation.x-15 y:(int)touchLocation.y-15];
        [self setNeedsDisplay];
    }
}

-(Vertex*) hasCollisioned:(CGPoint) location
{
    Vertex* realVertex = nil;

    for (NSString* id in graph.vertices) {
        DrawableVertex* vertex = [graph.vertices objectForKey:id];

        if (CGRectContainsPoint(vertex.vertexView.frame,location)) {
            vertexCountLabel.text = [NSString stringWithFormat: @"You touch my trala"];
            realVertex = [graph.vertices objectForKey:id];
        }
    }
    
    return realVertex;
}

// must be called each time you touche the screen
-(void) changeColor
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

-(void) addEdge
{
    NSLog(@"you have added a destination");
    DrawableEdge* edge = [[DrawableEdge alloc] initWithVertices:origin destination:destination];

    [edge setPosition:self.view.frame.size.width y:self.view.frame.size.height];
    [graph addEdge:edge];

    [self.view addSubview:edge.edgeView];

    vertexCountLabel.text = [NSString stringWithFormat: @"You add a fucking edge"];
    origin = nil;
    destination = nil;
}

- (void) addVertex:(int) x y:(int) y
{
    DrawableVertex* vertex = [[DrawableVertex alloc] initWithCoord:x y:y];
    [graph addVertex:vertex];

    [self.view addSubview:vertex.vertexView];
    // and update the vertex count text
    [self setNeedsDisplay];
    NSLog(@"%f", vertex.vertexView.center.y);
    vertexCountLabel.text = [NSString stringWithFormat: @" %i ...", [graph.vertices count]];
    NSLog(@"Nb of subView %d", self.view.subviews.count);
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    graph = [[Graph alloc] init];
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
    }

    // display the loaded edges
    for (DrawableEdge* edge in graph.edges) {
        [edge setPosition:self.view.frame.size.width y:self.view.frame.size.height];
        [self.view addSubview:edge.edgeView];
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
    id<AlgorithmProtocol> algo = [[DijkstraAlgorithm alloc] init];
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
