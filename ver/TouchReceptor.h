//
//  TouchRecpetor.h
//  ver
//
//  Created by Arthur Thevenet on 27/02/14.
//
//

#import <UIKit/UIKit.h>
#import "DrawableGraph.h"
@interface TouchReceptor : UIView

@property UIBezierPath* currentPath;
@property DrawableGraph* graph;

@property NSMutableArray* selectedVertices;
@property NSMutableArray* selectedEdges;

@property DrawableVertex* touchedVertex;
@property CGPoint firstPoint;
-(void) delete;
@end
