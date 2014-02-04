//
//  main.m
//  GraphModel
//
//  Created by Arthur THEVENET on 1/30/14.
//  Copyright (c) 2014 Arthur THEVENET. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Graph.h"
#import "Coord.h"
#import "Edge.h"
#import "GraphMLParser.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
/*
        Graph* graph = [[Graph alloc] init];
        Vertex* originVertex = [[Vertex alloc] initWithLabel:@"Label de mon cul"];
        Vertex* destinationVertex = [[Vertex alloc] initWithLabel:@"Label de ton cul"];
        Edge* edge = [[Edge alloc] initWithVertices:originVertex destination:destinationVertex];
        
        [graph addVertex:originVertex];
        [graph addVertex:destinationVertex];
        
        
        [graph addEdge:edge];


        if (graph.oriented) {
            NSLog(@"Oriented!");
        } else {
            NSLog(@"Not oriented!");
        }

        NSLog(@"Nom du premier vertex %@", ((Vertex *)[graph.vertices objectAtIndex:0]).label);
        NSLog(@"Nb de sommets: %lu", (unsigned long)[graph.vertices count]);
        NSLog(@"Nb d'arêtes: %lu", (unsigned long)[graph.edges count]);
        
        NSLog(@"Coord x du premier label : %d", ((Coord *)originVertex.coord).x);
*/
        // tests for the GraphML parser
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
        GraphMLParser *parser = [[GraphMLParser alloc] initWithData:graphMLSampleData];
        Graph* graph = [parser parse];

        if (graph.oriented) {
            NSLog(@"Oriented!");
        } else {
            NSLog(@"Not oriented!");
        }

        NSLog(@"Nb de sommets: %lu", (unsigned long)[graph.vertices count]);
        NSLog(@"Nb d'arêtes: %lu", (unsigned long)[graph.edges count]);
    }
    
    return 0;
}