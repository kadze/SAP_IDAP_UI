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
@property (nonatomic, strong) NSObject *applicationObserver;

- (void)fillWithUsers:(NSArray *)users;
- (NSArray *)loadUsers;
- (void)startObserving;
- (void)stopObserving;

@end

@implementation SAPUsers

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        [self startObserving];
    }
    
    return self;
}

- (void)dealloc {
    [self stopObserving];
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

- (void)startObserving {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    SAPWeakify(self);
    self.applicationObserver = [center addObserverForName:UIApplicationDidEnterBackgroundNotification
                                                   object:nil
                                                    queue:queue
                                               usingBlock:^(NSNotification * note) {
                                                   SAPStrongify(self);
                                                   [self save];
                                               }];
}

- (void)stopObserving {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self.applicationObserver
                      name:UIApplicationDidEnterBackgroundNotification
                    object:nil];
}

@end
