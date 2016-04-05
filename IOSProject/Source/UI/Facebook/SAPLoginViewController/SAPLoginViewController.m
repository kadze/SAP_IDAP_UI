//
//  SAPFacebookLoginViewController.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPLoginViewController.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKAccessToken.h>

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

#pragma mark-
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBSDKAccessToken *accessToken = [FBSDKAccessToken currentAccessToken];
    if (accessToken) {
        SAPUser *user = [SAPUser new];
        user.userId = accessToken.userID;
        
        SAPUserFriendsViewController *controller = [SAPUserFriendsViewController new];
        controller.user = user;
        
        [self.navigationController pushViewController:controller animated:NO];
    }
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onLogin:(id)sender {
    SAPUser *user = self.user;
    SAPFacebookLoginContext *context = [SAPFacebookLoginContext contextWithModel:user];
    context.controller = self;
    self.context = context;
}

#pragma mark -
#pragma mark Public

- (void)updateViewControllerWithModel:(id)model {
    SAPUser *user = self.user;
    self.user = [SAPUser new];
    //new user so as to remove self from observer of the old user. Not nil because init self with user, not nil.
    
    SAPUserFriendsViewController *controller = [SAPUserFriendsViewController new];
    controller.user = user;
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
