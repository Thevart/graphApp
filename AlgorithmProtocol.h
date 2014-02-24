//
//  AlgorithmProtocol.h
//  ver
//
//  Created by Kévin Gomez on 17/02/14.
//
//

#import <Foundation/Foundation.h>
#import "Graph.h"
#import "AlgorithmInputProtocol.h"

typedef enum {
    ResultVoid,
    ResultPath
} AlgorithmResultType;

@protocol AlgorithmProtocol

- (id) execute: (Graph*) graph input:(id<AlgorithmInputProtocol>) input;

+ (AlgorithmResultType) getResultType;

@end
