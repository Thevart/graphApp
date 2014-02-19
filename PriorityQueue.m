//
//  NewPriorityQueue.m
//  ver
//
//  Created by Kévin Gomez on 19/02/14.
//
//

#import "PriorityQueue.h"

@implementation PriorityQueueHeaderNode

- (NSInteger)value
{
    return NSIntegerMin;
}

@end

@interface PriorityQueue()
@property (atomic, strong) NSMutableArray *queue;
@end

@implementation PriorityQueue

#pragma mark - Properties

@synthesize queue = _queue;

- (id) init
{
    if ((self = [super init])) {
        [self clear];
    }

    return self;
}

- (void) clear
{
    self.queue = [[NSMutableArray alloc] initWithObjects:[[PriorityQueueHeaderNode alloc] init], nil];
}

#pragma mark - PriorityQueue

- (void) addObject:(id<PriorityQueueObject>) object
{
    NSUInteger last_index = [self count];
    NSUInteger parent_index = last_index / 2;

    [self.queue addObject:object];

    id<PriorityQueueObject> parent = [self.queue objectAtIndex:parent_index];

    while (object.value < parent.value) //compare with parent
    {
        [self.queue removeObject:object];
        [self.queue insertObject:object atIndex:parent_index];

        [self.queue removeObject:parent];
        [self.queue insertObject:parent atIndex:last_index]; //swap

        last_index = parent_index; //increment
        parent_index /= 2;

        parent = [self.queue objectAtIndex:parent_index]; //re-assign parent
    }
}

- (id<PriorityQueueObject>) pop
{
    id<PriorityQueueObject> first_object_to_return = [self first];

    if (nil == first_object_to_return) {
        return nil;
    }

    NSUInteger first_index = 1;
    NSUInteger last_index = [self count] - 1;

    if (last_index == first_index) {
        [self.queue removeObjectAtIndex:last_index];
        return first_object_to_return;
    }

    id<PriorityQueueObject> last_object = [self.queue objectAtIndex:last_index];
    [self.queue removeObjectAtIndex:last_index];

    [self.queue removeObjectAtIndex:1];
    [self.queue insertObject:last_object atIndex:1];

    NSUInteger i, child;

    for (i = first_index; i * 2 < [self count]; i = child) {
        child = i * 2;

        id<PriorityQueueObject> child_obj = [self.queue objectAtIndex:child];
        id<PriorityQueueObject> child_2;

        if (child + 1 < [self count]) {
            child_2 = [self.queue objectAtIndex:child + 1];

            if (child_2.value < child_obj.value) {
                child++;
                child_obj = child_2;
            }
        }

        if (last_object.value > child_obj.value) {
            [self.queue removeObject:child_obj];
            [self.queue insertObject:child_obj atIndex:i];

            [self.queue removeObject:last_object];
            [self.queue insertObject:last_object atIndex:child];
        } else {
            break;
        }
    }
    
    return first_object_to_return;
}

- (void) rebuild
{
    int len = [self count] / 2;

    for (int i = len; i > 1; i--) {
        [self heapify:i];
    }
}

-(void) heapify: (int) i
{
    int l = i * 2;
    int r = i * 2 + 1;
    NSUInteger largest;

    if (l < [self count] && ((id<PriorityQueueObject>) [self.queue objectAtIndex:i]).value < ((id<PriorityQueueObject>) [self.queue objectAtIndex:l]).value) {
        largest = l;
    } else {
        largest = i;
    }

    if (r < [self count] && ((id<PriorityQueueObject>) [self.queue objectAtIndex:largest]).value < ((id<PriorityQueueObject>) [self.queue objectAtIndex:r]).value) {
        largest = r;
    }

    if (largest != i) {
        id<PriorityQueueObject> objI = [self.queue objectAtIndex:i];
        id<PriorityQueueObject> objLargest = [self.queue objectAtIndex:largest];
        [self.queue removeObject:objLargest];
        [self.queue insertObject:objLargest atIndex:i];

        [self.queue removeObject:objI];
        [self.queue insertObject:objI atIndex:largest];

        [self heapify:largest];
    }
}

- (id<PriorityQueueObject>) first
{
    if (self.queue.count < 2) return nil;
    
    return [self.queue objectAtIndex:1];
}

- (NSUInteger) count
{
    return self.queue.count;
}

-(NSString *) description
{
    return [[self queue] description];
}

@end