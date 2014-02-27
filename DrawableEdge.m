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

@property (readwrite) EdgeView* edgeView;

@end

@implementation DrawableEdge

- (id) init
{
    if (self = [super init]) {
        self.edgeView = [[EdgeView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }

    return self;
}

-(id) initWithVertices:(Vertex *) origin target:(Vertex *) target
{
    if (self = [super initWithVertices:origin target:target]) {
        [self.edgeView setPosition:self.origin.coord destination:self.target.coord];
        
        return self;
    }

    return nil;
}

- (id) initWithCoord:(int)x y:(int) y
{
    if (self = [self init]) {
        [self setPosition:x y:y];
    }

    return self;
}


- (void) setPosition: (int)x y:(int) y
{
    [self.edgeView setFrame:CGRectMake(0, 0, 3000, 3000)];
    [self.edgeView setNeedsDisplay];
}

@end