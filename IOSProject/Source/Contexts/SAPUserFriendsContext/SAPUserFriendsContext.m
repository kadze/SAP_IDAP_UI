//
//  SAPUserFriendsContext.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUserFriendsContext.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "SAPUser.h"
#import "SAPUsers.h"

#import "SAPGraphStringConstants.h"

@implementation SAPUserFriendsContext

#pragma mark -
#pragma mark Accessors

- (void)setUser:(SAPUser *)user {
    if (_user != user) {
        _user = user;
        self.model = user.friends;
    }
}

#pragma mark -
#pragma mark Public

- (NSString *)graphRequestPath {
    return self.user.userId;
}

- (NSDictionary *)graphRequestParameters {
    NSString *fieldsParameter = [NSString stringWithFormat:@"%@{%@,%@,%@{%@}}",
                                 kSAPFriendsKey,
                                 kSAPFirstNameKey,
                                 kSAPLastNameKey,
                                 kSAPPictureKey,
                                 kSAPUrlKey];
    
    return @{kSAPFieldsKey : fieldsParameter};
}

- (void)fillModelWithResult:(NSDictionary *)result {
    SAPUsers *friends = self.model;
    NSArray *friendElements = result[kSAPFriendsKey][kSAPDataKey];
    [friends performBlockWithoutNotification:^{
        for (id friendElement in friendElements) {
            SAPUser *user = [SAPUser new];
            user.userId = friendElement[kSAPIDKey];
            user.firstName = friendElement[kSAPFirstNameKey];
            user.lastName = friendElement[kSAPLastNameKey];
            NSString *urlString = friendElement[kSAPPictureKey][kSAPDataKey][kSAPUrlKey];
            user.imageURL = [NSURL URLWithString:urlString];
            
            [friends addObject:user];
        }
    }];
}

@end
