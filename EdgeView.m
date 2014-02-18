//
//  EdgeView.m
//  ver
//
//  Created by Arthur Thevenet on 12/02/14.
//
//

#import "EdgeView.h"

@implementation EdgeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self ) {
        UIColor *color =[ UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
        self.backgroundColor=color;
    }

    return self;
}

- (void) setPosition: (Coord*)origin destination:(Coord*) desti
{
    self.origin = origin;
    self.destination = desti;
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0);
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat components[] = {0.0, 0.0, 1.0, 1.0};
    
    CGColorRef color = CGColorCreate(colorspace, components);
    CGContextSetFillColorWithColor(context, color);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);

    CGContextMoveToPoint(context, self.origin.x, self.origin.y);
    CGContextAddLineToPoint(context, self.destination.x, self.destination.y);
    
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
   
}

@end
