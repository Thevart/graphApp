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

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIColor *color = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
        self.backgroundColor=color;
        self.uilabel=[[UILabel alloc]initWithFrame:frame];
    }

    return self;
}
-(void) drawLabel
{
    self.uilabel = [[UILabel alloc]initWithFrame:CGRectMake(-30, 0, 30, 15)];
    
    self.uilabel.numberOfLines = 1;
    self.uilabel.baselineAdjustment = YES;
    self.uilabel.adjustsFontSizeToFitWidth = YES;
    self.uilabel.adjustsLetterSpacingToFitWidth = YES;
    self.uilabel.clipsToBounds = YES;
    self.uilabel.backgroundColor = [UIColor clearColor];
    self.uilabel.textColor = [UIColor blackColor];
    self.uilabel.textAlignment = NSTextAlignmentLeft;
    self.uilabel.text = self.label;

    [self addSubview:_uilabel];
}

- (void) setPostion:(int)x y:(int) y;
{
    self.center = CGPointMake(x,y);
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, _color.CGColor);
    CGContextSetAlpha(context, 1);
    CGContextFillEllipseInRect(context, CGRectMake(0,0,30,30));
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(context, CGRectMake(0,0,30,30));

    [self drawLabel];
}

@end