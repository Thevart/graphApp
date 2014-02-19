//
//  VertexView.h
//  ver
//
//  Created by Arthur Thevenet on 13/02/14.
//
//

#import <UIKit/UIKit.h>

@interface VertexView : UIView
@property UIColor *color;
@property NSString* label;
@property UILabel* uilabel;
-(void)setPostion:(int)x y:(int)y;
@end
