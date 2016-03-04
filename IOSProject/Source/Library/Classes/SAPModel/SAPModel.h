//
//  SAPModel.h
//  IOSProject
//
//  Created by S A P on 2/23/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPObservableObject.h"
#import "SAPModelObserver.h"

typedef NS_ENUM (NSUInteger, SAPModelState) {
    kSAPModelStateStart,
    
    kSAPModelStateUnloaded,
    kSAPModelStateWillLoad,
    kSAPModelStateDidFinishLoading,
    kSAPModelStateDidFailLoading,
    
    kSAPModelStateEnd,
    kSAPWorkerStateCount = kSAPModelStateEnd - kSAPModelStateStart - 1
};

@interface SAPModel : SAPObservableObject
@property (nonatomic, readonly) BOOL cached;
@property (nonatomic, readonly) NSString *path;

- (void)load;

//this method should be overriden in subclasses
- (void)performBackgroundLoading;

@end
