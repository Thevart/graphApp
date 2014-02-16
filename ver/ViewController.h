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

@property (weak, nonatomic) IBOutlet UILabel *vertexCountLabel;

- (void) addVertex:(int)x y:(int)y;
- (void) addEdge;
@end
