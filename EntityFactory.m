//
//  EntityFactory.m
//  ver
//
//  Created by Kévin Gomez on 09/02/14.
//
//

#import "EntityFactory.h"

@implementation EntityFactory

- (Vertex*) createVertex:(NSString *) id
{
    return [[Vertex alloc] initWithId:id];
}

- (Edge*) createEdge:(Vertex *) origin target:target
{
    return [[Edge alloc] initWithVertices:origin target:target];
}
@end