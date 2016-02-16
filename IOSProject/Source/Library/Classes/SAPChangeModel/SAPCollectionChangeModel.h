//
//  SAPCollectionChangeModel.h
//  IOSProject
//
//  Created by S A P on 2/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, SAPChangeType) {
    kSAPChangeTypeNoChanges,
    kSAPChangeTypeObjectAdded,
    kSAPChangeTypeObjectInserted,
    kSAPChangeTypeObjectRemoved,
    kSAPChangeTypeObjectReplaced,
    kSAPChangeTypeObjectExchanged
};

@interface SAPCollectionChangeModel : NSObject
@property (nonatomic, readonly) SAPChangeType changeType;

+ (id)modelWithChangeType:(SAPChangeType)changeType;

@end
