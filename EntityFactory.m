//
//  EntityFactory.m
//  ver
//
//  Created by Kévin Gomez on 09/02/14.
//
//

#import "EntityFactory.h"
#import "Vertex.h"
#import "Edge.h"


@implementation EntityFactory

- (id) init
{
    return [super init];
}

- (Vertex*) createVertex:(NSString *) id
{
    return [[Vertex alloc] initWithId:id];
}

- (Edge*) createEdge:(Vertex *)originVertex destination:(Vertex *)destinationVertex
{
    return [[Edge alloc] initWithVertices:originVertex destination:destinationVertex];
}
@end