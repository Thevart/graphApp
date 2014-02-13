//
//  DotDumper.m
//  ver
//
//  Created by Kévin Gomez on 13/02/14.
//
//

#import "DotDumper.h"

NSMutableString *buffer;

@implementation DotDumper

- (id) init
{
    if (self = [super init]) {
        buffer = [[NSMutableString alloc] init];
    }

    return self;
}

- (NSString*) dump: (Graph*) graph
{
    [self beginGraph:graph];

    [self beginVertices:graph.vertices];

    [self beginEdges:graph.edges oriented:graph.oriented];

    [self endGraph:graph];

    return buffer;
}

- (void) beginGraph: (Graph*) graph
{
    NSString* graphType = (graph.oriented) ? @"digraph" : @"graph";

    [self write:[NSString stringWithFormat:@"%@ {\n", graphType]];
}

- (void) beginVertices: (NSDictionary*) vertices
{
    for (NSString* id in vertices) {
        Vertex* vertex = [vertices objectForKey:id];

        [self write:[NSString stringWithFormat:@"\t%@ [label=\"%@\"]\n", vertex.id, vertex.label]];
    }
}

- (void) beginEdges: (NSArray*) edges oriented:(BOOL) oriented
{
    NSString* edgeType = (oriented) ? @"->" : @"--";
    
    for (Edge* edge in edges) {
        [self write:[NSString stringWithFormat:@"\t%@ %@ %@ [label=\"%@\"]\n", edge.origin.id, edgeType, edge.target.id, edge.label]];
    }
}

- (void) endGraph: (Graph*) graph
{
    [self write:@"}"];
}


- (void) write: (NSString*) text
{
    [buffer appendString:text];
}

@end