//
//  DrawableEdge.h
//  ver
//
//  Created by Arthur Thevenet on 10/02/14.
//
//

#import <Foundation/Foundation.h>

#import "Edge.h"

@interface DrawableEdge: Edge
@property (readonly) UIView* view;
- (id) initWithFrame:(CGRect)frame;
@end
