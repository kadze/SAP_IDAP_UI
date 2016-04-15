//
//  SAPUserFriendsViewController.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUserFriendsViewController.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "SAPUsers.h"
#import "SAPUser.h"
#import "SAPUserFriendsView.h"
#import "SAPUserCell.h"
#import "SAPCompositeUserContext.h"
#import "SAPUserDetailViewController.h"

#import "SAPViewControllerMacro.h"

#import "SAPDispatch.h"

static NSString * const kSAPLeftBarButtonTitle = @"Log out";

SAPViewControllerBaseViewProperty(SAPUserFriendsViewController, SAPUserFriendsView, mainView);

@interface SAPUserFriendsViewController ()

- (void)onLogout;
- (void)customizeLeftBarButton;

@end

@implementation SAPUserFriendsViewController

#pragma mark -
#pragma mark Class Methods

+ (Class)cellClass {
    return [SAPUserCell class];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self customizeLeftBarButton];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (UITableView *)tableView {
    return self.mainView.tableView;
}

- (SAPContext *)itemsContext {
    return [SAPCompositeUserContext contextWithModel:self.model];
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SAPUser *friend = self.items[indexPath.row];
    SAPUserDetailViewController *controller = [SAPUserDetailViewController new];
    controller.model = friend;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark Public

- (void)updateViewControllerWithModel:(id)model {
    [super updateViewControllerWithModel:model];
    if (model == self.model) {
        SAPUserFriendsView *mainView = self.mainView;
        mainView.model = model;
    }
}

- (void)finishModelSetting {
    SAPUser *model = self.model;
    self.items = model.friends;
}

#pragma mark -
#pragma mark Private

- (void)customizeLeftBarButton {
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:kSAPLeftBarButtonTitle
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(onLogout)];
    self.navigationItem.leftBarButtonItem = button;
}

- (void)onLogout {
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    SAPUser *user = self.model;
    SAPDispatchAsyncOnDefaultQueue(^{
        [user cleanCache];
    });
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
