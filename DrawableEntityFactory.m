//
//  DrawableEntityFactory.m
//  ver
//
//  Created by Kévin Gomez on 09/02/14.
//
//

#import "DrawableEntityFactory.h"
#import "DrawableVertex.h"
#import "DrawableEdge.h"
#import "DrawableGraph.h"


@implementation DrawableEntityFactory

- (Graph*) createGraph
{
    return [[DrawableGraph alloc] init];
}

- (Vertex*) createVertex:(NSString *) id
{
    return [[DrawableVertex alloc] initWithId:id];
}

- (Edge*) createEdge:(Vertex *) origin target:(Vertex *)target
{
    return [[DrawableEdge alloc] initWithVertices:origin target:target];
}
@end
