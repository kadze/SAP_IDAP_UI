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

@interface SAPFacebookLoginContext ()

@end

@implementation SAPFacebookLoginContext

#pragma mark -
#pragma mark Public

- (void)execute {
    [self loadModel];
}

- (void)cancel {
    
}

#pragma mark -
#pragma mark Private

- (void)loadModel {
//    @synchronized(self) {
//        SAPModel *user = self.model;
//        NSUInteger state = user.state;
//        if (kSAPModelStateDidFinishLoading == state || kSAPModelStateWillLoad == state) {
//            [user notifyObserversWithSelector:[user selectorForState:state]];
//            
//            return;
//        }
//        
//        user.state = kSAPModelStateWillLoad;
//        
//        SAPDispatchAsyncOnDefaultQueue(^{
            [self performBackgroundLoading]; ////rename!!!!!!!!!
            /*This application is modifying the autolayout engine from a background thread, which can lead to engine corruption and weird crashes.  This will cause an exception in a future release.
            */
//        });
//    }
}

- (void)performBackgroundLoading {
    SAPModel *user = self.model;
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    SAPLoginViewController *controller = self.controller;
    [login logInWithReadPermissions: @[kSAPPublicPofilePermission, kSAPUserEmailPermission]
                 fromViewController:controller
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                if (error) {
                                    NSLog(@"Process error");
                                } else if (result.isCancelled) {
                                    NSLog(@"Cancelled");
                                    @synchronized (user) {
                                        user.state = kSAPModelStateDidFailLoading;
                                    }
                                } else {
//                                    @synchronized (user) {
//                                        user.state = kSAPModelStateDidFinishLoading;
//                                    }
                                    [controller loadUserFromWeb];
                                }
                            }];
}

@end
