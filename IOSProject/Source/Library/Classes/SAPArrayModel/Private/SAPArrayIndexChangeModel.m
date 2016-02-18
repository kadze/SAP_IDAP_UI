//
//  SAPArrayIndexChangeModel.m
//  IOSProject
//
//  Created by S A P on 2/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPArrayIndexChangeModel.h"

@interface SAPArrayIndexChangeModel ()
@property (nonatomic, assign) NSUInteger changeType;
@property (nonatomic, assign) NSUInteger index;

@end

@implementation SAPArrayIndexChangeModel

@dynamic changeType;
@dynamic index;

#pragma mark -
#pragma mark Class methods

+ (instancetype)modelWithChangeType:(NSUInteger)changeType
                  index:(NSUInteger)index
{
   return [[self alloc] initWithChangeType:changeType index:index];
}

#pragma mark-
#pragma mark Initializations and Deallocations

- (instancetype)initWithChangeType:(NSUInteger)changeType index:(NSUInteger)index {
    self = [super initWithChangeType:changeType];
    if (self) {
        self.index = changeType;
    }
    
    return self;
}

@end
