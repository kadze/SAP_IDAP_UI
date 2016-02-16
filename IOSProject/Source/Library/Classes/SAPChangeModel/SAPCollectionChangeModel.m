//
//  SAPCollectionChangeModel.m
//  IOSProject
//
//  Created by S A P on 2/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPCollectionChangeModel.h"

#import "SAPArrayIndexChangeModel.h"
#import "SAPArrayDoubleIndexChangeModel.h"

@interface SAPCollectionChangeModel ()
@property (nonatomic, assign) SAPChangeType changeType;

@end

@implementation SAPCollectionChangeModel

#pragma mark-
#pragma mark Initializations and Deallocations

- (instancetype)initWithChangeType:(SAPChangeType)changeType {
    self = [super init];
    if (self) {
        self.changeType = changeType;
    }
    
    return self;
}

#pragma mark-
#pragma mark Class methods

+ (instancetype)modelWithChangeType:(SAPChangeType)changeType {
    return [[self alloc] initWithChangeType:changeType];
}

@end
