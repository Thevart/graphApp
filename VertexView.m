//
//  VertexView.m
//  ver
//
//  Created by Arthur Thevenet on 13/02/14.
//
//
#include <UIKit/UIKit.h>
#import "VertexView.h"

@implementation VertexView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }

    return self;

}

-(void)setPostion:(int)x y:(int)y;
{
    self.center=CGPointMake(x,y);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, _color.CGColor);
    CGContextSetAlpha(context, 0.5);
    CGContextFillEllipseInRect(context, CGRectMake(0,0,self.frame.size.width,self.frame.size.height));
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(context, CGRectMake(0,0,self.frame.size.width,self.frame.size.height));
    
}


@end
