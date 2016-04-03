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

#import "SAPNilVsNSNullSubstituteMacro.h"

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

- (NSDictionary *)cachedResult {
    NSDictionary *result = nil;
    SAPUser *user = self.user;
    if (user.cached) {
        SAPUser *cachedUser = [NSKeyedUnarchiver unarchiveObjectWithFile:user.path];
        
        NSMutableArray *friendElements = [NSMutableArray new];
        
        for (SAPUser *friend in cachedUser.friends.objects) {
            NSDictionary *friendElement = @{kSAPIDKey : friend.userId,
                                            kSAPFirstNameKey : friend.firstName,
                                            kSAPLastNameKey : friend.lastName,
                                            kSAPPictureKey : @{
                                                    kSAPDataKey : @{
                                                            kSAPUrlKey : friend.imageURL.absoluteString
                                                            }
                                                    }
                                            };
            [friendElements addObject:friendElement];
        }
        result = @{kSAPFriendsKey : @{kSAPDataKey : [friendElements copy]}};
    }
    
    return result;
}

- (void)fillModelWithResult:(NSDictionary *)result {
    SAPUsers *friends = self.model;
    NSArray *friendElements = result[kSAPFriendsKey][kSAPDataKey];
    [friends performBlockWithoutNotification:^{
        for (id friendElement in friendElements) {
            SAPUser *user = [SAPUser new];
            user.userId         = SAPNilIfNSNull(friendElement[kSAPIDKey]);
            user.firstName      = SAPNilIfNSNull(friendElement[kSAPFirstNameKey]);
            user.lastName       = SAPNilIfNSNull(friendElement[kSAPLastNameKey]);
            NSString *urlString = SAPNilIfNSNull(friendElement[kSAPPictureKey][kSAPDataKey][kSAPUrlKey]);
            user.imageURL       = SAPNilIfNSNull([NSURL URLWithString:urlString]);
            
            [friends addObject:user];
        }
    }];
}

@end
