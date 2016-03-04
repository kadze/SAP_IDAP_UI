//
//  SAPImageModel.m
//  IOSProject
//
//  Created by S A P on 3/3/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPImageModel.h"

#import "NSFileManager+SAPExtensions.h"

#import "SAPOwnershipMacro.h"

@interface SAPImageModel ()
@property (nonatomic, strong) UIImage     *image;
@property (nonatomic, strong) NSURL       *url;

- (NSOperationQueue *)sharedQueue;
- (NSBlockOperation *)loadingOperation;

@end

@implementation SAPImageModel

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        self.url = url;
    }
    
    return self;
}

#pragma mark -
#pragma mark Class Methods

+ (instancetype)imageWithUrl:(NSURL *)url {
    return [[self alloc] initWithUrl:url];
}

#pragma mark -
#pragma mark Public

- (void)performBackgroundLoading {
    NSBlockOperation *operation = [self loadingOperation];
    [[self sharedQueue] addOperation:operation];
}

- (NSString *)path {
    return [[NSFileManager appStatePath] stringByAppendingPathComponent:[self.url absoluteString]];
}

#pragma mark -
#pragma mark Private

- (NSOperationQueue *)sharedQueue {
    static NSOperationQueue *queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [NSOperationQueue new];
        queue.maxConcurrentOperationCount = 2;
    });
    
    return queue;
}

- (NSBlockOperation *)loadingOperation {
    SAPWeakify(self);
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        SAPStrongifyAndReturnIfNil(self);
        self.image = [UIImage imageWithContentsOfFile:[self.url absoluteString]];
    }];
    
    operation.completionBlock = ^{
        SAPStrongifyAndReturnIfNil(self);
        self.state = self.image ? kSAPModelStateDidFinishLoading : kSAPModelStateDidFailLoading;
    };
    
    return operation;
}

@end
