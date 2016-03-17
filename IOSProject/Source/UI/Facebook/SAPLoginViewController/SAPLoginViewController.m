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
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "SAPViewControllerMacro.h"
#import "SAPOwnershipMacro.h"

SAPViewControllerBaseViewProperty(SAPLoginViewController, SAPLoginView, loginView);

@interface SAPLoginViewController ()

@end

@implementation SAPLoginViewController

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
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    SAPWeakify(self);
    [login logInWithReadPermissions: @[@"public_profile"]
                 fromViewController:self
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                if (error) {
                                    NSLog(@"Process error");
                                } else if (result.isCancelled) {
                                    NSLog(@"Cancelled");
                                } else {
                                    SAPFriendsViewController *controller = [SAPFriendsViewController new];
                                    SAPStrongify(self);
                                    [self.navigationController pushViewController:controller
                                                                         animated:YES];
                                }
                            }];}

@end
