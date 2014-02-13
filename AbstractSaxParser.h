//
//  AbstractSaxParser.h
//  ver
//
//  Created by Kévin Gomez on 10/02/14.
//
//

#import <Foundation/Foundation.h>
#import "ParserProtocol.h"


typedef enum {
    SCOPE_TOP,
    SCOPE_GRAPH,
    SCOPE_VERTEX,
    SCOPE_EDGE
} ParseScope;

@interface AbstractSaxParser : NSObject<NSXMLParserDelegate, ParserProtocol>

@property NSXMLParser *parser;
@property NSMutableString *element;

@property Graph *graph;
@property ParseScope scope;
@property id<GraphEntityFactoryProtocol> entityFactory;
@property Edge* currentEdge;
@property Vertex* currentVertex;

- (Vertex*) getVertexOrCreate: (NSString*) id;
- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
@end
