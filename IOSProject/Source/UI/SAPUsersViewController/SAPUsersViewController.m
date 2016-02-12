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

#import "SAPViewControllerMacro.h"

SAPCategoryForViewProperty(SAPUsersViewController, SAPUsersView, tableView);

@implementation SAPUsersViewController

#pragma mark -
#pragma mark Accessors

- (void)setUsers:(SAPUsers *)users {
    if (_users != users) {
        _users = users;
        if (users) {
            [_users addObserver:self];
        } else {
            [_users removeObserver:self];
        }
        [self.tableView.tableView reloadData];
    }
}

#pragma mark-
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onAddUser:(id)sender {
    [self.users addObject:[SAPUser new]];
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
        [self.users removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
//                                        withRowAnimation:UITableViewRowAnimationFade];
    }
}

//reordering

-       (void)tableView:(UITableView *)tableView
     moveRowAtIndexPath:(NSIndexPath *)indexPath1
            toIndexPath:(NSIndexPath *)indexPath2
{
    [self.users exchangeObjectAtIndex:indexPath1.row withObjectAtIndex:indexPath2.row];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark -
#pragma mark UITableViewDelegate

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
//           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleNone;
//}

#pragma mark -
#pragma mark Public

- (void)deleteRowWithIndexPath:(NSIndexPath *)indexPath {
    [self.tableView.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                             withRowAnimation:UITableViewRowAnimationFade];
}

- (void)insertRowWithIndexPath:(NSIndexPath *)indexPath {
    [self.tableView.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath ] withRowAnimation:UITableViewRowAnimationTop];
}

@end
