//
//  ParserProtocol.h
//  GraphApp
//
//  Created by Kévin Gomez on 06/02/14.
//  Copyright (c) 2014 Kévin Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Graph.h"

@protocol ParserProtocol
-(id) initWithData:(NSData*) data;
-(Graph*) parse;
@end
