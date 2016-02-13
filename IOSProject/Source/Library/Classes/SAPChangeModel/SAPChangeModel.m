//
//  SAPChangeModel.m
//  IOSProject
//
//  Created by S A P on 2/12/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPChangeModel.h"

@interface SAPChangeModel ()
@property (nonatomic, assign) SAPChangeType changeType;
@property (nonatomic, strong) NSArray       *indexes;
@end

@implementation SAPChangeModel

#pragma mark -
#pragma mark Class methods

+ (SAPChangeModel *)modelWithChangeType:(SAPChangeType) changeType indexes:(NSArray *)indexes {
    SAPChangeModel *result = [self new];
    result.indexes = indexes;
    result.changeType = changeType;
    
    return result;
}

@end
