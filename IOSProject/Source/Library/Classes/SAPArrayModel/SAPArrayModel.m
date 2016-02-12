//
//  SAPArrayModel.m
//  IOSProject
//
//  Created by S A P on 2/12/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPArrayModel.h"



@interface SAPArrayModel ()
@property (nonatomic, strong) NSMutableArray *mutableObjects;

@end

@implementation SAPArrayModel

@dynamic objects;
@dynamic count;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableObjects = [NSMutableArray new];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)objects {
    @synchronized(self) {
        return [self.mutableObjects copy];
    }
}

- (NSUInteger)count {
    @synchronized(self) {
        return self.mutableObjects.count;
    }
}

#pragma mark -
#pragma mark Public

- (id)objectAtIndex:(NSUInteger) index {
    @synchronized(self) {
        return [self.mutableObjects objectAtIndex:index];
    }
}

- (id)objectAtIndexedSubscript:(NSUInteger) index {
    @synchronized(self) {
        return [self objectAtIndex:index];
    }
}

- (void)addObject:(id)anObject {
    @synchronized(self) {
        [self.mutableObjects addObject:anObject];
        
        NSUInteger indexes[] = {0, self.count - 1};
        NSIndexPath *ip = [NSIndexPath indexPathWithIndexes:indexes length:2];
        [self notifyObserversWithSelector:@selector(insertRowWithIndexPath:) withObject:ip];
    }
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    @synchronized(self) {
        [self.mutableObjects insertObject:anObject atIndex:index];
        
    }
}

- (void)removeLastObject {
    @synchronized(self) {
        [self.mutableObjects removeLastObject];
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    @synchronized(self) {
        [self.mutableObjects removeObjectAtIndex:index];
        NSUInteger indexes[] = {0, index};
        NSIndexPath *ip = [NSIndexPath indexPathWithIndexes:indexes length:2];
        [self notifyObserversWithSelector:@selector(deleteRowWithIndexPath:) withObject:ip];
    }
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    @synchronized(self) {
        [self.mutableObjects replaceObjectAtIndex:index withObject:anObject];
    }
}

- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
    @synchronized(self) {
        [self.mutableObjects exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
    }
}

@end
