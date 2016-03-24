//
//  SAPUser.m
//  IOSProject
//
//  Created by SAP on 3/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUser.h"
#import <Foundation/NSObject.h>
#import "SAPUsers.h"
#import "SAPImageModel.h"

//properties names for NSCoding
static NSString * const kSAPUserIDKey        = @"userID";
static NSString * const kSAPFirstNameKey     = @"firstName";
static NSString * const kSAPLastNameKey      = @"lastName";
static NSString * const kSAPImageURLKey      = @"imageURL";
static NSString * const kSAPGenderKey        = @"gender";
static NSString * const kSAPLagreImageUrlKey = @"largeImageURL";

@interface SAPUser ()

- (NSDictionary *)encodingDictionary;

@end

@implementation SAPUser

@dynamic imageModel;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.friends = [SAPUsers new];
    }
    
    return self;
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
    NSDictionary *encodingDictionary = [self encodingDictionary];
    for (NSString *key in encodingDictionary.allKeys) {
        [aCoder encodeObject:[encodingDictionary objectForKey:key] forKey:key];
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init]; //mutable observers collection initialization
    for (NSString *key in [[self encodingDictionary] allKeys]) {
        [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
    }
    
    return self;
}

#pragma mark -
#pragma mark Private

- (NSDictionary *)encodingDictionary {
    NSNull *null = [NSNull null];
    return @{kSAPUserIDKey        : ((!self.userId) ? null : self.userId),
             kSAPFirstNameKey     : ((!self.firstName) ? null : self.firstName),
             kSAPLastNameKey      : ((!self.lastName) ? null : self.lastName),
             kSAPImageURLKey      : ((!self.imageURL) ? null : self.imageURL),
             kSAPLagreImageUrlKey : ((!self.largeImageURL) ? null : self.largeImageURL),
             kSAPGenderKey        : ((!self.gender) ? null : self.gender)};
}

@end
