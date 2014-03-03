//
//  FingerVertexSelector.m
//  ver
//
//  Created by Kévin Gomez on 03/03/14.
//
//

#import "FingerVertexSelector.h"

@implementation FingerVertexSelector

UIBezierPath* path;
Graph* graph;

-(id) init
{
    if (self = [super init]) {
        path = [UIBezierPath bezierPath];
        path.lineWidth = 3.0;
    }

    return self;
}

-(id) initWithGraph: (Graph*) g
{
    if (self = [self init]) {
        graph = g;
    }

    return self;
}

-(void) startSelectionAtLocation: (CGPoint) location
{
    [path moveToPoint:location];
}

-(void) updateWithLocation: (CGPoint) location
{
    [path addLineToPoint:location];
}

-(void) clear
{
    [path removeAllPoints];
}

-(void) draw
{
    [[UIColor redColor] set];
    [path stroke];
}

-(NSArray*) getSelectedVertices
{
    NSMutableArray *vertices = [[NSMutableArray alloc] init];

    for (NSString* id in graph.vertices) {
        Vertex *vertex = [graph getVertex:id];

        if ([path containsPoint:CGPointMake(vertex.coord.x, vertex.coord.y)]) {
            [vertices addObject:vertex];
        }
    }

    return vertices;
}

@end
