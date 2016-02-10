//
//  SAPData.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUsers.h"

#import "SAPUser.h"

static NSUInteger const kSAPArraySize = 100;

@interface SAPUsers ()
@property (nonatomic, strong) NSMutableArray *mutableUsers;

@end

@implementation SAPUsers

@dynamic users;
@dynamic count;

#pragma mark - 
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        [self fillWithUsers];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)users {
    return [self.mutableUsers copy];
}

- (NSUInteger)count {
    return self.mutableUsers.count;
}

#pragma mark -
#pragma mark Public

- (SAPUser *)objectAtIndex:(NSUInteger) index {
    return [self.mutableUsers objectAtIndex:index];
}

- (SAPUser *)objectAtIndexedSubscript:(NSUInteger) index {
    return [self objectAtIndex:index];
}

#pragma mark -
#pragma mark Private

- (void)fillWithUsers {
    NSMutableArray *mutableUsers = [NSMutableArray arrayWithCapacity:kSAPArraySize];
    for (NSUInteger index = 0; index < kSAPArraySize; index++) {
        [mutableUsers addObject:[SAPUser new]];
    }
    
    self.mutableUsers = mutableUsers;
}

@end
