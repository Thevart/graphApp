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
        NSLog(@"lala");
        self.edgeView = [[EdgeView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }

    return self;
}

-(id) initWithVertices:(Vertex *) originVertex destination:(Vertex *) destinationVertex
{
    if (self = [super initWithVertices:originVertex destination:destinationVertex]) {
        
        NSLog(@"llolo");
        [self.edgeView setPosition: self.origin.coord destination:self.target.coord];
        
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
    [self.edgeView setFrame:CGRectMake(0, 0, x, y)];
    
    NSLog(@"l alalal");
    [self.edgeView setNeedsDisplay];
}

@end