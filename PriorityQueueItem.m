//
//  PriorityQueueItem.m
//  ver
//
//  Created by Kévin Gomez on 19/02/14.
//
//

#import "PriorityQueueItem.h"

@implementation PriorityQueueItem

@synthesize value = _value;
@synthesize obj = _obj;

+ (id) objectWithValues:(id) obj value:(NSInteger) value
{
    return [[self alloc] initWithValues:obj value:value];
}

- (id) init
{
    return [self initWithValues:nil value:0];
}

- (id) initWithValues:(id) obj value:(NSInteger) value
{
    if ((self = [super init])) {
        _obj = obj;
        _value = value;
    }
    return self;
}

@end
