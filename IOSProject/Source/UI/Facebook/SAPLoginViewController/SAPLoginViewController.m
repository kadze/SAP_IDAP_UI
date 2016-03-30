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

SAPViewControllerBaseViewProperty(SAPLoginViewController, SAPLoginView, mainView);

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
}

#pragma mark -
#pragma mark Public

- (void)updateViewControllerWithModel:(id)model {
    SAPUserFriendsViewController *controller = [SAPUserFriendsViewController new];
    controller.user = self.user;
    //new user so as to remove self from observer of old user. Not nil because init self with user, not nil.
    self.user = [SAPUser new];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
