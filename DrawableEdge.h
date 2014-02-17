//
//  DrawableEdge.h
//  ver
//
//  Created by Arthur Thevenet on 10/02/14.
//
//

#import <Foundation/Foundation.h>

#import "Edge.h"
#import "EdgeView.h"


@interface DrawableEdge: Edge
@property (readonly) EdgeView* edgeView;
- (id) initWithCoord:(int)x y:(int) y;
- (void) setPosition:(int)x y:(int) y;
@end

