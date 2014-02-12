//
//  GraphParser.m
//  ver
//
//  Created by Kévin Gomez on 12/02/14.
//
//

#import "GraphParser.h"
#import "GEXFParser.h"
#import "GraphMLParser.h"
#import "XGMMLParser.h"

@implementation GraphParser

NSMutableDictionary* parsers;

- (id) init
{
    if (self == [super init]) {
        parsers = [[NSMutableDictionary alloc] init];
    }

    return self;
}

- (Graph*) parse: (NSString*) filePath
{
    NSString* extension = [filePath pathExtension];
    id<ParserProtocol> parser = [parsers objectForKey:extension];

    if (parser == nil) {
        return nil;
    }

    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return [parser parse:data];
}


- (void) addParser: (NSString*) extension parser:(id<ParserProtocol>) parser
{
    [parsers setValue:parser forKey:extension];
}

+ (GraphParser*) create: (id<GraphEntityFactoryProtocol>)factory
{
    GraphParser *parser = [[GraphParser alloc] init];

    [parser addParser:@"gexfp" parser:[[GEXFParser alloc] initWithFactory: factory]];
    [parser addParser:@"graphml" parser:[[GraphMLParser alloc] initWithFactory: factory]];
    [parser addParser:@"xgmml" parser:[[XGMMLParser alloc] initWithFactory: factory]];

    return parser;
}

@end
