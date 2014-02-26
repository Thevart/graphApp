//
//  ViewController.h
//  ver
//
//

#import <UIKit/UIKit.h>
#import "Graph.h"
#import "DrawableVertex.h"
#import "DrawableEdge.h"
#import "DrawableGraph.h"


@interface ViewController : UIViewController <UIScrollViewDelegate>
{
    DrawableGraph* graph;
    Vertex* origin;
    Vertex* destination;
    Edge *touchedEdge;
}

@property (weak, nonatomic) IBOutlet UIButton *edgeMenu;
- (IBAction)deleteEdge:(id)sender;
- (IBAction)deleteVertex:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *vertexMenu;
@property (weak, nonatomic) IBOutlet UILabel *vertexCountLabel;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@end
