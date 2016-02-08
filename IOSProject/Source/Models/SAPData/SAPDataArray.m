//
//  SAPData.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPDataArray.h"
#import "SAPDataElement.h"

@interface SAPDataArray ()
@property (nonatomic, strong) NSMutableArray *mutableElements;

@end

@implementation SAPDataArray

#pragma mark - 
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.mutableElements = [[NSMutableArray alloc] initWithCapacity:kSAPArraySize];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)dataElements {
    return [self.mutableElements copy];
}

- (NSUInteger)count {
    return self.mutableElements.count;
}

#pragma mark -
#pragma mark Public

- (void)fillWithDataElements {
    NSMutableArray *mutableElements = self.mutableElements;
    for (NSUInteger index = 0; index < kSAPArraySize; index++) {
        [mutableElements addObject:[SAPDataElement new]];
    }
}

- (SAPDataElement *)objectAtIndex:(NSUInteger) index {
    return [self.mutableElements objectAtIndex:index];
}

- (SAPDataElement *)objectAtIndexedSubscript:(NSUInteger) index {
    return [self objectAtIndex:index];
}

@end
