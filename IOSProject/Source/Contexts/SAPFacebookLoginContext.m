//
//  SAPFacebookLoginContext.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFacebookLoginContext.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "SAPModel.h"
#import "SAPLoginViewController.h"

#import "SAPDispatch.h"

static NSString * const kSAPPublicPofilePermission = @"public_profile";
static NSString * const kSAPUserEmailPermission = @"user_friends";

@implementation SAPFacebookLoginContext

#pragma mark -
#pragma mark Public

- (void)execute {
    SAPModel *user = self.model;
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    SAPLoginViewController *controller = self.controller;
    [login logInWithReadPermissions: @[kSAPPublicPofilePermission, kSAPUserEmailPermission]
                 fromViewController:controller
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                if (error) {
                                    NSLog(@"Process error");
                                    [controller loadUserFromDisk];
                                } else if (result.isCancelled) {
                                    NSLog(@"Cancelled");
                                    @synchronized (user) {
                                        user.state = kSAPModelStateDidFailLoading;
                                    }
                                } else {
                                    [controller loadUserFromWeb];
                                }
                            }];
}

@end
