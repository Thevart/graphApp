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
    _uilabel = [[UILabel alloc]initWithFrame:CGRectMake(-30, 0, 30, 15)];
    
    _uilabel.numberOfLines = 1;
    _uilabel.baselineAdjustment = YES;
    _uilabel.adjustsFontSizeToFitWidth = YES;
    _uilabel.adjustsLetterSpacingToFitWidth = YES;
    _uilabel.clipsToBounds = YES;
    _uilabel.backgroundColor = [UIColor clearColor];
    _uilabel.textColor = [UIColor blackColor];
    _uilabel.textAlignment = NSTextAlignmentLeft;
    _uilabel.text = self.label;

    [self addSubview:_uilabel];
}

- (void) setPostion:(int)x y:(int) y;
{
    self.center = CGPointMake(x,y);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, _color.CGColor);
    CGContextSetAlpha(context, 0.5);
    CGContextFillEllipseInRect(context, CGRectMake(0,0,30,30));
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(context, CGRectMake(0,0,30,30));

    [self drawLabel];
}

@end