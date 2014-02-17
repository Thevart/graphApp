//
//  LayoutCreatorProtocol.h
//  ver
//
//  Created by Kévin Gomez on 17/02/14.
//
//

#import <Foundation/Foundation.h>
#import "Graph.h"

@protocol LayoutCreatorProtocol <NSObject>

-(void) createLayout: (Graph*) graph x:(int)x y:(int) y;

@end
