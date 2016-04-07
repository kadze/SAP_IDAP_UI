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
#import "SAPUserFriendsContext.h"

#import "SAPOwnershipMacro.h"

@interface SAPUsers ()
@property (nonatomic, strong) SAPUserFriendsContext *context;

- (void)fillWithUsers:(NSArray *)users;
- (NSArray *)loadUsers;

@end

@implementation SAPUsers

#pragma mark -
#pragma mark Public

- (void)performBackgroundLoading {
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
    if (self.cached) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:self.path];
    }
    
    return nil;
}

@end
