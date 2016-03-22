//
//  SAPFacebookFriendsContext.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFacebookFriendsContext.h"

#import "SAPFacebookUser.h"
#import "SAPUsers.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

static NSString * const kSAPDataKey = @"data";
static NSString * const kSAPFieldsKey = @"fields";

static NSString * const kSAPUserGraphPath = @"me";

static NSString * const kSAPFriendsKey = @"friends";

static NSString * const kSAPFirstNameKey = @"first_name";
static NSString * const kSAPLastNameKey = @"last_name";
static NSString * const kSAPPictureKey = @"picture";
static NSString * const kSAPUrlKey = @"url";

@implementation SAPFacebookFriendsContext

#pragma mark Public

- (void)execute {
    NSString *fieldsParameter = [NSString stringWithFormat:@"%@{%@,%@,%@{%@}}",
                                 kSAPFriendsKey,
                                 kSAPFirstNameKey,
                                 kSAPLastNameKey,
                                 kSAPPictureKey,
                                 kSAPUrlKey];
    NSDictionary *parameters = @{kSAPFieldsKey : fieldsParameter};
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:kSAPUserGraphPath
                                                                   parameters:parameters];
    SAPFacebookUser *model = (SAPFacebookUser *)self.model;
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, NSDictionary *result, NSError *error) {
        SAPUsers *modelFriends = model.friends;
        NSArray *friends = [[result objectForKey:kSAPFriendsKey] objectForKey:kSAPDataKey];
        for (id friend in friends) {
            SAPFacebookUser *user = [SAPFacebookUser new];
            user.firstName = friend[kSAPFirstNameKey];
            user.lastName = friend[kSAPLastNameKey];
            NSString *urlString = friend[kSAPPictureKey][kSAPDataKey][kSAPUrlKey];
            user.imageURL = [NSURL URLWithString:urlString];

            [modelFriends addObject:user];
        }
        
        @synchronized (model) {
            model.state = kSAPModelStateDidFinishLoading;
        }
    }];
}

@end
