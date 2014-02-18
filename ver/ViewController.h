//
//  ViewController.h
//  ver
//
//

#import <UIKit/UIKit.h>
#import "Graph.h"
#import "DrawableVertex.h"

@interface ViewController : UIViewController
{
    Graph* graph;
    Vertex* origin;
    Vertex* destination;
    DrawableVertex *touchedVertex;
}


@property (weak, nonatomic) IBOutlet UIButton *vertexMenu;
@property (weak, nonatomic) IBOutlet UILabel *vertexCountLabel;

- (IBAction)deleteVertexButton:(id)sender;
- (void) addVertex:(int)x y:(int)y;
- (void) addEdge;
@end
