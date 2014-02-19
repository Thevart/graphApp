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
    Vertex* startVertex = [graph getVertex:@"0"];
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

    while ([queue count] > 1) {
        currentVertex = ((PriorityQueueItem *) [queue pop]).obj;
        NSLog(@"Exploring vertex %@", currentVertex.id);

        for (Edge* edge in currentVertex.neighbours) {
            DijkstraData* neighbourData = edge.target.userData;
            int newDistance = ((DijkstraData *) currentVertex.userData).distance + edge.weight;
            NSLog(@"    Exploring neighbour %@, weight = %d", edge.target.id, edge.weight);
            NSLog(@"    Old distance is %d; neighbour one is %d", newDistance, neighbourData.distance);

            if (neighbourData.distance > newDistance) {
                NSLog(@"  keep old distance");
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

    NSLog(@"Distances to %@", startVertex.id);
    for (NSString* id in graph.vertices) {
        Vertex* vertex = [graph.vertices objectForKey:id];
        DijkstraData* data = (DijkstraData *) vertex.userData;

        NSLog(@"    %@ = %d", vertex.id, data.distance);
    }
}

@end