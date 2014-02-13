//
//  DumperProtocol.h
//  ver
//
//  Created by Kévin Gomez on 13/02/14.
//
//

#import "Graph.h"

@protocol DumperProtocol

-(NSString*) dump: (Graph*) graph;

@end