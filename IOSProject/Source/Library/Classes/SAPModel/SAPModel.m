//
//  SAPModel.m
//  IOSProject
//
//  Created by S A P on 2/23/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPModel.h"

@implementation SAPModel

#pragma mark -
#pragma mark SAPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case kSAPModelLoadingStateReady:
            return @selector(modelDidBecomeReadyToLoad:);
            
        case kSAPModelLoadingStateInProgress:
            return @selector(modelDidBeginLoad:);
            
        case kSAPModelLoadingStateDidFinish:
            return @selector(modelDidFinishLoad:);
        
        case kSAPModelLoadingStateDidFail:
            return @selector(modelDidFailLoad:);
        
        case kSAPModelLoadingStateDidCancel:
            return @selector(modelDidCancelLoad:);
            
        default:
            return [super selectorForState:state];
    }
}

@end

