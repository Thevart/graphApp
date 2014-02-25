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


@interface ViewController : UIViewController
{
    Graph* graph;
    Vertex* origin;
    Vertex* destination;
    DrawableGraph *drawableGraph;
    DrawableVertex *touchedVertex;
    Edge *touchedEdge;
}

@property (weak, nonatomic) IBOutlet UIButton *edgeMenu;

@property (weak, nonatomic) IBOutlet UIButton *vertexMenu;
@property (weak, nonatomic) IBOutlet UILabel *vertexCountLabel;


- (void) addVertex:(int)x y:(int)y;
- (void) addEdge;
@end
