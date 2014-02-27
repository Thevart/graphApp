//
//  EdgeView.m
//  ver
//
//  Created by Arthur Thevenet on 12/02/14.
//
//

#import "EdgeView.h"
#import "UIBezierPath+dqd_arrowhead.h"

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
    
    
    [self createOffscreenContext];
    
   // CGContextBeginPath(context);
}
- (CGMutablePathRef)createPathTriangle {
    float x = (self.origin.x+self.destination.x)/2;
    float y = (self.origin.y+self.destination.y)/2;
    float pente;
    if(self.origin.y!=self.destination.y){
        pente = (self.origin.x-self.destination.x)/(self.origin.y - self.destination.y);

    }
    else{
        pente = 0;
    }
    float pentePerpen = -pow(pente, -1);
    float b=y-(x*pente);
    float bPerpen=y-(x*pentePerpen);
    
        CGMutablePathRef path = CGPathCreateMutable();


    /*CGPathMoveToPoint(   path, nil, x,y);
    CGPathAddLineToPoint(path, nil, x+2, pentePerpen*(x+2)+bPerpen);
    CGPathAddLineToPoint(path, nil, x+4, pente*(x+4)+b);
    CGPathAddLineToPoint(path, nil, x-2, pentePerpen*(x-2)+bPerpen);*/
    /*CGPathMoveToPoint(path, NULL,x, y);
    CGPathAddLineToPoint(path, NULL,-10+x,y);
    CGPathAddLineToPoint(path, NULL,x,20+y);
    CGPathAddLineToPoint(path, NULL,10+x,y);
    CGPathCloseSubpath(path);*/
    return path;
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
    float x = (self.origin.x+self.destination.x)/2;
    float y = (self.origin.y+self.destination.y)/2;
    float x2 = (x+self.destination.x)/2;
    float y2 = (y+self.destination.y)/2;
    CGPoint startPoint=CGPointMake(x,y);
    CGPoint endPoint=CGPointMake(x2, y2);
    
    
    /*
    UIBezierPath *BezierPath = [UIBezierPath dqd_bezierPathWithArrowFromPoint:(CGPoint)startPoint
                                                                      toPoint:(CGPoint)endPoint
                                                                    tailWidth:(CGFloat)10
                                                                    headWidth:(CGFloat)50
                                                                   headLength:(CGFloat)10];
    [BezierPath setLineWidth:2.0];
    [BezierPath stroke];*/
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.pathWidth);
    CGContextAddPath(context, self.pathref);
        CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    CGContextAddPath(context, [self createPathTriangle]);
    CGContextStrokePath(context);

}


- (bool) containPoint: (CGPoint)location
{
    return CGContextPathContainsPoint(self.offscreenContext, location, kCGPathStroke);
}
@end
