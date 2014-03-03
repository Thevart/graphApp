//
//  TestViewController.m
//  ver
//
//  Created by Arthur Thevenet on 27/02/14.
//
//

#import "TestViewController.h"
#import "TouchReceptor.h"
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
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self readSampleGraph];

    tr = [[TouchReceptor alloc] initWithFrameAndGraph:CGRectMake(0, 0, 1000, 1000) graph:graph];

    [self.view addSubview:tr];
}

- (void) readSampleGraph
{
    DrawableEntityFactory* factory = [[DrawableEntityFactory alloc] init];
    GraphParser *parser = [GraphParser create:factory];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"graph" ofType:@"xgmml"];
    
    graph = (DrawableGraph*) [parser parse:path];
    if (graph == nil) {
        graph = [[DrawableGraph alloc] init];
    }
    
    // render the graph view in the bigger one
    [self.view addSubview:graph.graphView];
    [self.view sendSubviewToBack:graph.graphView];
    
    // setup the graph layout
    id<LayoutCreatorProtocol> layoutCreator = [[RandomLayoutCreator alloc] init];
    [layoutCreator createLayout:graph x:self.view.frame.size.width y:self.view.frame.size.height];
    
    
    // display the loaded edges
    for (DrawableEdge* edge in graph.edges) {
        [edge setPosition:self.view.frame.size.width y:self.view.frame.size.height];
    }
}
@end
