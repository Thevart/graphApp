//
//  AbstractSaxParser.m
//  ver
//
//  Created by Kévin Gomez on 10/02/14.
//
//

#import "AbstractSaxParser.h"

@implementation AbstractSaxParser

- (id) initWithFactory: (id<GraphEntityFactoryProtocol>)factory
{
    if (self == [super init]) {
        self.entityFactory = factory;
    }

    return self;
}


- (Graph*) parse: (NSData*) data
{
    self.graph = [[Graph alloc] init];
    self.scope = SCOPE_TOP;

    self.parser = [[NSXMLParser alloc] initWithData:data];
    [self.parser setDelegate:self];

    [self.parser parse];

    return self.graph;
}


- (void) parser:(NSXMLParser*)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary*) attributeDict
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.element == nil) {
        self.element = [[NSMutableString alloc] init];
    }

    [self.element appendString:string];
}

- (Vertex*) getVertexOrCreate: (NSString*) id
{
    if ([self.graph hasVertex:id]) {
        return [self.graph getVertex:id];
    } else {
        Vertex* vertex = [self.entityFactory createVertex:id];
        [self.graph addVertex:vertex];
        
        return vertex;
    }
}


@end
