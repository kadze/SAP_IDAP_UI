//
//  SAPFacebookUser.m
//  IOSProject
//
//  Created by SAP on 3/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFacebookUser.h"

#import "SAPUsers.h"
#import "SAPImageModel.h"

static NSString * const kSAPFirstNameKey = @"firstName";
static NSString * const kSAPLastNameKey  = @"lastName";
static NSString * const kSAPImageURLKey  = @"imageURL";
static NSString * const kSAPFriendsKey   = @"friends";

@implementation SAPFacebookUser

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

#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSDictionary *encodingDictionary = @{kSAPFirstNameKey : self.firstName,
                                         kSAPLastNameKey : self.lastName,
                                         kSAPImageURLKey : self.imageURL,
                                         kSAPFriendsKey : self.friends};
    for (NSString *key in encodingDictionary.allKeys) {
        [aCoder encodeObject:[encodingDictionary objectForKey:key] forKey:key];
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init]; //mutable observers collection initialization
    
    self.firstName = [aDecoder decodeObjectForKey:kSAPFirstNameKey];
    self.lastName = [aDecoder decodeObjectForKey:kSAPLastNameKey];
    self.imageURL = [aDecoder decodeObjectForKey:kSAPImageURLKey];
    self.friends = [aDecoder decodeObjectForKey:kSAPFriendsKey];
    
    return self;
}

@end
