//
//  DrawableEdge.m
//  ver
//
//  Created by Arthur Thevenet on 10/02/14.
//
//

#import "DrawableEdge.h"
@interface DrawableEdge ()

@property (readwrite) UIView* view;

@end

@implementation DrawableEdge


- (id)initWithFrame:(CGRect)frame
{
   if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    //Set the width of the pen mark
    CGContextSetLineWidth(context, 1.0);
    
    // Draw a line
    //Start at this point
    CGContextMoveToPoint(context, 10.0, 30.0);
    
    //Give instructions to the CGContext
    //(move "pen" around the screen)
    CGContextAddLineToPoint(context, 310.0, 30.0);
     CGContextStrokePath(context);
    
}
- (void) setPosition: (int)x y:(int) y
{

    
    self.view.center = CGPointMake(x, y);
}

@end