//
//  DrawableVertex.m
//  ver
//
//  Created by Kévin Gomez on 09/02/14.
//
//

#import "DrawableVertex.h"
#import "VertexView.h"
@interface DrawableVertex ()

@property (readwrite)VertexView* vertexView;


@end


@implementation DrawableVertex


- (id) initWithCoord:(int)x y:(int)y
{
    
    if (self = [super init]) {
        [self setPosition:x y:y];
        self.vertexView=[[VertexView alloc] initWithFrame:CGRectMake(x-15,y-15,30,30)];
        
    }

    return self;
}

- (void) setPosition: (int)x y:(int) y
{
    [super setPosition:x y:y];
    
    self.vertexView.center = CGPointMake(x-15, y-15);
}

@end