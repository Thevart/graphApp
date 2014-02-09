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
        UIImage *img = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"cercle"ofType:@"png"]];
        CGRect cropRect = CGRectMake(0, 0, 30, 30);
        CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage], cropRect);
        self.view = [[UIImageView alloc] initWithFrame:CGRectMake(150, 10, 30, 30)];
        ((UIImageView *)self.view).image = [UIImage imageWithCGImage:imageRef];
        self.view.alpha = 1.0f;

        CGImageRelease(imageRef);
    }

    return self;
}

- (void) setPosition: (int)x y:(int) y
{
    [super setPosition:x y:y];
    
    self.view.center = CGPointMake(x, y);
}

@end