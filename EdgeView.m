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
    _context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(_context, 10.0);
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat components[] = {0.0, 0.0, 1.0, 1.0};
    
    CGColorRef color = CGColorCreate(colorspace, components);
    CGContextSetFillColorWithColor(_context, color);
    CGContextSetStrokeColorWithColor(_context, [UIColor blueColor].CGColor);

    CGContextMoveToPoint(_context, self.origin.x, self.origin.y);
    CGContextAddLineToPoint(_context, self.destination.x, self.destination.y);
    
    CGContextStrokePath(_context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
    CGContextDrawPath(_context, kCGPathStroke);
    CGContextStrokePath(_context);
}


- (bool) containPoints: (CGPoint)location
{


    if( CGContextPathContainsPoint (_context,location,kCGPathStroke)){
        NSLog(@"We detext that u touched my tralala");
        return true;
    }
    NSLog(@"NOOOOO");
    return false;
    
}
@end
