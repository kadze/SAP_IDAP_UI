//
//  SAPData.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUsers.h"

#import "SAPUser.h"
#import "SAPOwnershipMacro.h"

static NSUInteger const kSAPInitialUsersCount = 100;

static NSString * const kSAPObjectsKey = @"objects";

@implementation SAPUsers

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        [self fillWithUsers:[self createUsersWithCount:kSAPInitialUsersCount]];
    }
    
    return self;
}

#pragma mark -
#pragma mark Private

- (void)fillWithUsers:(NSArray *)users {
    SAPWeakify(self);
    [self performBlockWithoutNotification:^{
        SAPStrongify(self);
        for (SAPUser *user in users) {
            [self addObject:user];
        }
    }];
}

- (NSMutableArray *)createUsersWithCount:(NSUInteger)count{
    NSMutableArray *result = [NSMutableArray new];
    for (NSUInteger index = 0; index < count; index++) {
        [result addObject:[SAPUser new]];
    }
    
    return result;
}

#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.objects forKey:kSAPObjectsKey];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    [self fillWithUsers:[aDecoder decodeObjectForKey:kSAPObjectsKey]];
    
    return self;
}

@end
