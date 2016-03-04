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
#import "SAPAppDelegate.h"

#import "NSFileManager+SAPExtensions.h"
#import "NSObject+SAPExtensions.h"

static NSUInteger const kSAPInitialUsersCount = 100;

static NSString * const kSAPObjectsKey      = @"objects";
static NSString * const kSAPPlistName       = @"users.plist";


@interface SAPUsers ()
@property (nonatomic, assign) NSString *path;

- (void)fillWithUsers:(NSArray *)users;
- (NSArray *)loadUsers;
- (void)observeAppDelegate:(BOOL)enable;

@end

@implementation SAPUsers

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        [self observeAppDelegate:YES];
    }
    
    return self;
}

- (void)dealloc {
    [self observeAppDelegate:NO];
}

#pragma mark -
#pragma mark Accessors

- (NSString *)path {
    return [[NSFileManager appStatePath] stringByAppendingPathComponent:kSAPPlistName];
}

#pragma mark -
#pragma mark Public

- (void)save {
    [[NSFileManager defaultManager] createDirectoryAtPath:[NSFileManager appStatePath]
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:nil];
    [NSKeyedArchiver archiveRootObject:self.objects toFile:self.path];
}

- (void)performBackgroundLoading {
    sleep(3);
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

    if (!objects) {
        objects = [SAPUser objectsWithCount:kSAPInitialUsersCount];
    }
    
    return objects;
}

- (void)observeAppDelegate:(BOOL)enable {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    SAPAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (enable) {
        [center addObserver:self
                   selector:@selector(save)
                       name:kSAPAppNotificationName
                     object:appDelegate];
    } else {
        [center removeObserver:self
                          name:kSAPAppNotificationName
                        object:appDelegate];
    }
}

@end
