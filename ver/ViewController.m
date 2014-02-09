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
#import "XGMMLParser.h"
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
    CGPoint location = [touch locationInView:touch.view];

    // always create a new vertex, even if there already is one "under the finger"
    [self addVertex:location.x y:location.y];
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

    [self readDummyGraph];
}

- (void) readDummyGraph
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
