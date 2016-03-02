//
//  SAPModel.m
//  IOSProject
//
//  Created by S A P on 2/23/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPModel.h"

#import "SAPDispatch.h"
#import "NSFileManager+SAPExtensions.h"

#import "SAPOwnershipMacro.h"

@implementation SAPModel

@dynamic cached;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        SAPWeakify(self);
        [self performBlockWithoutNotification:^{
            SAPStrongify(self);
            self.state = kSAPModelStateUnloaded;
        }];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (BOOL)cached {
    NSFileManager *fileManager = [NSFileManager defaultManager];

    return [fileManager fileExistsAtPath:[NSFileManager appStatePath]];
}

#pragma mark -
#pragma mark SAPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case kSAPModelStateUnloaded:
            return @selector(modelDidUnload:);
            
        case kSAPModelStateWillLoad:
            return @selector(modelWillLoad:);
            
        case kSAPModelStateDidFinishLoading:
            return @selector(modelDidFinishLoading:);
        
        case kSAPModelStateDidFailLoading:
            return @selector(modelDidFailLoading:);
        
        default:
            return [super selectorForState:state];
    }
}

#pragma mark -
#pragma mark Public

- (void)load {
    @synchronized(self) {
        NSUInteger state = self.state;
        if (kSAPModelStateDidFinishLoading == state || kSAPModelStateWillLoad == state) {
            [self notifyObserversWithSelector:[self selectorForState:state]];
            
            return;
        }
        
        self.state = kSAPModelStateWillLoad;
        
        SAPDispatchAsyncOnDefaultQueue(^{
            [self performBackgroundLoading];
        });        
    }
}

- (void)performBackgroundLoading {
    
}

@end

