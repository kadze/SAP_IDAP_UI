//
//  SAPArrayModel.m
//  IOSProject
//
//  Created by S A P on 2/12/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPArrayModel.h"
#import "SAPChangeModel.h"

@interface SAPArrayModel ()
@property (nonatomic, strong) NSMutableArray *mutableObjects;

- (void)notifyWithChangeType:(SAPChangeType)changeType indexes:(NSArray *)indexes;
- (void)notifyWithChangeType:(SAPChangeType)changeType index:(NSInteger)index;

@end

@implementation SAPArrayModel

@dynamic count;
@dynamic objects;

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
        
        [self notifyWithChangeType:kSAPChangeTypeObjectAdded index:self.count - 1];//es:nil];
    }
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    @synchronized(self) {
        [self.mutableObjects insertObject:anObject atIndex:index];
        
        [self notifyWithChangeType:kSAPChangeTypeObjectInserted index:index];
    }
}

- (void)removeLastObject {
    @synchronized(self) {
        [self.mutableObjects removeLastObject];
        
        [self notifyWithChangeType:kSAPChangeTypeObjectRemoved index:self.count -1];
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    @synchronized(self) {
        [self.mutableObjects removeObjectAtIndex:index];

        [self notifyWithChangeType:kSAPChangeTypeObjectRemoved index:index];
    }
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    @synchronized(self) {
        [self.mutableObjects replaceObjectAtIndex:index withObject:anObject];
        
        [self notifyWithChangeType:kSAPChangeTypeObjectReplaced index:index];
    }
}

- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
    @synchronized(self) {
        [self.mutableObjects exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
        
        NSArray *indexes = [NSArray arrayWithObjects:[NSNumber numberWithInteger:idx1],
                                                     [NSNumber numberWithInteger:idx2],
                                                     nil];
        [self notifyWithChangeType:kSAPChangeTypeObjectExchanged indexes:indexes];
    }
}

#pragma mark -
#pragma mark Private

- (void)notifyWithChangeType:(SAPChangeType)changeType indexes:(NSArray *)indexes {
    if (!self.notificationEnabled) {
        return;
    }
    
    SAPChangeModel *changeModel = [SAPChangeModel modelWithChangeType:changeType
                                                               indexes:indexes];
    [self notifyObserversWithSelector:@selector(arrayModelChangedWithChangeModel:)
                           withObject:changeModel];
}

- (void)notifyWithChangeType:(SAPChangeType)changeType index:(NSInteger)index {
    NSArray *indexes = [NSArray arrayWithObject:[NSNumber numberWithInteger:index]];
    [self notifyWithChangeType:changeType indexes:indexes];
}

@end
