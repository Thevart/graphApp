//
//  FingerVertexSelector.h
//  ver
//
//  Created by Kévin Gomez on 03/03/14.
//
//

#import <Foundation/Foundation.h>
#import "Graph.h"

@interface FingerVertexSelector : NSObject

-(id) initWithGraph: (Graph*) g;

-(void) startSelectionAtLocation: (CGPoint) location;
-(void) updateWithLocation: (CGPoint) location;
-(void) clear;
-(void) draw;

-(NSArray*) getSelectedVertices;

@end
