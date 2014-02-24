//
//  DijkstraInput.m
//  ver
//
//  Created by Kévin Gomez on 24/02/14.
//
//

#import "DijkstraInput.h"

@interface DijkstraInput ()

@property (readwrite) Vertex* origin;
@property (readwrite) Vertex* target;

@end


@implementation DijkstraInput

+ (DijkstraInput*) createWithVertices: (Vertex *) origin target:(Vertex *) target
{
    DijkstraInput* input = [[DijkstraInput alloc] init];

    input.origin = origin;
    input.target = target;

    return input;
}

@end