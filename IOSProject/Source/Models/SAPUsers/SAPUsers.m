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
#import "SAPAppDelegate.h"
#import "SAPUserFriendsContext.h"

#import "NSObject+SAPExtensions.h"

#import "SAPOwnershipMacro.h"

#import "SAPDispatch.h"

static NSString * const kSAPObjectsKey      = @"objects";
static NSString * const kSAPPlistName       = @"users.plist";

@interface SAPUsers ()

@property (nonatomic, strong) SAPUserFriendsContext *context;

- (void)fillWithUsers:(NSArray *)users;
- (NSArray *)loadUsers;

@end

@implementation SAPUsers

#pragma mark -
#pragma mark Public

- (void)performBackgroundLoading {
//    sleep(3);
    [self fillWithUsers:[self loadUsers]];
    @synchronized(self) {
        self.state = kSAPModelStateDidFinishLoading;
    }
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
    NSArray *objects = nil;
    if (self.cached) {
        objects = [NSKeyedUnarchiver unarchiveObjectWithFile:self.path];
    }
    
    return objects;
}


@end
