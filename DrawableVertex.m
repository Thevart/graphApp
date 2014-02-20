//
//  DrawableVertex.m
//  ver
//
//  Created by Kévin Gomez on 09/02/14.
//
//

#import "DrawableVertex.h"
#import "VertexView.h"
@interface DrawableVertex ()

@property (readwrite)VertexView* vertexView;


@end


@implementation DrawableVertex


- (id) init
{
    if (self = [super init]) {
        self.vertexView = [[VertexView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
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
    [self.vertexView setNeedsDisplay];
}

- (void) setHexColor: (int) color
{
    [super setHexColor:color];

    unsigned char r, g, b;

    b = color & 0xFF;
    g = (color >> 8) & 0xFF;
    r = (color >> 16) & 0xFF;

    self.vertexView.color = [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
    [self.vertexView setNeedsDisplay];
}

@end