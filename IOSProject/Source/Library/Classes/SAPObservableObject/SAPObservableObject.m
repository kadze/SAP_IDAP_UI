//
//  SAPObservableObject.m
//  MacCourse
//
//  Created by S A P on 12/10/15.
//  Copyright © 2015 Yosemite Retail. All rights reserved.
//

#import "SAPObservableObject.h"
#import "SAPAssignReference.h"

@interface SAPObservableObject ()
@property (nonatomic, retain)    NSMutableSet    *mutableObservers;

@end

@implementation SAPObservableObject

@dynamic observers;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableObservers = [NSMutableSet set];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)observers {
    NSMutableSet *mutableObservers = self.mutableObservers;
    @synchronized(mutableObservers) {
        NSMutableArray *mutableResult = [NSMutableArray arrayWithCapacity:mutableObservers.count];
        for (SAPAssignReference *observer in mutableObservers) {
            [mutableResult addObject:observer.target];
        }
        
        return [mutableResult copy];
    }
}

- (void)setState:(NSUInteger)state {
    if (_state != state) {
        _state = state;
        SEL selector = [self selectorForState:state];
        if (selector) {
            [self notifyObserversWithSelector:selector withObject:self];
        }
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)addObserver:(id)observer {
    @synchronized(self) {
        [self.mutableObservers addObject:[[SAPAssignReference alloc] initWithTarget:observer]];
    }
}

- (void)removeObserver:(id)observer {
    @synchronized(self) {
        [self.mutableObservers removeObject:[[SAPAssignReference alloc] initWithTarget:observer]];
    }
}

- (void)removeObserversFromArray:(NSArray *)array {
    @synchronized(self) {
        for (id observer in array) {
            [self removeObserver:observer];
        }
    }
}

- (void)addObserversFromArray:(NSArray *)array {
    @synchronized(self) {
        for (id observer in array) {
            [self addObserver:observer];
        }
    }
}

- (void)notifyObserversWithSelector:(SEL)selector {
    [self notifyObserversWithSelector:(SEL)selector withObject:(id)nil];
}

- (void)notifyObserversWithSelector:(SEL)selector withObject:(id)object {
    @synchronized(self) {
        for (SAPAssignReference *reference in self.mutableObservers) {
            id observer = reference.target;
            if ([observer respondsToSelector:selector]) {
                [observer performSelector:selector withObject:object ];
            }
        }
    }
}

- (SEL)selectorForState:(NSUInteger)state {
    return nil;
}

@end
