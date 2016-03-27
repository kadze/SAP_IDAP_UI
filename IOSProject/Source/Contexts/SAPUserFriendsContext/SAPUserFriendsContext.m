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
#pragma mark Public

- (NSString *)graphRequestPath {
    return kSAPUserGraphPath;
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
    SAPUsers *users = self.model;
    NSArray *friends = result[kSAPFriendsKey][kSAPDataKey];
    for (id friend in friends) {
        SAPUser *user = [SAPUser new];
        user.userId = friend[kSAPIDKey];
        user.firstName = friend[kSAPFirstNameKey];
        user.lastName = friend[kSAPLastNameKey];
        NSString *urlString = friend[kSAPPictureKey][kSAPDataKey][kSAPUrlKey];
        user.imageURL = [NSURL URLWithString:urlString];
        
        [users addObject:user];
    }
}

@end
