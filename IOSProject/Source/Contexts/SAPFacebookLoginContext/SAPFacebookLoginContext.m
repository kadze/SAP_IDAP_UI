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
#import "SAPUserContext.h"

#import "SAPOwnershipMacro.h"

#import "SAPDispatch.h"

static NSString * const kSAPPublicPofilePermission = @"public_profile";
static NSString * const kSAPUserFriendsPermission = @"user_friends";

@interface SAPFacebookLoginContext ()
@property (nonatomic, strong) SAPContext *userContext;

- (void)login;
- (void)loadUser;

@end

@implementation SAPFacebookLoginContext

#pragma mark -
#pragma mark Public

- (void)execute {
    SAPModel *user = self.model;
    
    NSUInteger state = user.state;
    if (kSAPModelStateDidFinishLoading == state || kSAPModelStateWillLoad == state) {
        [user notifyObserversWithSelector:[user selectorForState:state]];
        
        return;
    }
    
    SAPWeakify(self);
    SAPDispatchSyncOnMainQueue(^{
        SAPStrongify(self);
        [self login];
    });
    
}

#pragma mark -
#pragma mark Private

- (void)login {
    SAPModel *user = self.model;
    
    user.state = kSAPModelStateWillLoad;
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    SAPLoginViewController *controller = self.controller;
    SAPWeakify(self);
    [login logInWithReadPermissions: @[kSAPPublicPofilePermission, kSAPUserFriendsPermission]
                 fromViewController:controller
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                SAPStrongifyAndReturnIfNil(self);
                                if (error || result.isCancelled) {
                                    @synchronized (user) {
                                        [user setState:kSAPModelStateDidFailLoading withObject:error];
                                    }
                                } else {
                                    [user performBlockWithoutNotification:^{
                                        user.state = kSAPModelStateUnloaded;
                                    }];
                                
                                    [self loadUser];
                                }
                            }
     ];
}

- (void)loadUser {
    SAPContext *context = [SAPUserContext contextWithModel:self.model];
    self.userContext = context;
    [context execute];
}

@end
