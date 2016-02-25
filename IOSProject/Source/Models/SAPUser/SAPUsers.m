//
//  SAPData.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUsers.h"

#import <Foundation/NSFileManager.h>

#import "SAPUser.h"
#import "SAPOwnershipMacro.h"
#import "SAPDispatch.h"

#import "NSFileManager+SAPExtensions.h"

static NSUInteger const kSAPInitialUsersCount = 100;

static NSString * const kSAPObjectsKey      = @"objects";
static NSString * const kSAPPlistName       = @"users.plist";

@interface SAPUsers ()

- (void)fillWithUsers:(NSArray *)users;
- (void)fillWithNewOrLoadedUsers;
- (NSMutableArray *)createUsersWithCount:(NSUInteger)count;
- (NSString *)path;
- (void)cleanupAfterProcessing;

@end

@implementation SAPUsers

#pragma mark -
#pragma mark Public

- (void)save {
    SAPProvidePathExistence(SAPPathForAppStateDirectory());
    [NSKeyedArchiver archiveRootObject:self.objects toFile:[self path]];
}

- (void)load {
    
    SAPDispatchAsyncOnDefaultQueue(^{
        [self fillWithNewOrLoadedUsers];
        SAPDispatchAsyncOnMainQueue(^{
            [self cleanupAfterProcessing];
        });
    });
    
    
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

- (void)fillWithNewOrLoadedUsers {
    NSArray *objects = [NSKeyedUnarchiver unarchiveObjectWithFile:[self path]];
    if (objects) {
        [self fillWithUsers:objects];
    } else {
        [self fillWithUsers:[self createUsersWithCount:kSAPInitialUsersCount]];
    }
    sleep(2); //pretend to load slowly
}

- (NSMutableArray *)createUsersWithCount:(NSUInteger)count {
    NSMutableArray *result = [NSMutableArray new];
    for (NSUInteger index = 0; index < count; index++) {
        [result addObject:[SAPUser new]];
    }
    
    return result;
}

- (NSString *)path {
    return [SAPPathForAppStateDirectory() stringByAppendingPathComponent:kSAPPlistName];
}

- (void)cleanupAfterProcessing {
    @synchronized(self) {
        self.state = kSAPModelLoadingStateDidFinish;
    }
}

@end
