//
//  TouchRecpetor.m
//  ver
//
//  Created by Arthur Thevenet on 27/02/14.
//
//

#import "TouchReceptor.h"
#import "DrawableVertex.h"
@implementation TouchReceptor

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIColor *color = [ UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
        self.backgroundColor = color;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    self.currentPath = [UIBezierPath bezierPath];
    self.currentPath.lineWidth = 3.0;
    [self.currentPath moveToPoint:[touch locationInView:self]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
     UITouch *touch = [[event allTouches] anyObject];
    [self.currentPath addLineToPoint:[touch locationInView:self]];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSMutableArray *vertices = [self patateContainsPoint];
    for (DrawableVertex *vertex in vertices)
    {
        [vertex setColor:[Color initFromRGB:0 g:0 b:255]];
    }
}

- (void)drawRect:(CGRect)rect {
    [[UIColor redColor] set];
    [self.currentPath stroke];
}

-(NSMutableArray*) patateContainsPoint
{
    NSMutableArray *vertices = [[NSMutableArray alloc] init];
    for( NSString* id in self.graph.vertices)
    {
        DrawableVertex *vertex = [self.graph.vertices objectForKey:id];
        if([self.currentPath containsPoint:CGPointMake(vertex.coord.x, vertex.coord.y)])
        {
            [vertices addObject:vertex];
        }
    }
    return vertices;
}

@end
