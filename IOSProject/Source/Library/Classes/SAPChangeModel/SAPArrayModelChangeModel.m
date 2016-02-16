//
//  SAPArrayModelChangeModel.m
//  IOSProject
//
//  Created by S A P on 2/12/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPArrayModelChangeModel.h"

@interface SAPArrayModelChangeModel ()
@property (nonatomic, assign) SAPChangeType changeType;
@property (nonatomic, strong) NSArray       *indexes;
@end

@implementation SAPArrayModelChangeModel

#pragma mark -
#pragma mark Class methods

+ (SAPArrayModelChangeModel *)modelWithChangeType:(SAPChangeType)changeType
                                          indexes:(NSArray *)indexes
{
    SAPArrayModelChangeModel *result = [self new];
    result.indexes = indexes;
    result.changeType = changeType;
    
    return result;
}

@end
