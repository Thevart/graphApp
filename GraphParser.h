//
//  GraphParser.h
//  ver
//
//  Created by Kévin Gomez on 12/02/14.
//
//

#import <Foundation/Foundation.h>
#import "Graph.h"
#import "ParserProtocol.h"

@interface GraphParser : NSObject

- (Graph*) parse: (NSString*) data;
- (void) addParser: (NSString*) extension parser:(id<ParserProtocol>) parser;

+ (GraphParser*) create: (id<GraphEntityFactoryProtocol>)factory;

@end
