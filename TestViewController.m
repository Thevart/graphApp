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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
     [self readSampleGraph];
    tr=[[TouchReceptor alloc]initWithFrame:CGRectMake(0, 0,1000,1000)];
    [self.view addSubview:tr];
    tr.graph=graph;
    
	// Do any additional setup after loading the view.
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self patatteContains];
    
}
-(NSMutableArray*) patatteContains
{
    NSMutableArray* vertices = [[NSMutableArray alloc]init];
    for (DrawableVertex* vertex in graph.vertices){
        if ([tr.currentPath containsPoint:CGPointMake(vertex.coord.x, vertex.coord.y)])
        {
            [vertices addObject:vertex.id];
        }
    }
    NSLog(@"%d",vertices.count);
    return vertices;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) readSampleGraph{
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
        //[graph addEdge:edge];
    }
    

    
}
@end
