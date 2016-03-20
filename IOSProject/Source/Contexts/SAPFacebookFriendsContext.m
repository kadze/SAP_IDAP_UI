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

static NSString * const kSAPFriendsGraphPath = @"me?fields=taggable_friends";
//static NSString * const kSAPFriendsGraphPath = @"me?fields=taggable_friends{first_name, last_name}";
static NSString * const kSAPFriendsKey = @"taggable_friends";
static NSString * const kSAPFriendsDataKey = @"data";
static NSString * const kSAPNameKey = @"name";
static NSString * const kSAPUrlKey = @"url";
static NSString * const kSAPPictureKey = @"picture";

@implementation SAPFacebookFriendsContext

#pragma mark Public

- (void)execute {
    FBSDKGraphRequest *request = [self graphRequest:kSAPFriendsGraphPath];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        SAPFacebookUser *model = self.model;
        SAPUsers *modelFriends = model.friends;
        
        NSArray *friends = [[result objectForKey:kSAPFriendsKey] objectForKey:kSAPFriendsDataKey];
        for (NSUInteger counter = 0 ; counter < friends.count; counter++) {
            SAPFacebookUser *user = [SAPFacebookUser new];
            user.firstName = [friends[counter] objectForKey:kSAPNameKey];
            user.imageURL = [[[friends[counter] objectForKey:kSAPPictureKey] objectForKey:kSAPFriendsDataKey] objectForKey:kSAPUrlKey];

            [modelFriends addObject:user];
        }
        @synchronized (model) {
            self.model.state = kSAPModelStateDidFinishLoading;
        }
    }];
}

@end
