//
//  GraphMLParser.m
//  GraphApp
//
//  Created by Kévin Gomez on 03/02/14.
//  Copyright (c) 2014 Kévin Gomez. All rights reserved.
//

#import "GraphMLParser.h"

@implementation GraphMLParser

- (id) initWithData:(NSData*) data factory:(id<GraphEntityFactoryProtocol>)factory
{
    if (self == [super init]) {
        self.entityFactory = factory;
        
        self.parser = [[NSXMLParser alloc] initWithData:data];
        [self.parser setDelegate:self];
    }      
    return self;
}


- (void) parser:(NSXMLParser*)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary*) attributeDict
{
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

- (void) parseGraphElement:(NSDictionary*) attributes
{
    // is the graph oriented?
    self.graph.oriented = [[attributes objectForKey:@"edgedefault"] isEqualToString:@"directed"];
}

- (void) parseNodeElement:(NSDictionary*) attributes
{
    NSString* id = [attributes objectForKey:@"id"];
    Vertex* vertex = [self getVertexOrCreate:id];
    
    // handle other attributes like color, shape or position
}

- (void) parseEdgeElement:(NSDictionary*) attributes
{
    Vertex *origin = [self getVertexOrCreate:[attributes objectForKey:@"source"]];
    Vertex *target = [self getVertexOrCreate:[attributes objectForKey:@"target"]];
    Edge* edge = [self.entityFactory createEdge:origin destination:target];

    [edge setLabel:[attributes objectForKey:@"id"]];
    [self.graph addEdge:edge];
}

@end
