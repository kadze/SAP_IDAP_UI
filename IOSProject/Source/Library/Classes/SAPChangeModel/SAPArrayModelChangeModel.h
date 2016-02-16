//
//  SAPArrayModelChangeModel.h
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
    kSAPChangeTypeObjectReplaced,
    kSAPChangeTypeObjectExchanged
};


@interface SAPArrayModelChangeModel : NSObject
@property (nonatomic, readonly) SAPChangeType   changeType;
@property (nonatomic, readonly) NSArray         *indexes;

+ (SAPArrayModelChangeModel *)modelWithChangeType:(SAPChangeType)changeType indexes:(NSArray *)indexes;

@end
