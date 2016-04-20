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
#import "SAPCoreDataController.h"

#import "SAPViewControllerMacro.h"
#import "SAPOwnershipMacro.h"

#import "SAPDispatch.h"

static NSString * const kSAPLeftBarButtonTitle = @"Log out";

SAPViewControllerBaseViewProperty(SAPUserFriendsViewController, SAPUserFriendsView, mainView);

@interface SAPUserFriendsViewController ()
@property (nonatomic, strong) NSManagedObjectID *userManagedObjectID;

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
    SAPUserDetailViewController *controller = [SAPUserDetailViewController new];
    controller.model = self.items[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark Public

- (void)updateViewControllerWithModel:(id)model {
    [super updateViewControllerWithModel:model];
    if (model == self.model) {
        
        SAPCoreDataController *controller = [[SAPCoreDataController alloc] init];
        NSManagedObjectContext *managedObjectContext = controller.managedObjectContext;
        model = [managedObjectContext objectWithID:self.userManagedObjectID];
        
        SAPUserFriendsView *mainView = self.mainView;
        mainView.model = model;
    }
}

- (void)finishModelSetting {
    SAPUser *user = self.model;
    self.items = user.friends;
    self.userManagedObjectID = user.objectID;
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
    self.mainView.loadingViewVisible = YES;
    
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    
    SAPWeakify(self);
    SAPDispatchAsyncOnDefaultQueue(^{
        SAPStrongifyAndReturnIfNil(self);
        [self.model cleanCache];
        
        SAPWeakify(self);
        SAPDispatchAsyncOnMainQueue(^{
            SAPStrongifyAndReturnIfNil(self);
            self.mainView.loadingViewVisible = NO;
            
            [self.navigationController popViewControllerAnimated:YES];
        });
    });
}

@end
