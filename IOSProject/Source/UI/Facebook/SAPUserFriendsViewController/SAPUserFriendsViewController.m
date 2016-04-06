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
#import "SAPUserContext.h"
#import "SAPUserFriendsContext.h"
#import "SAPUserDetailContext.h"
#import "SAPUserDetailViewController.h"

#import "UINib+SAPextensions.h"
#import "UITableView+SAPExtensions.h"
#import "UITableView+SAPCollectionChangeModel.h"

#import "SAPDispatch.h"

#import "SAPViewControllerMacro.h"

SAPViewControllerBaseViewProperty(SAPUserFriendsViewController, SAPUserFriendsView, mainView);

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
        [_user removeObserver:self];
        _user = user;
        [_user addObserver:self];
        
        self.context = [SAPUserContext contextWithModel:user];
        self.items = user.friends;
        
        self.detailContext = [SAPUserDetailContext contextWithModel:user];
    }
}

- (SAPUserFriendsContext *)itemsContext {
    SAPUserFriendsContext *context = [SAPUserFriendsContext new];
    context.user = self.user;
    
    return context;
}

- (void)setDetailContext:(SAPUserDetailContext *)context{
    if (_detailContext != context) {
        [_detailContext cancel];
        _detailContext = context;
        [context stateUnsafeLoad];
    }
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SAPUser *friend = self.items[indexPath.row];
    SAPUserDetailViewController *controller = [SAPUserDetailViewController new];
    controller.user = friend;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark Public

- (void)updateViewControllerWithModel:(id)model {
    [self.mainView.tableView reloadData];
    if (model == self.user) {
        self.mainView.model = model;
    }
}

@end
