//
//  DrawableVertex.m
//  ver
//
//  Created by Kévin Gomez on 09/02/14.
//
//

#import "DrawableVertex.h"
#import "VertexView.h"
#import "DrawableEdge.h"

@interface DrawableVertex ()

@property (readwrite)VertexView* vertexView;


@end


@implementation DrawableVertex


- (id) init
{
    if (self = [super init]) {
        self.vertexView = [[VertexView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        self.vertexView.label = self.label;
        [self setColor:[self getColor]];
    }

    return self;
}

- (id) initWithId:(NSString *)id
{
    if (self = [super initWithId:id]) {
        self.vertexView.label = self.label;
    }
    
    return self;
}


- (id) initWithCoord:(int)x y:(int)y
{
    if (self = [self init]) {
        [self setPosition:x y:y];
    }

    return self;
}

- (void) setPosition: (int)x y:(int) y
{
    [super setPosition:x y:y];

    [self.vertexView setFrame:CGRectMake(x-15, y-15, 30, 30)];
    self.vertexView.center = CGPointMake(x, y);
    [self setNeedsDisplay];
}

- (void) setColor: (Color *) color
{
    [super setColor:color];

    self.vertexView.color = [UIColor colorWithRed:[color r] green:[color g] blue:[color b] alpha:1];
    [self setNeedsDisplay];
}

-(void) setNeedsDisplay
{
    [self.vertexView setNeedsDisplay];

    // refresh "outgoing edges"
    for (DrawableEdge *edge in self.neighbours) {
        [edge.edgeView setNeedsDisplay];
    }

    // and now refresh "incoming edges"
    for (DrawableEdge *edge in self.incomingEdges) {
        [edge.edgeView setNeedsDisplay];
    }
}

@end