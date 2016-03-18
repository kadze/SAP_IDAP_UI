//
//  SAPFacebookUsers.m
//  IOSProject
//
//  Created by SAP on 3/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFacebookUsers.h"

#import "SAPOwnershipMacro.h"
#import "SAPAppDelegate.h"

#import "NSFileManager+SAPExtensions.h"

static NSString * const kSAPObjectsKey      = @"objects";
static NSString * const kSAPPlistName       = @"fbusers.plist";

@interface SAPFacebookUsers ()
@property (nonatomic, strong) id applicationObserver;

- (void)fillWithUsers:(NSArray *)users;
- (NSArray *)loadUsers;
- (void)startObserving;
- (void)stopObserving;

@end

@implementation SAPFacebookUsers
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
#pragma mark SAPCacheableModel

- (NSString *)path {
    return [[NSFileManager appStatePath] stringByAppendingPathComponent:kSAPPlistName];
}

- (BOOL)cached {
    NSFileManager *manager = [NSFileManager defaultManager];
    
    return [manager fileExistsAtPath:self.path];
}

- (void)save {
    [[NSFileManager defaultManager] createDirectoryAtPath:[NSFileManager appStatePath]
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:nil];
    [NSKeyedArchiver archiveRootObject:self.objects toFile:self.path];
}

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
        for (SAPFacebookUsers *user in users) {
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
