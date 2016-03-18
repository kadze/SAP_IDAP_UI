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

static NSString * const kSAPPermission = @"public_profile";

@interface SAPFacebookLoginContext ()

@end

@implementation SAPFacebookLoginContext

- (void)execute {
    [self loadModel];
}

- (void)cancel {
    
}

#pragma mark -
#pragma mark Private

- (void)loadModel {
    @synchronized(self) {
        SAPModel *user = self.model;
        NSUInteger state = user.state;
        if (kSAPModelStateDidFinishLoading == state || kSAPModelStateWillLoad == state) {
            [user notifyObserversWithSelector:[user selectorForState:state]];
            
            return;
        }
        
        user.state = kSAPModelStateWillLoad;
        
        SAPDispatchAsyncOnDefaultQueue(^{
            [self performBackgroundLoading];
        });
    }
}

- (void)performBackgroundLoading {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    SAPModel *user = self.model;
    [login logInWithReadPermissions: @[kSAPPermission]
                 fromViewController:self.controller
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                if (error) {
                                    NSLog(@"Process error");
                                } else if (result.isCancelled) {
                                    NSLog(@"Cancelled");
                                } else {
                                    user.state = kSAPModelStateDidFinishLoading;
                                }
                            }];
}



@end
