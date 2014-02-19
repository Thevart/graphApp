//
//  NewPriorityQueue.h
//  ver
//
//  Created by Kévin Gomez on 19/02/14.
//
//

#import <Foundation/Foundation.h>

@protocol PriorityQueueObject <NSObject>
- (NSInteger)value;
@end

@interface PriorityQueueHeaderNode : NSObject <PriorityQueueObject>
@end

@interface PriorityQueue : NSObject

- (void)addObject:(id<PriorityQueueObject>) object;
- (id<PriorityQueueObject>) pop;

- (id<PriorityQueueObject>) first;
- (NSUInteger) count;

- (void) clear;
- (void) rebuild;

@end
