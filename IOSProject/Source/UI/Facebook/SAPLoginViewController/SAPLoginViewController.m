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
#import "SAPUserDetailContext.h"

#import "SAPModelObserver.h"

#import "SAPViewControllerMacro.h"
#import "SAPOwnershipMacro.h"

#import "SAPDispatch.h"

static NSString * const kSAPBackBarButtonTitle = @"Log out";

SAPViewControllerBaseViewProperty(SAPLoginViewController, SAPLoginView, mainView);

@interface SAPLoginViewController ()

- (void)customiseBackBarButton;

@end

@implementation SAPLoginViewController

@dynamic modelContext;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self customiseBackBarButton];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (SAPContext *)modelContext {
    SAPFacebookLoginContext *context = [SAPFacebookLoginContext contextWithModel:self.model];
    context.controller = self;
    
    return context;
}

#pragma mark-
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self finishLogin];
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onLogin:(id)sender {
    self.model = [SAPModel new];
    self.context = self.modelContext;
}

#pragma mark -
#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if (viewController == self) {
        [self onLogout];
    }
}

#pragma mark -
#pragma mark Public

- (void)finishLogin {
    SAPUser *user = [self currentTokenIDUser];
    if (user) {
        SAPUserFriendsViewController *controller = [SAPUserFriendsViewController new];
        controller.model = user;
        
        [self.navigationController pushViewController:controller animated:NO];
    }
}

- (void)updateViewControllerWithModel:(id)model {
    [self finishLogin];
}

#pragma mark -
#pragma mark Private

- (void)customiseBackBarButton {
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:kSAPBackBarButtonTitle
                                                               style:UIBarButtonItemStylePlain
                                                              target:nil
                                                              action:nil];
    self.navigationItem.backBarButtonItem = button;
}

- (void)onLogout {
    SAPUser *user = [self currentTokenIDUser];
    if (user) {
        SAPUserDetailContext *context = [SAPUserDetailContext contextWithModel:user];
        [context cleanCacheInBackground];
        
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        [loginManager logOut];
    }
}

- (SAPUser *)currentTokenIDUser {
    SAPUser *result = nil;
    FBSDKAccessToken *accessToken = [FBSDKAccessToken currentAccessToken];
    if (accessToken) {
        SAPUser *user = [SAPUser new];
        user.userId = accessToken.userID;
        result = user;
    }
    
    return result;
}

@end
