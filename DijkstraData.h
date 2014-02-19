//
//  DijkstraData.h
//  ver
//
//  Created by Kévin Gomez on 19/02/14.
//
//

#import <Foundation/Foundation.h>
#import "Vertex.h"
#import "PriorityQueueItem.h"

@interface DijkstraData : NSObject

@property unsigned int distance;
@property (weak) Vertex* previous;
@property (weak) PriorityQueueItem* pqItem;

@end
