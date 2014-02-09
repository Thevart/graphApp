//
//  ViewController.h
//  ver
//
//  Created by Michel Martin on 20/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Graph.h"

@interface ViewController : UIViewController
{
    Graph* graph;
}

@property (weak, nonatomic) IBOutlet UILabel *vertexCountLabel;

- (void) addVertex:(int)x y:(int)y;
@end
