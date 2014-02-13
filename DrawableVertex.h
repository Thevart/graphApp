//
//  DrawableVertex.h
//  ver
//
//  Created by Kévin Gomez on 09/02/14.
//
//

#import "Vertex.h"

@interface DrawableVertex : Vertex
@property (readonly) UIView* view;
- (void) setPosition: (int)x y:(int) y;
@end