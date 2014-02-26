//
//  GreedyColoringAlgorithm.m
//  ver
//
//  Created by Kévin Gomez on 20/02/14.
//
//

#import "GreedyColoringAlgorithm.h"

@implementation GreedyColoringAlgorithm

int k, base_seed;
NSMutableDictionary *colorsMap;

+ (AlgorithmResultType) getResultType
{
    return ResultVoid;
}

- (id) execute: (Graph*) graph input:(id<AlgorithmInputProtocol>) input
{
    srand(time(NULL));
    base_seed = rand();
    k = 0;
    colorsMap = [[NSMutableDictionary alloc] init];

    // initialize colors
    for (NSString* id in graph.vertices) {
        NSLog(@"Vertex %@ has %d neighbours", id, ((Vertex*)[graph.vertices objectForKey:id]).neighbours.count);
        [colorsMap setValue:[NSNumber numberWithInt:-1] forKey:id];
    }

    // assign colors
    for (NSString* id in graph.vertices) {
        Vertex* vertex = [graph.vertices objectForKey:id];

        [self selectColor:vertex];
    }


    NSLog(@"K == %d", k);

    return nil;
}

- (void) selectColor: (Vertex*) vertex
{
    int color = 0;

    // order the neighbours by their color
    NSArray *sortedNeighbours = [vertex.neighbours sortedArrayUsingComparator:^(id obj1, id obj2){
        if ([obj1 isKindOfClass:[Edge class]] && [obj2 isKindOfClass:[Edge class]]) {
            Edge* v1 = obj1;
            Edge* v2 = obj2;
            int v1Color = [[colorsMap objectForKey:v1.target.id] intValue];
            int v2Color = [[colorsMap objectForKey:v2.target.id] intValue];

            if (v1Color < v2Color) {
                return (NSComparisonResult) NSOrderedAscending;
            } else if (v1Color > v2Color) {
                return (NSComparisonResult) NSOrderedDescending;
            }
        }

        return (NSComparisonResult) NSOrderedSame;
    }];

    NSLog(@"Exploring vertex %@", vertex.id);

    // and select the first color available
    // ie: the first "color gap" in the neighbours will be the selected color
    //     (Kevin's metaheuristic: select the first hole)
    for (Edge* edge in sortedNeighbours) {
        Vertex* target = edge.target;
        int targetColor = [[colorsMap objectForKey:target.id] intValue];

        NSLog(@"    Neighbour %@ has color %d", target.id, targetColor);

        if (targetColor == -1) {
            continue;
        }

        if (targetColor > color) {
            NSLog(@" color    break   %d", targetColor);
            break;
        }

        color += 1;
    }

    // color = 2 means 3 colors
    k = MAX(color + 1, k);

    [colorsMap setValue:[NSNumber numberWithInt:color] forKey:vertex.id];
    [self convertColorToHexa:vertex color:color];

    NSLog(@"Assign color %d to vertex %@", color, vertex.id);
}

- (void) convertColorToHexa: (Vertex*) vertex color:(int) color
{
    srand(base_seed + color + 1);

    [vertex setColor: [Color initFromRGB:rand() % 256 g:rand() % 256 b:rand() % 256]];
}

@end