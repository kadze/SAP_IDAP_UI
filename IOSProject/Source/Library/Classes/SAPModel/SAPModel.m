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

@end

