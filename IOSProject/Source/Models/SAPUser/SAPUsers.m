//
//  SAPData.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUsers.h"

#import "SAPUser.h"

static NSUInteger const kSAPInitialUsersCount = 100;

@implementation SAPUsers

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
#pragma mark Private

- (void)fillWithUsers {
    for (NSUInteger index = 0; index < kSAPInitialUsersCount; index++) {
        [self addObject:[SAPUser new]];
    }
}

@end
