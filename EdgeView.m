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
        self.color=[ UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
        self.pathWidth=6;
        
    }

    return self;
}

- (void) setPosition: (Coord*)origin destination:(Coord*) desti
{
    self.origin = origin;
    self.destination = desti;
    
}

- (void)createPath {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(   path, nil, self.origin.x, self.origin.y);
    CGPathAddLineToPoint(path, nil, self.origin.x+2, self.origin.y+2);
    CGPathAddLineToPoint(path, nil, self.destination.x, self.destination.y);
    CGPathAddLineToPoint(path, nil, self.destination.x+2, self.destination.y+2);
    self.pathref   = path;
    
    
    CGContextRef context = [self createOffscreenContext];
    CGContextSetLineWidth(context, self.pathWidth);
    
    CGContextBeginPath(context);
    CGContextAddPath(context, self.pathref);
}

- (CGContextRef)createOffscreenContext {
    CFMutableDataRef empty = CFDataCreateMutable(NULL, 0);
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData(empty);
    self.offscreenContext = CGPDFContextCreate(consumer, NULL, NULL);
    CGDataConsumerRelease(consumer);
    CFRelease(empty);
    return self.offscreenContext;
}
- (void)drawRect:(CGRect)rect {
    [self createPath ];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.pathWidth);
    CGContextAddPath(context, self.pathref);
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    CGContextStrokePath(context);

}


- (bool) containPoint: (CGPoint)location
{
    
    if( CGContextPathContainsPoint(self.offscreenContext, location, kCGPathStroke)){
        NSLog(@"We detect that u touched my tralala");
        return true;
    }
    return false;
    
}
@end
