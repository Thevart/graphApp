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

    touchedVertex=[self hasCollisioned:location];
    
    //if we touched a Vertex
    if(touchedVertex!=nil){
        if(origin!=nil){
            if([origin.id isEqual:touchedVertex.id]){
                origin=nil;
  
            }
            else{
                destination=touchedVertex;
                [self addEdge];
            }
        }
        else{
            origin=touchedVertex;
        }
              [self changeColor];
        dragging = YES;
    }
    else{
        [self addVertex:location.x y:location.y];
        origin=nil;
        destination=nil;
        [self changeColor];
        
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    dragging = NO;
    touchedVertex=nil;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:touch.view];
    NSLog(@"In the dragging mode");

        if (dragging && touchedVertex!=nil) {
            DrawableVertex *vertex=[graph.vertices objectForKey:touchedVertex.id];
                [vertex setPosition: (int)touchLocation.x y:(int)touchLocation.y];
    }
    
}

-(Vertex*)hasCollisioned:(CGPoint )location{
    Vertex* realVertex=nil;
    for(NSString *id in graph.vertices){
        DrawableVertex* vertex = [graph.vertices objectForKey:id];
        if(CGRectContainsPoint(vertex.view.frame,location))
        {
            vertexCountLabel.text = [NSString stringWithFormat: @"You touch my trala"];
            realVertex=[graph.vertices objectForKey:id];
        }
    }
    
    return realVertex;
}

//must be called each time you touche the screen
-(void)changeColor
{
    UIColor *color;
    DrawableVertex* vertex;
    for(NSString *id in graph.vertices){
        vertex=[graph.vertices objectForKey:id];
        if([vertex.id isEqual:origin.id])
        {
            
            color = [UIColor colorWithRed:255.0/255.0 green: 0.0/255.0 blue: 0.0/255.0 alpha: 1.0];
            vertex.view.backgroundColor=color;
        } 
        else if([vertex.id isEqual:destination.id])
        {
            color = [UIColor colorWithRed:197.0/255.0 green: 259.0/255.0 blue: 40.0/255.0 alpha: 1.0];
            vertex.view.backgroundColor=color;
            
        }
        else{
             UIColor *color = [UIColor colorWithRed:0.0/255.0 green: 136.0/255.0 blue: 255.0/255.0 alpha: 1.0];
            vertex.view.backgroundColor=color;

        }
    }
}

-(void) addEdge
{
    NSLog(@"you have added a destination");
    DrawableEdge* edge = [[DrawableEdge alloc] initWithCoord:self.view.frame.size.width y:self.view.frame.size.height];
    [graph addEdge:edge];
    [edge.edgeView setPosition: origin.coord destination:destination.coord];
        [self.view addSubview:edge.edgeView];
        [edge.edgeView setNeedsDisplay];


    vertexCountLabel.text = [NSString stringWithFormat: @"You add a fucking edge"];
    origin=nil;		
    destination=nil;
    
}
- (void) addVertex:(int) x y:(int) y
{
    DrawableVertex* vertex = [[DrawableVertex alloc] init];
    [vertex setPosition: x y:y];

    NSLog(@"Vertex added at x %d; y %d", x, y);
  NSLog(@"Nb of vertex %d",graph.vertices.count);
    // add the vertex to the graph
    [graph addVertex:vertex];

    // draw it
    [self.view addSubview:vertex.view];
    
    // and update the vertex count text
    vertexCountLabel.text = [NSString stringWithFormat: @" %i ...", [graph.vertices count]];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    graph = [[Graph alloc] init];
    //[self readSampleGraph];
}

/*- (void) readSampleGraph
{
    DrawableEntityFactory* factory = [[DrawableEntityFactory alloc] init];
    GraphParser *parser = [GraphParser create:factory];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"graph" ofType:@"graphml"];

    graph = [parser parse:path];

    // the file could not be read (no parser found, error opening it, ...)
    if (graph == nil) {
        graph = [[Graph alloc] init];
    }

    // display the loaded vertices
    for (NSString* id in graph.vertices) {
        DrawableVertex* vertex = [graph.vertices objectForKey:id];
        [self.view addSubview:vertex.view];
    }
}*/

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

@end
