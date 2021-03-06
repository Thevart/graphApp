//
//  GraphMLParser.m
//  GraphApp
//
//  Created by Kévin Gomez on 03/02/14.
//  Copyright (c) 2014 Kévin Gomez. All rights reserved.
//

#import "GraphMLParser.h"

@implementation GraphMLParser

Graph* graph;


- (id) initWithData:(NSData*) data
{
    if (self == [super init]) {
        self.parser = [[NSXMLParser alloc] initWithData:data];
        [self.parser setDelegate:self];
    }      
    return self;
}


- (Graph*) parse
{
    graph = [[Graph alloc] init];

    [self.parser parse];
    
    return graph;
}


- (void) parser:(NSXMLParser*)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary*) attributeDict
{
    //NSLog(@"Started Element \"%@\"", elementName);
    //NSLog(@"    attributes %@", attributeDict);

    self.element = [NSMutableString string];

    if ([elementName isEqualToString:@"graph"]) {
        [self parseGraphElement:attributeDict];
    } else if ([elementName isEqualToString:@"node"]) {
        [self parseNodeElement:attributeDict];
    } else if ([elementName isEqualToString:@"edge"]) {
        [self parseEdgeElement:attributeDict];
    }
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NSLog(@"Found an element named: %@ with a value of: %@", elementName, self.element);
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.element == nil) {
        self.element = [[NSMutableString alloc] init];
    }

    [self.element appendString:string];
}

- (void) parseGraphElement:(NSDictionary*) attributes
{
    // is the graph oriented?
    graph.oriented = [[attributes objectForKey:@"edgedefault"] isEqualToString:@"directed"];
}

- (void) parseNodeElement:(NSDictionary*) attributes
{
    Vertex* vertex = [graph getVertexOrCreate:[attributes objectForKey:@"id"]];
    // handle other attributes like color, shape or position
}

- (void) parseEdgeElement:(NSDictionary*) attributes
{
    Vertex *origin = [graph getVertexOrCreate:[attributes objectForKey:@"source"]];
    Vertex *target = [graph getVertexOrCreate:[attributes objectForKey:@"target"]];
    Edge* edge = [[Edge alloc] initWithVertices:origin destination:target];

    [edge setLabel:[attributes objectForKey:@"id"]];
    [graph addEdge:edge];
}

@end
