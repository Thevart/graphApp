//
//  GraphEntityFactory.h
//  ver
//
//  Created by Kévin Gomez on 09/02/14.

#import "Vertex.h"
#import "Edge.h"

@protocol GraphEntityFactoryProtocol<NSObject>
- (Vertex*) createVertex:(NSString *) id;
- (Edge*) createEdge:(Vertex *)originVertex destination:(Vertex *)destinationVertex;
@end
