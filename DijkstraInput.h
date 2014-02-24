//
//  DijkstraInput.h
//  ver
//
//  Created by Kévin Gomez on 24/02/14.
//
//

#import <Foundation/Foundation.h>
#import "AlgorithmInputProtocol.h"
#import "Vertex.h"

@interface DijkstraInput : NSObject<AlgorithmInputProtocol>

@property (readonly) Vertex* origin;
@property (readonly) Vertex* target;

+ (DijkstraInput*) createWithVertices: (Vertex *) origin target:(Vertex *) target;

@end