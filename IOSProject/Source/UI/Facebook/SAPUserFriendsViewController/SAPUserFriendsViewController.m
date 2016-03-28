//
//  SAPUserFriendsViewController.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUserFriendsViewController.h"

#import "SAPUsers.h"
#import "SAPUser.h"
#import "SAPUserFriendsView.h"
#import "SAPUserCell.h"
#import "SAPUserFriendsContext.h"
#import "SAPUserDetailViewController.h"

#import "UINib+SAPextensions.h"
#import "UITableView+SAPExtensions.h"
#import "UITableView+SAPCollectionChangeModel.h"

#import "SAPDispatch.h"

#import "SAPViewControllerMacro.h"

SAPViewControllerBaseViewProperty(SAPUserFriendsViewController, SAPUserFriendsView, baseView);

@interface SAPUserFriendsViewController ()

- (void)reloadView;

@end

@implementation SAPUserFriendsViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.user = nil;
}

#pragma mark -
#pragma mark Class Methods

+ (Class)cellClass {
    return [SAPUserCell class];
}

#pragma mark -
#pragma mark Accessors

- (void)setUser:(SAPUser *)user {
    if (_user != user) {
        _user = user;
        
        self.items = user.friends;
    }
}

#pragma mark-
#pragma mark View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    SAPUserFriendsContext *context = [SAPUserFriendsContext new];
    context.user = self.user;
    self.context = context;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SAPUser *friend = self.items[indexPath.row];
    SAPUserDetailViewController *controller = [SAPUserDetailViewController new];
    controller.friend = friend;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark Public

- (void)updateViewControllerWithModel:(id)model {
    [self reloadView];
}

#pragma mark -
#pragma mark Private

- (void)reloadView {
    [self.baseView.tableView reloadData];
}

@end
