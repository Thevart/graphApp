//
//  GreedyColoringAlgorithm.m
//  ver
//
//  Created by Kévin Gomez on 20/02/14.
//
//

#import "GreedyColoringAlgorithm.h"

@implementation GreedyColoringAlgorithm

int k;

- (id) init
{
    if (self = [super init]) {
        k = 0;
    }

    return self;
}

- (void) execute: (Graph *) graph
{
    for (NSString* id in graph.vertices) {
        Vertex* vertex = [graph.vertices objectForKey:id];

        [self selectColor:vertex];
    }

    // convert the integers to their hexadecimal equivalent
    for (NSString* id in graph.vertices) {
        Vertex* vertex = [graph.vertices objectForKey:id];

        [self convertColorToHexa:vertex];
    }
}

- (void) selectColor: (Vertex*) vertex
{
    int color = 0;

    // order the neighbours by their color
    NSArray *sortedNeighbours = [vertex.neighbours sortedArrayUsingComparator:^(id obj1, id obj2){
        if ([obj1 isKindOfClass:[Vertex class]] && [obj2 isKindOfClass:[Vertex class]]) {
            Vertex* v1 = obj1;
            Vertex* v2 = obj2;

            if (v1.color > v2.color) {
                return (NSComparisonResult) NSOrderedAscending;
            } else if (v1.color < v2.color) {
                return (NSComparisonResult) NSOrderedDescending;
            }
        }

        return (NSComparisonResult) NSOrderedSame;
    }];

    // and select the first color available
    // ie: the first "color gap" in the neighbours will be the selected color
    //     (Kevin's metaheuristic: select the first hole)
    for (Edge* edge in sortedNeighbours) {
        if (edge.target.color == -1) {
            continue;
        }

        if (edge.target.color == color) {
            color += 1;
        } else {
            break;
        }
    }

    k = MAX(color + 1, k);
    vertex.color = color;
}

- (void) convertColorToHexa: (Vertex*) vertex
{
    srand(vertex.color + 1);
    NSString* hexValue = [NSString stringWithFormat:@"%02x%02x%02x", rand() % 256, rand() % 256, rand() % 256];
    unsigned int outVal;
    NSScanner* scanner = [NSScanner scannerWithString:hexValue];
    [scanner scanHexInt:&outVal];

    [vertex setHexColor: outVal];
}

@end