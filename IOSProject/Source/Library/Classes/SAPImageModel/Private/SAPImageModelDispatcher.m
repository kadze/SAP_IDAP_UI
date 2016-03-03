//
//  SAPImageModelDispatcher.m
//  IOSProject
//
//  Created by S A P on 3/3/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPImageModelDispatcher.h"

@interface SAPImageModelDispatcher ()
@property (nonatomic, strong) NSOperationQueue *queue;

- (void)initQueue;

@end

@implementation SAPImageModelDispatcher

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.queue = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initQueue];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setQueue:(NSOperationQueue *)queue {
    if (_queue != queue) {
        [_queue cancelAllOperations];
        
        _queue = queue;
    }
}

//- (NSOperationQueue *)queue {
//    static NSOperationQueue *queue = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        queue = [NSOperationQueue new];
//        queue.maxConcurrentOperationCount = 2;
//    });
//    
//    return queue;
//}

#pragma mark -
#pragma mark Private

- (void)initQueue {
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.maxConcurrentOperationCount = 2;
    
    self.queue = queue;
}

@end
