//
//  SAPArrayIndexChangeModel.m
//  IOSProject
//
//  Created by S A P on 2/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPArrayIndexChangeModel.h"

@interface SAPArrayIndexChangeModel ()

@property (nonatomic, assign) SAPChangeType changeType;
@property (nonatomic, assign) NSUInteger    index;

@end

@implementation SAPArrayIndexChangeModel
@dynamic changeType;
@dynamic index;

#pragma mark-
#pragma mark Initializations and Deallocations

+ (instancetype)modelWithChangeType:(SAPChangeType)changeType
                  index:(NSUInteger)index
{
    SAPArrayIndexChangeModel *result = [super modelWithChangeType:changeType];
    result.index = index;
    
    return result;
}
@end
