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
    kSAPModelStateDidFinish,
    kSAPModelStateDidFail,
    
    kSAPModelStateEnd,
    kSAPWorkerStateCount = kSAPModelStateEnd - kSAPModelStateStart - 1
};

@interface SAPModel : SAPObservableObject

@end
