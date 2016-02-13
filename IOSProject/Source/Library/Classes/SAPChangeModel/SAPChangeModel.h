//
//  SAPChangeModel.h
//  IOSProject
//
//  Created by S A P on 2/12/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, SAPChangeType) {
    kSAPChangeTypeNoChanges,
    kSAPChangeTypeObjectAdded,
    kSAPChangeTypeObjectInserted,
    kSAPChangeTypeObjectRemoved,
    kSAPChangeTypeObjectRemovedAtIndex,
    kSAPChangeTypeObjectReplaced,
    kSAPChangeTypeObjectExchanged
};


@interface SAPChangeModel : NSObject
@property (nonatomic, readonly) SAPChangeType   changeType;
@property (nonatomic, readonly) NSArray         *indexes;

+ (SAPChangeModel *)objectWithChangeType:(SAPChangeType) changeType indexes:(NSArray *)indexes;

@end
