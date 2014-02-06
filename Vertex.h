//
//  Vertex.h
//  Prog
//
//  Created by Arthur THEVENET on 1/30/14.
//  Copyright (c) 2014 Arthur THEVENET. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coord.h"

@interface Vertex : NSObject

@property NSString* id;
@property NSString* label;
@property Coord* coord;

- (id)initWithId:(NSString *) id;

@end
