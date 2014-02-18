//
//  RandomLayoutCreator.m
//  ver
//
//  Created by Kévin Gomez on 17/02/14.
//
//

#import "RandomLayoutCreator.h"

@implementation RandomLayoutCreator


-(void) createLayout: (Graph*) graph x:(int)x y:(int) y
{
    for (NSString* id in graph.vertices) {
        Vertex* vertex = [graph.vertices objectForKey:id];

        if (![vertex hasPosition]) {
            [vertex setPosition:arc4random_uniform(x) y:arc4random_uniform(y)];
        }
    }
}

@end
