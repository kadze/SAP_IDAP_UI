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
#import "SAPFriendsViewController.h"
#import "SAPFacebookUser.h"
#import "SAPFacebookLoginContext.h"
#import "SAPFacebookFriendsContext.h"
#import "SAPUsers.h"

#import "SAPModelObserver.h"

#import "SAPViewControllerMacro.h"
#import "SAPOwnershipMacro.h"
#import "SAPDispatch.h"

SAPViewControllerBaseViewProperty(SAPLoginViewController, SAPLoginView, loginView);

@interface SAPLoginViewController () <SAPModelObserver>
@property (nonatomic, strong) SAPFacebookLoginContext *context;
@property (nonatomic, strong) SAPFacebookFriendsContext *friendsContext;

@end

@implementation SAPLoginViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    self.user = [SAPFacebookUser new];
    
    return self;
}

- (void)dealloc {
    self.user = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setUser:(SAPFacebookUser *)user {
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onLogin:(id)sender {
    SAPFacebookLoginContext *context = [SAPFacebookLoginContext contextWithModel:self.user];
    self.context = context;
    context.controller = self;
    [context execute];
}

- (IBAction)onLogout:(id)sender {
    FBSDKLoginManager *manager = [[FBSDKLoginManager alloc] init];
    [manager logOut];
}

#pragma mark -
#pragma mark SAPModelObserver

- (void)modelDidFinishLoading:(id)model {
    SAPWeakify(self);
    SAPDispatchAsyncOnMainQueue(^{
        SAPFriendsViewController *controller = [SAPFriendsViewController new];
        SAPStrongify(self);
        controller.friends = self.user.friends;
        [self.navigationController pushViewController:controller
                                             animated:YES];
    });
}

#pragma mark -
#pragma mark Public
- (void)loadUserFromWeb {
    SAPFacebookUser *user = self.user;
    @synchronized(user) {
        NSUInteger state = user.state;
        if (kSAPModelStateDidFinishLoading == state || kSAPModelStateWillLoad == state) {
            [user notifyObserversWithSelector:[user selectorForState:state]];
            
            return;
        }
        
        user.state = kSAPModelStateWillLoad;
        
        SAPFacebookFriendsContext *context = [SAPFacebookFriendsContext contextWithModel:user];
        self.friendsContext = context;
        [context execute];
    }
}

- (void)loadUserFromDisk {
    [self.user.friends load];
}

@end
