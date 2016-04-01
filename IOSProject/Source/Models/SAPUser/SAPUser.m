//
//  SAPUser.m
//  IOSProject
//
//  Created by SAP on 3/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUser.h"
#import <Foundation/NSObject.h>
#import <UIKit/UIApplication.h>

#import "SAPUsers.h"
#import "SAPImageModel.h"

#import "NSFileManager+SAPExtensions.h"

#import "SAPOwnershipMacro.h"

//properties names for NSCoding
static NSString * const kSAPUserIDKey        = @"userId";
static NSString * const kSAPFirstNameKey     = @"firstName";
static NSString * const kSAPLastNameKey      = @"lastName";
static NSString * const kSAPImageURLKey      = @"imageURL";
static NSString * const kSAPGenderKey        = @"gender";
static NSString * const kSAPLagreImageUrlKey = @"largeImageURL";
static NSString * const kSAPFriendsKey       = @"friends";

@interface SAPUser ()
@property (nonatomic, strong) SAPUsers  *friends;
@property (nonatomic, strong) id        applicationObserver;

- (void)startObserving;
- (void)stopObserving;

- (NSDictionary *)encodingDictionary;
- (void)decodeFriendsWithCoder:(NSCoder *)aDecoder;

@end

@implementation SAPUser

@dynamic imageModel;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.friends = [SAPUsers new];
        [self startObserving];
    }
    
    return self;
}

- (void)dealloc {
    [self stopObserving];
}

#pragma mark -
#pragma mark Accessors

- (SAPImageModel *)imageModel {
    return [SAPImageModel imageWithUrl:self.imageURL];
}

- (SAPImageModel *)largeImageModel {
    return [SAPImageModel imageWithUrl:self.largeImageURL];
}

#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    //single object properties
    NSDictionary *encodingDictionary = [self encodingDictionary];
    for (NSString *key in encodingDictionary.allKeys) {
        [aCoder encodeObject:[encodingDictionary objectForKey:key] forKey:key];
    }
    
    //friends IDs
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.friends.count];
    for (SAPUser *friend in self.friends.objects) {
        [array addObject:friend.userId];
    };
    
    [aCoder encodeObject:array forKey:kSAPFriendsKey];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init]; //mutable observers collection initialization
    
    //single object properties
    for (NSString *key in [[self encodingDictionary] allKeys]) {
        [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
    }
    
    [self decodeFriendsWithCoder:aDecoder];
    
    return self;
}

#pragma mark -
#pragma mark SAPCacheableModel

- (NSString *)path {
    return [[NSFileManager appStatePath] stringByAppendingPathComponent:self.userId];
}

- (BOOL)cached {
    NSFileManager *manager = [NSFileManager defaultManager];
    
    return [manager fileExistsAtPath:self.path];
}

- (void)save {
    if (!self.userId || self.userId.length == 0) {
        return;
    }
    
    [[NSFileManager defaultManager] createDirectoryAtPath:[NSFileManager appStatePath]
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:nil];
    [NSKeyedArchiver archiveRootObject:self toFile:self.path];
}


#pragma mark -
#pragma mark Private

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
                                               }
                                ];
}

- (void)stopObserving {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self.applicationObserver
                      name:UIApplicationDidEnterBackgroundNotification
                    object:nil];
}

- (NSDictionary *)encodingDictionary {
    NSNull *null = [NSNull null];
    return @{kSAPUserIDKey        : ((!self.userId) ? null : self.userId),
             kSAPFirstNameKey     : ((!self.firstName) ? null : self.firstName),
             kSAPLastNameKey      : ((!self.lastName) ? null : self.lastName),
             kSAPImageURLKey      : ((!self.imageURL) ? null : self.imageURL),
             kSAPLagreImageUrlKey : ((!self.largeImageURL) ? null : self.largeImageURL),
             kSAPGenderKey        : ((!self.gender) ? null : self.gender)};
}

- (void)decodeFriendsWithCoder:(NSCoder *)aDecoder {
    NSArray *friendsIDs = [aDecoder decodeObjectForKey:kSAPFriendsKey];
    
    SAPUsers *friends = [SAPUsers new];
    for (NSString *userId in friendsIDs) {
        SAPUser *friend = [SAPUser new];
        friend.userId = userId;
        if (friend.cached) {
            friend = [NSKeyedUnarchiver unarchiveObjectWithFile:friend.path];
        }
        
        [friends addObject:friend];
    }
    
    self.friends = friends;
}

@end
