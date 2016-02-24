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

#import "NSFileManager+SAPExtentions.h"

static NSUInteger const kSAPInitialUsersCount = 100;

static NSString * const kSAPObjectsKey      = @"objects";
static NSString * const kSAPPlistName       = @"users.plist";

@interface SAPUsers ()
@property (nonatomic, strong) NSString *archivePath;

- (void)fillWithUsers:(NSArray *)users;
- (NSMutableArray *)createUsersWithCount:(NSUInteger)count;
- (NSArray *)prepareUsers;
- (NSString *)path;
    
@end

@implementation SAPUsers

@dynamic archivePath;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        [self fillWithUsers:[self prepareUsers]];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)save{
    [NSKeyedArchiver archiveRootObject:self.objects toFile:[self path]];
}

- (NSArray *)load{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self path]];
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

- (NSMutableArray *)createUsersWithCount:(NSUInteger)count {
    NSMutableArray *result = [NSMutableArray new];
    for (NSUInteger index = 0; index < count; index++) {
        [result addObject:[SAPUser new]];
    }
    
    return result;
}

- (NSArray *)prepareUsers {
    NSArray *users = [self load];
    if(!users) {
        users = [self createUsersWithCount:kSAPInitialUsersCount];
    }
    
    return users;
}

- (NSString *)path {
    return [SAPPathForAppStateDirectory() stringByAppendingPathComponent:kSAPPlistName];
}

@end
