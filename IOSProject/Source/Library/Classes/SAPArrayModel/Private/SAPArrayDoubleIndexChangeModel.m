//
//  SAPArrayDoubleIndexChangeModel.m
//  IOSProject
//
//  Created by S A P on 2/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPArrayDoubleIndexChangeModel.h"

@interface SAPArrayIndexChangeModel ()

@property (nonatomic, assign) NSUInteger    changeType;
@property (nonatomic, assign) NSUInteger    toIndex;

@end

@implementation SAPArrayDoubleIndexChangeModel

+ (instancetype)modelWithChangeType:(NSUInteger)changeType
                    index:(NSUInteger)fromIndex
                  toIndex:(NSUInteger)toIndex
{
    SAPArrayDoubleIndexChangeModel *result = [super modelWithChangeType:changeType index:toIndex];
    result.toIndex = toIndex;
    
    return result;
}


@end
