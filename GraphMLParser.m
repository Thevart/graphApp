//
//  GraphMLParser.m
//  GraphApp
//
//  Created by Kévin Gomez on 03/02/14.
//  Copyright (c) 2014 Kévin Gomez. All rights reserved.
//

#import "GraphMLParser.h"

@implementation GraphMLParser

NSMutableDictionary* edgeAttributesMap;
NSMutableDictionary* nodeAttributesMap;
NSString* currentEdgeAttribute;
NSString* currentNodeAttribute;

- (id) init
{
    if (self == [super init]) {
        edgeAttributesMap = [[NSMutableDictionary alloc] init];
        nodeAttributesMap = [[NSMutableDictionary alloc] init];
    }

    return self;
}

- (void) parser:(NSXMLParser*)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary*) attributeDict
{
    self.element = [NSMutableString string];

    switch (self.scope) {
        case SCOPE_TOP:
            if ([elementName isEqualToString:@"graph"]) {
                [self parseGraphElement:attributeDict];
            }
            if ([elementName isEqualToString:@"key"]) {
                [self parseKeyDefinitionElement:attributeDict];
            }
            break;
        case SCOPE_EDGE:
            if ([elementName isEqualToString:@"data"]) {
                [self parseEdgeDataElement:attributeDict];
            }
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
            if ([elementName isEqualToString:@"data"]) {
                [self handleEdgeDataElementValue];
            }
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
    self.graph.oriented = [[attributes objectForKey:@"edgedefault"] isEqualToString:@"directed"];

    self.scope = SCOPE_GRAPH;
}

- (void) parseNodeElement:(NSDictionary*) attributes
{
    NSString* id = [attributes objectForKey:@"id"];
    Vertex* vertex = [self getVertexOrCreate:id];
    
    // handle other attributes like color, shape or position

    // now that we read a node declaration, we can start reading its attributes
    self.scope = SCOPE_VERTEX;
    self.currentVertex = vertex;
}

- (void) parseEdgeElement:(NSDictionary*) attributes
{
    Vertex *origin = [self getVertexOrCreate:[attributes objectForKey:@"source"]];
    Vertex *target = [self getVertexOrCreate:[attributes objectForKey:@"target"]];
    Edge* edge = [self.entityFactory createEdge:origin target:target];

    [edge setLabel:[attributes objectForKey:@"id"]];
    [self.graph addEdge:edge];

    // now that we read an edge declaration, we can start reading its attributes
    self.currentEdge = edge;
    self.scope = SCOPE_EDGE;
}

- (void) parseKeyDefinitionElement:(NSDictionary*) attributes
{
    NSString* key = [attributes objectForKey:@"id"];
    NSString* value = [attributes objectForKey:@"attr.name"];

    if ([[attributes objectForKey:@"for"] isEqualToString:@"edge"]) {
        [edgeAttributesMap setValue:value forKey:key];
    }
    if ([[attributes objectForKey:@"for"] isEqualToString:@"node"]) {
        [nodeAttributesMap setValue:value forKey:key];
    }
}

- (void) parseEdgeDataElement:(NSDictionary*) attributes
{
    NSString* attributeName = [edgeAttributesMap objectForKey:[attributes objectForKey:@"key"]];

    if (attributeName != nil) {
        currentEdgeAttribute = attributeName;
    }
}

- (void) handleEdgeDataElementValue
{
    if ([currentEdgeAttribute isEqualToString:@"weight"]) {
        int weight = [self.element intValue];
        [self.currentEdge setWeight:weight];
    }
}

@end
