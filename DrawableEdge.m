//
//  DrawableEdge.m
//  ver
//
//  Created by Arthur Thevenet on 10/02/14.
//
//

#import "DrawableEdge.h"

#import "EdgeView.h"

@interface DrawableEdge ()

@property (readwrite)EdgeView* edgeView;

@end

@implementation DrawableEdge


- (id)initWithCoord:(int)x y:(int) y
{
    self = [super init];
    self.edgeView=[[EdgeView alloc] initWithFrame:CGRectMake(0,0,x,y)];
    return self;
}
- (void) setPosition: (int)x y:(int) y
{

    
    self.edgeView.center = CGPointMake(x, y);
}

@end