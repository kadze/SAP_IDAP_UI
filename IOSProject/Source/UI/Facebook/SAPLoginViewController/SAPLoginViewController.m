//
//  SAPFacebookLoginViewController.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPLoginViewController.h"

#import "SAPLoginView.h"
#import "SAPFriendsViewController.h"
#import "SAPFacebookUser.h"
#import "SAPFacebookLoginContext.h"

#import "SAPModelObserver.h"

#import "SAPViewControllerMacro.h"
#import "SAPOwnershipMacro.h"
#import "SAPDispatch.h"

SAPViewControllerBaseViewProperty(SAPLoginViewController, SAPLoginView, loginView);

@interface SAPLoginViewController () <SAPModelObserver>
@property (nonatomic, strong) SAPFacebookLoginContext *context;

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
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onLogin:(id)sender {
    SAPFacebookLoginContext *context = [SAPFacebookLoginContext contextWithModel:self.user];
    self.context = context;
    [context executeWithViewController:self];
}

#pragma mark -
#pragma mark SAPModelObserver

- (void)modelDidFinishLoading:(id)model {
    SAPWeakify(self);
    SAPDispatchAsyncOnMainQueue(^{
        SAPFriendsViewController *controller = [SAPFriendsViewController new];
        SAPStrongify(self);
        [self.navigationController pushViewController:controller
                                             animated:YES];
    });
}

@end
