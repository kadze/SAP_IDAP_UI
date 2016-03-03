//
//  SAPImageModel.m
//  IOSProject
//
//  Created by S A P on 3/3/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPImageModel.h"
#import "SAPOwnershipMacro.h"

@interface SAPImageModel ()
@property (nonatomic, strong) UIImage     *image;
@property (nonatomic, strong) NSURL       *url;
@property (nonatomic, strong) NSOperation *operation;

@end

@implementation SAPImageModel

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.operation = nil;
}

- (instancetype)initWithUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        self.url = url;
    }
    
    return self;
}


#pragma mark -
#pragma mark Accessors

- (BOOL)imageLoaded {
    return nil != self.image;
}

- (void)setOperation:(NSOperation *)operation {
    if (_operation != operation) {
        [_operation cancel];
        
        _operation = operation;
    }
}

#pragma mark -
#pragma mark Class Methods

+ (instancetype)imageWithUrl:(NSURL *)url {
    return [[self alloc] initWithUrl:url];
}

#pragma mark -
#pragma mark Public

- (void)load {
    @synchronized(self) {
        if (kSAPModelStateWillLoad == self.state) {
            return;
        }
        
        if (kSAPModelStateDidFinishLoading == self.state) {
            [self notifyObserversWithSelector:[self selectorForState:kSAPModelStateDidFinishLoading]];
            return;
        }
        
        self.state = kSAPModelStateWillLoad;
    }
    
    static NSOperationQueue *queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [NSOperationQueue new];
        queue.maxConcurrentOperationCount = 2;
    });
    
    SAPWeakify(self);
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        SAPStrongifyAndReturnIfNil(self);
        self.image = [UIImage imageWithContentsOfFile:[self.url absoluteString]];
    }];
    
    operation.completionBlock = ^{
        SAPStrongifyAndReturnIfNil(self);
        self.state = self.image ? kSAPModelStateDidFinishLoading : kSAPModelStateDidFailLoading;
    };
    
    [queue addOperation:operation];
    self.operation = operation;
}

- (void)dump {
    @synchronized(self) {
        self.operation = nil;
        self.image = nil;
        self.state = kSAPModelStateUnloaded;
    }
}

@end
