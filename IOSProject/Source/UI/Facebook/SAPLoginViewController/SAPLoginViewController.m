//
//  SAPFacebookLoginViewController.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPLoginViewController.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "SAPLoginView.h"
#import "SAPUserFriendsViewController.h"
#import "SAPUser.h"
#import "SAPFacebookLoginContext.h"

#import "SAPModelObserver.h"

#import "SAPViewControllerMacro.h"
#import "SAPOwnershipMacro.h"

#import "SAPDispatch.h"

SAPViewControllerBaseViewProperty(SAPLoginViewController, SAPLoginView, baseView);

@interface SAPLoginViewController () <SAPModelObserver>

@end

@implementation SAPLoginViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    self.user = [SAPUser new];
    
    return self;
}

- (void)dealloc {
    self.user = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setUser:(SAPUser *)user {
    if (_user != user) {
        [_user removeObserver:self];
        _user = user;
        [_user addObserver:self];
    }
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onLogin:(id)sender {
    SAPFacebookLoginContext *context = [SAPFacebookLoginContext contextWithModel:self.user];
    context.controller = self;
    self.context = context;
    [context execute];
}

#pragma mark -
#pragma mark SAPModelObserver

- (void)modelDidFinishLoading:(id)model {
    SAPWeakify(self);
    SAPDispatchAsyncOnMainQueue(^{
        SAPStrongifyAndReturnIfNil(self);
        SAPUserFriendsViewController *controller = [SAPUserFriendsViewController new];
        controller.friends = self.user.friends;
        [self.navigationController pushViewController:controller
                                             animated:YES];
    });
}

@end
