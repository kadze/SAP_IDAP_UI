//
//  SAPModel.m
//  IOSProject
//
//  Created by S A P on 2/23/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPModel.h"

#import "SAPDispatch.h"

@implementation SAPModel

#pragma mark -
#pragma mark SAPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case kSAPModelStateUnloaded:
            return @selector(modelDidBecomeUnloaded:);
            
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
        
        SAPDispatchAsyncOnDefaultQueue(^{
            [self performLoading];
        });
    }
}

@end

