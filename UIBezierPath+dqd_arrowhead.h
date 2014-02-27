//
//  UIBezierPath+dqd_arrowhead.h
//  ver
//
//  Created by Arthur Thevenet on 27/02/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIBezierPath (dqd_arrowhead)

+ (UIBezierPath *)dqd_bezierPathWithArrowFromPoint:(CGPoint)startPoint
                                           toPoint:(CGPoint)endPoint
                                         tailWidth:(CGFloat)tailWidth
                                         headWidth:(CGFloat)headWidth
                                        headLength:(CGFloat)headLength;

@end