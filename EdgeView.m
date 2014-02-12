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
    if (self) {
        // Initialization code
         NSLog(@"Dans le Init");
    }
    self.backgroundColor=[UIColor whiteColor];
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0);
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat components[] = {0.0, 0.0, 1.0, 1.0};
    
    CGColorRef color = CGColorCreate(colorspace, components);
    CGContextSetFillColorWithColor(context, color);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);

    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 300, 400);
    
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
   
    NSLog(@"Dans le dt");
}


@end
