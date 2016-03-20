//
//  SAPFacebookFriendsContext.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFacebookFriendsContext.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

static NSString * const kSAPFriendsGraphPath = @"me?fields=taggable_friends";
static NSString * const kSAPFriendsKey = @"taggable_friends";

@implementation SAPFacebookFriendsContext

#pragma mark Public

- (void)execute {
    FBSDKGraphRequest *request = [self graphRequest:kSAPFriendsGraphPath];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        id a = result;
        NSDictionary *friends = [result objectForKey:kSAPFriendsKey];
        
        @synchronized (self.model) {
            self.model.state = kSAPModelStateDidFinishLoading;
        }
    }];
}

@end
