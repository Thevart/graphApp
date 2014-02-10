//
//  DrawableVertex.m
//  ver
//
//  Created by Kévin Gomez on 09/02/14.
//
//

#import "DrawableVertex.h"

@interface DrawableVertex ()

@property (readwrite) UIView* view;

@end


@implementation DrawableVertex


- (id) init
{
    if (self = [super init]) {
        CGRect rectangle = CGRectMake(100, 100, 30, 30);
        
        self.view = [[UIView alloc] initWithFrame:CGRectInset(rectangle, 10, 10)];
        self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin;
        UIColor *color = [UIColor colorWithRed:197.0/255.0 green: 169.0/255.0 blue: 140.0/255.0 alpha: 1.0];
        self.view.backgroundColor = color;
    }

    return self;
}

- (void) setPosition: (int)x y:(int) y
{
    [super setPosition:x y:y];
    
    self.view.center = CGPointMake(x, y);
}

@end