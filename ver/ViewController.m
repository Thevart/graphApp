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
#import "XGMMLParser.h"
#import "GraphMLParser.h"
#import "GEXFParser.h"
#import "DrawableEntityFactory.h"

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

    graph = [[Graph alloc] init];

    //[self readDummyGexfGraph];
}

- (void) readDummyGraphmlGraph
{
    NSString* graphMLSample = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
    "<graphml xmlns=\"http://graphml.graphdrawing.org/xmlns\""
    "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
    "xsi:schemaLocation=\"http://graphml.graphdrawing.org/xmlns http://graphml.graphdrawing.org/xmlns/1.0/graphml.xsd\">"
    "<graph id=\"G\" edgedefault=\"undirected\">"
    "<node id=\"n0\"/>"
    "<node id=\"n1\"/>"
    "<edge id=\"e1\" source=\"n0\" target=\"n1\"/>"
    "</graph>"
    "</graphml>";
    NSData* graphMLSampleData = [graphMLSample dataUsingEncoding:NSUTF8StringEncoding];
    DrawableEntityFactory* factory = [[DrawableEntityFactory alloc] init];
    GraphMLParser *parser = [[GraphMLParser alloc] initWithData:graphMLSampleData factory:factory];

    graph = [parser parse];

    // display the loaded vertices
    for(NSString* id in graph.vertices) {
        DrawableVertex* vertex = [graph.vertices objectForKey:id];
        [self.view addSubview:vertex.view];
    }
    
}

- (void) readDummyGexfGraph
{
    NSString* gexfSample = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
    "<gexf xmlns=\"http://www.gexf.net/1.2draft\" version=\"1.2\">"
    "<meta lastmodifieddate=\"2009-03-20\">"
    "<creator>Gexf.net</creator>"
    "<description>A hello world! file</description>"
    "</meta>"
    "<graph mode=\"static\" defaultedgetype=\"directed\">"
    "<nodes>"
    "<node id=\"0\" label=\"Hello\" />"
    "<node id=\"1\" label=\"Word\" />"
    "</nodes>"
    "<edges>"
    "<edge id=\"0\" source=\"0\" target=\"1\" />"
    "</edges>"
    "</graph>"
    "</gexf>";
    NSData* gexfSampleData = [gexfSample dataUsingEncoding:NSUTF8StringEncoding];
    DrawableEntityFactory* factory = [[DrawableEntityFactory alloc] init];
    GEXFParser *parser = [[GEXFParser alloc] initWithData:gexfSampleData factory:factory];

    graph = [parser parse];

    // display the loaded vertices
    for(NSString* id in graph.vertices) {
        DrawableVertex* vertex = [graph.vertices objectForKey:id];
        [self.view addSubview:vertex.view];
    }
}

- (void) readDummyXgmmlGraph
{
    NSString* xggmlSample = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
    "<graph label=\"small example\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\""
    "xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\""
    "xmlns:cy=\"http://www.cytoscape.org\" xmlns=\"http://www.cs.rpi.edu/XGMML\""
    "directed=\"1\">"
    "<node label=\"A\" id=\"1\">"
    "<att name=\"size\" type=\"integer\" value=\"24\"/>"
    "<att name=\"confirmed\" type=\"boolean\" value=\"true\"/>"
    "<att name=\"weight\" type=\"integer\" value=\"42\"/>"
    "<layout x=\"208\" y=\"312\" />"
    "</node>"
    "<node label=\"B\" id=\"2\">"
    "<att name=\"size\" type=\"integer\" value=\"16\"/>"
    "<att name=\"confirmed\" type=\"boolean\" value=\"false\"/>"
    "<layout x=\"181\" y=\"217\" />"
    "</node>"
    "<node label=\"C\" id=\"3\">"
    "<att name=\"size\" type=\"integer\" value=\"13\"/>"
    "<att name=\"confirmed\" type=\"boolean\" value=\"true\"/>"
    "<layout x=\"84\" y=\"281\" />"
    "</node>"
    "<edge label=\"A-B\" source=\"1\" target=\"2\">"
    "<att name=\"weight\" type=\"integer\" value=\"7\"/>"
    "</edge>"
    "<edge label=\"B-C\" source=\"2\" target=\"3\">"
    "<att name=\"weight\" type=\"integer\" value=\"8\"/>"
    "</edge>"
    "<edge label=\"C-A\" source=\"3\" target=\"1\">"
    "<att name=\"weight\" type=\"integer\" value=\"4\"/>"
    "</edge>"
    "</graph>";
    NSData* xggmlSampleData = [xggmlSample dataUsingEncoding:NSUTF8StringEncoding];
    DrawableEntityFactory* factory = [[DrawableEntityFactory alloc] init];
    XGMMLParser *parser = [[XGMMLParser alloc] initWithData:xggmlSampleData factory:factory];
    
    graph = [parser parse];

    // display the loaded vertices
    for(NSString* id in graph.vertices) {
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
