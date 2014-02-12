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


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];

    Vertex *touchedVertex=[self hasCollisioned:location];
    
    //if we touched a Vertex
    if(touchedVertex!=nil){
        if(origin!=nil){
            if([origin.id isEqual:touchedVertex.id]){
                origin=nil;
                [self changeColor];
            }
            else{
                destination=touchedVertex;
                [self changeColor];
                //[self addEdge];
            }
        }
        else{
            origin=touchedVertex;
        }

    }
    else{
        [self addVertex:location.x y:location.y];
        origin=nil;
        destination=nil;
        [self changeColor];
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
            
            color = [UIColor colorWithRed:300.0/255.0 green: 350.0/255.0 blue: 140.0/255.0 alpha: 1.0];
            vertex.view.backgroundColor=color;
        } 
        else if([vertex.id isEqual:destination.id])
        {
            color = [UIColor colorWithRed:197.0/255.0 green: 259.0/255.0 blue: 40.0/255.0 alpha: 1.0];
            vertex.view.backgroundColor=color;
            
        }
        else{
            color = [UIColor colorWithRed:197.0/255.0 green: 169.0/255.0 blue: 140.0/255.0 alpha: 1.0];
            vertex.view.backgroundColor=color;

        }
    }
}

-(void) addEdge
{
    NSLog(@"you add a destination");
    DrawableEdge* edge = [[DrawableEdge alloc] initWithFrame:self.view.bounds];
    [graph addEdge:edge];
    
    [self.view addSubview:edge.view];
    [edge.view setNeedsDisplay];
    vertexCountLabel.text = [NSString stringWithFormat: @"You add a fucking edge"];
    origin=nil;		
    destination=nil;
    
}
- (void) addVertex:(int) x y:(int) y
{
    DrawableVertex* vertex = [[DrawableVertex alloc] init];
    [vertex setPosition: x y:y];

    NSLog(@"x %d; y %d", x, y);

    // add the vertex to the graph
    [graph addVertex:vertex];

    // draw it
    [self.view addSubview:vertex.view];

    // and update the vertex count text
    vertexCountLabel.text = [NSString stringWithFormat: @"%i ...", [graph.vertices count]];
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
    NSString* path = [[NSBundle mainBundle] pathForResource:@"graph"
                                                     ofType:@"xgmml"];

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

@end
