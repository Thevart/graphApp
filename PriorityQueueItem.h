//
//  PriorityQueueItem.h
//  ver
//
//  Created by Kévin Gomez on 19/02/14.
//
//

#import <Foundation/Foundation.h>
#import "PriorityQueue.h"

@interface PriorityQueueItem : NSObject <PriorityQueueObject>

@property (nonatomic, assign, readwrite) id obj;
@property (nonatomic, assign, readwrite) NSInteger value;

+ (id) objectWithValues:(id) obj value:(NSInteger) value;

- (id) initWithValues:(id) obj value:(NSInteger) value;
@end
