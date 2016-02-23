//
//  SAPTableViewController.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUsersViewController.h"

#import "SAPUsersView.h"
#import "SAPUserCell.h"
#import "SAPUsers.h"
#import "SAPUser.h"

#import "UINib+SAPextensions.h"
#import "UITableView+SAPExtensions.h"
#import "UITableView+SAPCollectionChangeModel.h"

#import "SAPCollectionObserver.h"

#import "SAPViewControllerMacro.h"

SAPCategoryForViewProperty(SAPUsersViewController, SAPUsersView, usersView);

@interface SAPUsersViewController () <UITableViewDelegate, UITableViewDataSource, SAPCollectionObserver>
@end

@implementation SAPUsersViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.users = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setUsers:(SAPUsers *)users {
    if (_users != users) {
        [_users removeObserver:self];
        _users = users;
        [_users addObserver:self];
    }
    
    [self.usersView.tableView reloadData];
}

#pragma mark-
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.users = self.users;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onAddUser:(id)sender {
    SAPUsers *users = self.users;
    [users addObject:[SAPUser new]];
}

- (IBAction)onEdit:(id)sender {
    SAPUsersView *usersView = self.usersView;
    UITableView *tableView = usersView.tableView;
    BOOL newEditingState = !tableView.editing;
   
    [tableView setEditing:newEditingState animated:YES];
    [usersView updateEditButtonTitle:newEditingState];    
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SAPUserCell *cell = [tableView cellWithClass:[SAPUserCell class]];
    cell.user = self.users[indexPath.row];
    
    return cell;
}

- (void)        tableView:(UITableView *)tableView
       commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
        forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        SAPUsers *users = self.users;
        [users removeObjectAtIndex:indexPath.row];
    }
}

//reordering

- (void)      tableView:(UITableView *)tableView
     moveRowAtIndexPath:(NSIndexPath *)indexPath1
            toIndexPath:(NSIndexPath *)indexPath2
{
    SAPUsers *users = self.users;
    [users moveObjectFromIndex:indexPath1.row toIndex:indexPath2.row];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark -
#pragma mark SAPCollectionObserver

- (void)collection:(SAPArrayModel *)arrayModel didChangeWithModel:(SAPCollectionChangeModel *)changeModel {
    UITableView *tableView = self.usersView.tableView;
    [tableView updateWithCollectionChangeModel:changeModel];
}

#pragma mark -
#pragma mark Public

- (void)saveUsers{
    [NSKeyedArchiver archiveRootObject:self.users toFile:[SAPUsers archivePath]];
}

- (NSArray *)loadUsers{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[SAPUsers archivePath]];
}

@end
