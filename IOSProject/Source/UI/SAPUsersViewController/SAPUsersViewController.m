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
//#import "SAPArrayModelChangeModel.h"

#import "UINib+SAPextensions.h"
#import "UITableView+SAPExtensions.h"

#import "SAPViewControllerMacro.h"

SAPCategoryForViewProperty(SAPUsersViewController, SAPUsersView, tableView);

@interface SAPUsersViewController ()

- (NSArray *)indexPathsForIndex:(NSUInteger)index;
- (NSIndexPath *)indexPathForIndex:(NSUInteger)index;

@end

@implementation SAPUsersViewController

#pragma mark -
#pragma mark Accessors

- (void)setUsers:(SAPUsers *)users {
    if (_users != users) {
        [_users removeObserver:self];
        _users = users;
        [_users addObserver:self];
        
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
    SAPUsers *users = self.users;
    [users performWithNotification:^{
        [users addObject:[SAPUser new]];
    }];
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
        [users performWithNotification:^{
            [users removeObjectAtIndex:indexPath.row];
        }];
    }
}

//reordering

- (void)      tableView:(UITableView *)tableView
     moveRowAtIndexPath:(NSIndexPath *)indexPath1
            toIndexPath:(NSIndexPath *)indexPath2
{
    SAPUsers *users = self.users;
    [users performWithNotification:^{
        [users exchangeObjectAtIndex:indexPath1.row withObjectAtIndex:indexPath2.row];
    }];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark -
#pragma mark SAPArrayModelObserver

- (void)didChanged:(SAPArrayModel *)arrayModel withModel:(SAPArrayModelChangeModel *)changeModel {
    UITableView *tableView = self.tableView.tableView;
    NSArray *indexes = changeModel.indexes;
    NSUInteger index1 = [[indexes objectAtIndex:0] integerValue];
    
    switch (changeModel.changeType) {
        case kSAPChangeTypeObjectRemoved:
            [tableView deleteRowsAtIndexPaths:[self indexPathsForIndex:index1]
                             withRowAnimation:UITableViewRowAnimationFade];

            break;
        
        case kSAPChangeTypeObjectAdded:
            [tableView insertRowsAtIndexPaths:[self indexPathsForIndex:index1]
                             withRowAnimation:UITableViewRowAnimationTop];
            [tableView scrollToRowAtIndexPath:[self indexPathForIndex:index1]
                             atScrollPosition:UITableViewScrollPositionNone animated:YES];
        
            break;
        
        default:
            
            break;
    }
}

#pragma mark -
#pragma mark Private

- (NSArray *)indexPathsForIndex:(NSUInteger)index {
   return [NSArray arrayWithObject:[self indexPathForIndex:index]];
}

- (NSIndexPath *)indexPathForIndex:(NSUInteger)index {
    return [NSIndexPath indexPathForRow:index inSection:0];
}

@end
