//
//  GraphAppModelTest.m
//  GraphAppModelTest
//
//  Created by Kévin Gomez on 03/03/14.
//
//

#import "GraphAppModelTest.h"
#import "Graph.h"

@implementation GraphAppModelTest

Graph *graph;

- (void) setUp
{
    [super setUp];

    graph = [[Graph alloc] init];
    STAssertNotNil(graph, @"Could not create test graph	.");
}

- (void) testGraphInit
{
    STAssertTrue(graph.oriented, @"Graph are oriented by default");
    STAssertTrue([graph.vertices count] == 0, @"No vertex should be created");
    STAssertTrue([graph.edges count] == 0, @"No edge should be created");
}

- (void) testAddVertex
{
    Vertex* v = [[Vertex alloc] init];

    [graph addVertex:v];

    STAssertTrue([graph.vertices count] == 1, @"The vertex should be added");
    STAssertEqualObjects([graph.vertices objectForKey:v.id], v, @"The vertex should be added without being transformed");
    STAssertTrue([graph.edges count] == 0, @"No edge should be created");
}

- (void) testHasVertex
{
    Vertex* v = [[Vertex alloc] init];
    [graph addVertex:v];

    STAssertTrue([graph hasVertex:v.id], @"An existing vertex is found");
    STAssertFalse([graph hasVertex:@"lala"], @"A non-existing vertex is not found");
}

- (void) testGetVertex
{
    Vertex* v = [[Vertex alloc] init];
    [graph addVertex:v];

    STAssertEqualObjects([graph getVertex:v.id], v, @"The vertex should be added without being transformed");
    STAssertNil([graph getVertex:@"lala"], @"Retrieving a non existent vertex should return nil");
}

- (void) testAddEdge
{
    Edge* e = [[Edge alloc] init];

    [graph addEdge:e];

    STAssertTrue([graph.edges count] == 1, @"The edge should be added");
    STAssertEqualObjects([graph.edges objectAtIndex:0], e, @"The edge should be added without being transformed");
    STAssertTrue([graph.vertices count] == 0, @"No vertex should be created");
}

- (void) testRemoveOrphanVertex
{
    Vertex* v = [[Vertex alloc] init];
    [graph addVertex:v];

    STAssertTrue([graph.vertices count] == 1, @"The vertex is present");

    [graph removeVertex:v];

    STAssertFalse([graph hasVertex:v.id], @"The vertex should not be found");
    STAssertTrue([graph.vertices count] == 0, @"No vertex should be found");
}

- (void) testRemoveVertexWithOneNeighbour
{
    Vertex* origin = [[Vertex alloc] init];
    Vertex* target = [[Vertex alloc] init];
    Vertex* other = [[Vertex alloc] init];
    Vertex* otherTarget = [[Vertex alloc] init];
    Edge* e_origin_target = [[Edge alloc] initWithVertices:origin target:target];
    Edge* e_origin_otherTarget = [[Edge alloc] initWithVertices:origin target:otherTarget];
    Edge* e_target_other = [[Edge alloc] initWithVertices:target target:other];

    [graph addVertex:origin];
    [graph addVertex:target];
    [graph addVertex:otherTarget];
    [graph addVertex:other];

    [graph addEdge:e_origin_target];
    [graph addEdge:e_target_other];
    [graph addEdge:e_origin_otherTarget];

    STAssertTrue([graph.edges count] == 3, @"The edges are present");
    STAssertTrue([graph.vertices count] == 4, @"The vertices are present");

    [graph removeVertex:origin];

    STAssertFalse([graph hasVertex:origin.id], @"The origin vertex should not be found");
    STAssertTrue([graph hasVertex:target.id], @"The target vertex should still be found");
    STAssertTrue([graph hasVertex:otherTarget.id], @"The target vertex should still be found");
    STAssertTrue([graph hasVertex:other.id], @"The target vertex should still be found");
    STAssertTrue([graph.vertices count] == 3, @"Only three vertex should be found");
    STAssertTrue([graph.edges count] == 1, @"The not impacted edge is preserved");
    STAssertEqualObjects([graph.edges objectAtIndex:0], e_target_other, @"The remaining edge is the right one");
}

- (void) testRemoveVertexWithSeveralNeighbour
{
    Vertex* origin = [[Vertex alloc] init];
    Vertex* target = [[Vertex alloc] init];
    Edge* e = [[Edge alloc] initWithVertices:origin target:target];

    [graph addVertex:origin];
    [graph addVertex:target];
    [graph addEdge:e];

    STAssertTrue([graph.edges count] == 1, @"The edge is present");
    STAssertTrue([graph.vertices count] == 2, @"The vertices are present");

    [graph removeVertex:origin];

    STAssertFalse([graph hasVertex:origin.id], @"The origin vertex should not be found");
    STAssertTrue([graph hasVertex:target.id], @"The target vertex should still be found");
    STAssertTrue([graph.vertices count] == 1, @"Only one vertex should be found");
    STAssertTrue([graph.edges count] == 0, @"The edge has been removed");
}

- (void) testRemoveEdge
{
    Edge* e = [[Edge alloc] init];
    [graph addEdge:e];

    STAssertTrue([graph.edges count] == 1, @"The edge is present");

    [graph removeEdge:e];

    STAssertTrue([graph.edges count] == 0, @"No edge should be found");
}

@end
