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
#import "GEXFParser.h"
#import "XGMMLParser.h"

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
/*
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
*/
        // tests for the GEXF parser
        /*
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
         GEXFParser *parser = [[GEXFParser alloc] initWithData:gexfSampleData];
         Graph* graph = [parser parse];

         if (graph.oriented) {
         NSLog(@"Oriented!");
         } else {
         NSLog(@"Not oriented!");
         }

         NSLog(@"Nb de sommets: %lu", (unsigned long)[graph.vertices count]);
         NSLog(@"Nb d'arêtes: %lu", (unsigned long)[graph.edges count]);
         */

        // tests for the XGGML parser
         NSString* xggmlSample = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
        "<graph label=\"small example\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\""
            "xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\""
            "xmlns:cy=\"http://www.cytoscape.org\" xmlns=\"http://www.cs.rpi.edu/XGMML\""
            "directed=\"1\">"
        "<node label=\"A\" id=\"1\">"
        "<att name=\"size\" type=\"integer\" value=\"24\"/>"
        "<att name=\"confirmed\" type=\"boolean\" value=\"true\"/>"
        "<att name=\"weight\" type=\"integer\" value=\"42\"/>"
        "</node>"
        "<node label=\"B\" id=\"2\">"
        "<att name=\"size\" type=\"integer\" value=\"16\"/>"
        "<att name=\"confirmed\" type=\"boolean\" value=\"false\"/>"
        "</node>"
        "<node label=\"C\" id=\"3\">"
        "<att name=\"size\" type=\"integer\" value=\"13\"/>"
        "<att name=\"confirmed\" type=\"boolean\" value=\"true\"/>"
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
        XGMMLParser *parser = [[XGMMLParser alloc] initWithData:xggmlSampleData];
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