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
static NSString * const kSAPAppStateDirectoryName = @"appState";

@interface SAPUsers ()
@property (nonatomic, assign) NSString *path;

- (void)fillWithUsers:(NSArray *)users;
- (NSArray *)loadUsers;
- (NSMutableArray *)createUsersWithCount:(NSUInteger)count;
- (void)cleanupAfterProcessing;
- (NSString *)appStatePath;

@end

@implementation SAPUsers

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.state = kSAPModelStateUnloaded;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)path {
    return [[self appStatePath] stringByAppendingPathComponent:kSAPPlistName];
}

#pragma mark -
#pragma mark Public

- (void)save {
    SAPProvidePathExistence([self appStatePath]);
    [NSKeyedArchiver archiveRootObject:self.objects toFile:self.path];
}

- (void)performBackgroundLoading {
    SAPDispatchAsyncOnDefaultQueue(^{
        [self fillWithUsers:[self loadUsers]];
        sleep(5);
        
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

- (NSArray *)loadUsers {
    NSArray *objects = [NSKeyedUnarchiver unarchiveObjectWithFile:self.path];
    if (!objects) {
        objects = [self createUsersWithCount:kSAPInitialUsersCount];
    }
    
    return objects;
}

- (NSMutableArray *)createUsersWithCount:(NSUInteger)count {
    NSMutableArray *result = [NSMutableArray new];
    for (NSUInteger index = 0; index < count; index++) {
        [result addObject:[SAPUser new]];
    }
    
    return result;
}

- (void)cleanupAfterProcessing {
    @synchronized(self) {
        self.state = kSAPModelStateDidFinishLoading;
    }
}

- (NSString *)appStatePath {
    return [SAPlibraryPath() stringByAppendingPathComponent:kSAPAppStateDirectoryName];
}

@end
