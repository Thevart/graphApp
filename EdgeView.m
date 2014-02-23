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
        _color=[ UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];;
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
    
    CGContextSetLineWidth(_context, 6.0);
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    
    CGContextSetFillColorWithColor(_context, _color.CGColor);
    CGContextSetStrokeColorWithColor(_context, _color.CGColor);
    CGContextMoveToPoint(_context, self.origin.x, self.origin.y);
    CGContextAddLineToPoint(_context, self.destination.x, self.destination.y);
    CGContextStrokePath(_context);
    
    //Code censé dessiner une flèche
    /*CGContextSetFillColorWithColor(_context, [[UIColor redColor] CGColor]);
    CGContextMoveToPoint(_context, self.destination.x, self.destination.y);
    CGContextAddLineToPoint(_context, self.destination.x+15, self.destination.y+15);
    CGContextAddLineToPoint(_context,self.destination.x+30, self.destination.y+50);
    CGContextFillPath(_context);*/
    
    CGColorSpaceRelease(colorspace);
    CGContextDrawPath(_context, kCGPathStroke);
    

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
