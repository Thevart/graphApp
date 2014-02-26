//
//  SVGDumper.m
//  ver
//
//  Created by Kévin Gomez on 26/02/14.
//
//

#import "SVGDumper.h"

#define SVG_VERTEX_RADIUS 32.0

@implementation SVGDumper

NSMutableString *buffer;

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

    [self beginEdges:graph.edges oriented:graph.oriented];

    [self beginVertices:graph.vertices];

    [self endGraph:graph];

    return buffer;
}

- (void) beginGraph: (Graph*) graph
{
    // @todo: handle (non)oriented graphs
    [self write:@"<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\">\n"];
    // @todo: handle translate/viewport
    [self write:@"<g transform=\"scale(0.5 0.5) rotate(0) translate(4 112)\">\n"];
}

- (void) beginVertices: (NSDictionary*) vertices
{
    for (NSString* id in vertices) {
        Vertex* vertex = [vertices objectForKey:id];

        [self dumpVertex:vertex];
    }
}

- (void) dumpVertex: (Vertex*) vertex
{
    /*
     <g id="node1" class="node">
     <ellipse style="fill:none;stroke:black;" cx="36" cy="-90" rx="32.8565" ry="18"/>
     <text text-anchor="middle" x="36" y="-85.9">Hello</text>
     </g>
     */
    [self write:[NSString stringWithFormat:@"\t<g id=\"node_%@\">\n", vertex.id]];

    // vertex layout
    [self write:[NSString stringWithFormat:@"\t\t<ellipse style=\"fill:white; stroke:black;\" cx=\"%d\" cy=\"%d\" rx=\"%f\" ry=\"%f\"/>\n", vertex.coord.x, vertex.coord.y, SVG_VERTEX_RADIUS, SVG_VERTEX_RADIUS]];

    // vertex label
    [self write:[NSString stringWithFormat:@"\t\t<text text-anchor=\"middle\" x=\"%d\" y=\"%.1f\">%@</text>\n", vertex.coord.x, vertex.coord.y + 4.1, vertex.label]];

    [self write:@"\t</g>\n"];
}

- (void) beginEdges: (NSArray*) edges oriented:(BOOL) oriented
{
    for (Edge* edge in edges) {
        [self dumpEdge:edge];
    }
}

- (void) dumpEdge: (Edge*) edge
{
    /*
    <g id="edge2">
    <path style="fill:none;stroke:black;" d="M36,-72C36,-64 36,-55 36,-46"/>
    <polygon style="fill:black;stroke:black;" points="39.5001,-46 36,-36 32.5001,-46 39.5001,-46"/>
    </g>
    */

    [self write:[NSString stringWithFormat:@"\t<g id=\"edge_%@_%@\">\n", edge.origin.id, edge.target.id]];

    // edge "line"
    [self write:[NSString stringWithFormat:@"\t\t<path style=\"stroke:black;\" d=\"M%d,%d L %d %d\"/>\n", edge.origin.coord.x, edge.origin.coord.y, edge.target.coord.x, edge.target.coord.y]];

    // edge arrow (for oriented edges)
    // @todo: handle (non)-oriented graphs
    //[self write:[NSString stringWithFormat:@"\t\t<polygon style=\"fill:black;stroke:black;\" points=\"39.5001,-46 36,-36 32.5001,-46 39.5001,-46\"/>\n"]];

    [self write:@"\t</g>\n"];
}

- (void) endGraph: (Graph*) graph
{
    [self write:@"</g>\n</svg>"];
}


- (void) write: (NSString*) text
{
    [buffer appendString:text];
}
@end
