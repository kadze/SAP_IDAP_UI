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

#import "UINib+SAPextensions.h"

#import "SAPViewControllerMacro.h"

SAPCategoryForViewProperty(SAPUsersViewController, SAPUsersView, tableView);

@implementation SAPUsersViewController

#pragma mark -
#pragma mark Accessors

- (void)setUsers:(SAPUsers *)users {
    if (_users != users) {
        _users = users;
        
        [self.tableView.usersView reloadData];
    }
}

#pragma mark-
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView.usersView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Class cellClass = [SAPUserCell class];
    NSString *cellClassName = NSStringFromClass(cellClass);
    SAPUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell) {
        cell = [UINib objectWithClass:cellClass];
    }
    
    cell.user = self.users[indexPath.row];
    
    return cell;
}

@end
