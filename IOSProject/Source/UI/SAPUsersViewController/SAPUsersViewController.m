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
    NSString *cellClass = NSStringFromClass([SAPUserCell class]);
    SAPUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellClass];
    if (!cell) {
        UINib *nib = [UINib nibWithNibName:cellClass bundle:nil];
        NSArray *cells = [nib instantiateWithOwner:nil options:nil];
        cell = [cells firstObject];
    }
    
    cell.user = self.users[indexPath.row];
    
    return cell;
}

@end
