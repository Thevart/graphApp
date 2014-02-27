//
//  TestViewController.h
//  ver
//
//  Created by Arthur Thevenet on 27/02/14.
//
//

#import <UIKit/UIKit.h>
#import "TouchReceptor.h"
#import "DrawableGraph.h"
@interface TestViewController : UIViewController
{
    DrawableGraph* graph;
    TouchReceptor* tr;
}
@end
