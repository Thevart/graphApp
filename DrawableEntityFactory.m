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


@implementation DrawableEntityFactory

- (id) init
{
    return [super init];
}

- (Vertex*) createVertex:(NSString *) id
{
    return [[DrawableVertex alloc] initWithId:id];
}

- (Edge*) createEdge:(Vertex *)originVertex destination:(Vertex *)destinationVertex
{
    return [[DrawableEdge alloc] initWithVertices:originVertex destination:destinationVertex];
}
@end
