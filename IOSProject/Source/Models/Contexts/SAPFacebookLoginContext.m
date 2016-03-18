//
//  SAPFacebookLoginContext.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFacebookLoginContext.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "SAPLoginViewController.h"
#import "SAPModel.h"

static NSString * const kSAPPermission = @"public_profile";

@implementation SAPFacebookLoginContext

- (void)execute {
    
}

- (void)executeWithViewController:(SAPLoginViewController *)controller {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    [login logInWithReadPermissions: @[kSAPPermission]
                 fromViewController:controller
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                if (error) {
                                    NSLog(@"Process error");
                                } else if (result.isCancelled) {
                                    NSLog(@"Cancelled");
                                } else {
                                    self.model.state = kSAPModelStateDidFinishLoading;
                                }
                            }];
}

- (void)cancel {
    
}


@end
