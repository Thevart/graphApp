//
//  GEXFParser.h
//  GraphApp
//
//  Created by Kévin Gomez on 06/02/14.
//  Copyright (c) 2014 Kévin Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParserProtocol.h"

@interface GEXFParser : NSObject<NSXMLParserDelegate, ParserProtocol>

@property NSXMLParser *parser;
@property NSMutableString *element;

-(id) initWithData:(NSData*) data factory:(id<GraphEntityFactoryProtocol>)factory;
-(Graph*) parse;

- (void)parser:(NSXMLParser*)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary*) attributeDict;
- (void)parser:(NSXMLParser*)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
- (void)parser:(NSXMLParser*)parser foundCharacters:(NSString *)string;

@end
