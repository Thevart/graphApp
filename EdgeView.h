//
//  EdgeView.h
//  ver
//
//  Created by Arthur Thevenet on 12/02/14.
//
//

#import <UIKit/UIKit.h>
#import "Coord.h"
@interface EdgeView : UIView
@property Coord* origin;
@property Coord* destination;
@property CGContextRef context;
@property UIColor* color;
- (void) setPosition: (Coord*)origin destination:(Coord*) desti;
- (bool) containPoints: (CGPoint)location;
@end
