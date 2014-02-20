//
//  DijkstraAlgorithm.m
//  ver
//
//  Created by Kévin Gomez on 17/02/14.
//
//

#import "DijkstraAlgorithm.h"
#import "DijkstraData.h"
#import "PriorityQueue.h"
#import "PriorityQueueItem.h"

@implementation DijkstraAlgorithm


- (void) execute: (Graph *) graph
{
    // input parameters
    Vertex* startVertex = [graph getVertex:@"0"];
    Vertex* endVertex = [graph getVertex:@"1"];

    Vertex* currentVertex;
    PriorityQueue *queue = [[PriorityQueue alloc] init];

    // initialize the distances to the initial vertex
    for (NSString* id in graph.vertices) {
        Vertex* vertex = [graph.vertices objectForKey:id];
        DijkstraData* data = [DijkstraData alloc];

        // the initial node has a distance 0 from itself
        if (vertex == startVertex) {
            data.distance = 0;
        } else {
            data.distance = NSIntegerMax / 2;
        }

        data.previous = nil;
        data.pqItem = [PriorityQueueItem objectWithValues:vertex value:data.distance];

        vertex.userData = data;

        // add the vertex to the exploration queue
        [queue addObject:data.pqItem];
    }

    // while there is a node to explore
    while ([queue count] > 1) {
        currentVertex = ((PriorityQueueItem *) [queue pop]).obj;

        // explore its neighbours
        for (Edge* edge in currentVertex.neighbours) {
            DijkstraData* neighbourData = edge.target.userData;
            int newDistance = ((DijkstraData *) currentVertex.userData).distance + edge.weight;

            // by using the current neighbour, we have a shorter path
            if (neighbourData.distance > newDistance) {
                // update the distance
                neighbourData.distance = newDistance;
                neighbourData.pqItem.value = newDistance;

                // save the path
                neighbourData.previous = currentVertex;

                // distance changed: the priority queue needs to be rebuilt
                [queue rebuild];
            }
        }
    }

    NSArray* path = [self extractShortestPath:endVertex];
    NSLog(@"Path from %@ to %@", startVertex.id, endVertex.id);
    for (Vertex* v in path) {
        NSLog(@"%@", v.id);
    }
}

- (NSArray*) extractShortestPath: (Vertex*) to
{
    NSMutableArray* path = [[NSMutableArray alloc] init];
    Vertex *vertex = to;
    DijkstraData* data = vertex.userData;
    while (vertex != nil) {
        [path insertObject:vertex atIndex:0];

        vertex = data.previous;
        data = vertex.userData;
    }

    return path;
}

@end