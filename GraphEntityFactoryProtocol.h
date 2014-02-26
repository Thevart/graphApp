//
//  GraphEntityFactory.h
//  ver
//
//  Created by Kévin Gomez on 09/02/14.

#import "Graph.h"

@protocol GraphEntityFactoryProtocol<NSObject>
- (Graph*) createGraph;
- (Vertex*) createVertex:(NSString *) id;
- (Edge*) createEdge:(Vertex *) origin target:target;
@end
