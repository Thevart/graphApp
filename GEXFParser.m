//
//  GEXFParser.m
//  GraphApp
//
//  Created by Kévin Gomez on 06/02/14.
//  Copyright (c) 2014 Kévin Gomez. All rights reserved.
//

#import "GEXFParser.h"

@implementation GEXFParser

- (void) parser:(NSXMLParser*)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary*) attributeDict
{
    self.element = [NSMutableString string];

    switch (self.scope) {
        case SCOPE_TOP:
            if ([elementName isEqualToString:@"graph"]) {
                [self parseGraphElement:attributeDict];
            }
            break;
        case SCOPE_EDGE:
            break;
        case SCOPE_VERTEX:
            break;
        case SCOPE_GRAPH:
            if ([elementName isEqualToString:@"node"]) {
                [self parseNodeElement:attributeDict];
            } else if ([elementName isEqualToString:@"edge"]) {
                [self parseEdgeElement:attributeDict];
            }
            break;
        default:
            break;
    }
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    switch (self.scope) {
        case SCOPE_VERTEX:
            if ([elementName isEqualToString:@"node"]) {
                self.scope = SCOPE_GRAPH;
            }
            break;
        case SCOPE_EDGE:
            if ([elementName isEqualToString:@"edge"]) {
                self.scope = SCOPE_GRAPH;
            }
            break;

        default:
            break;
    }
}

- (void) parseGraphElement:(NSDictionary*) attributes
{
    // is the graph oriented?
    self.graph.oriented = [[attributes objectForKey:@"defaultedgetype"] isEqualToString:@"directed"];

    // now that we read a graph declaration, we can start reading nodes and edges
    self.scope = SCOPE_GRAPH;
}

- (void) parseNodeElement:(NSDictionary*) attributes
{
    Vertex* vertex = [self getVertexOrCreate:[attributes objectForKey:@"id"]];
    vertex.label = [attributes objectForKey:@"label"];
    
    // @todo: handle other attributes like color, shape or position

    // now that we read a node declaration, we can start reading its attributes
    self.scope = SCOPE_VERTEX;
    self.currentVertex = vertex;
}

- (void) parseEdgeElement:(NSDictionary*) attributes
{
    Vertex *origin = [self getVertexOrCreate:[attributes objectForKey:@"source"]];
    Vertex *target = [self getVertexOrCreate:[attributes objectForKey:@"target"]];
    Edge* edge = [[Edge alloc] initWithVertices:origin target:target];

    [edge setLabel:[attributes objectForKey:@"id"]];
    [self.graph addEdge:edge];

    // now that we read an edge declaration, we can start reading its attributes
    self.currentEdge = edge;
    self.scope = SCOPE_EDGE;
}

@end
