//
//  SAPArrayDoubleIndexChangeModel.m
//  IOSProject
//
//  Created by S A P on 2/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPArrayDoubleIndexChangeModel.h"

@interface SAPArrayIndexChangeModel ()
@property (nonatomic, assign) NSUInteger changeType;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, assign) NSUInteger toIndex;

@end

@implementation SAPArrayDoubleIndexChangeModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)modelWithChangeType:(NSUInteger)changeType
                    index:(NSUInteger)fromIndex
                  toIndex:(NSUInteger)toIndex
{    
    return [[self alloc] initWithChangeType:changeType index:fromIndex toIndex:toIndex];
}

#pragma mark-
#pragma mark Initializations and Deallocations

- (instancetype)initWithChangeType:(NSUInteger)changeType
                             index:(NSUInteger)index
                           toIndex:(NSUInteger)toIndex
{
    self = [super initWithChangeType:changeType index:index];
    if (self) {
        self.toIndex = toIndex;
    }
    
    return self;
}

@end
