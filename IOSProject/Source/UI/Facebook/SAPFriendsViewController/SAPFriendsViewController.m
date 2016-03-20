//
//  SAPFriendsViewController.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFriendsViewController.h"

#import "SAPUsers.h"
#import "SAPFriendsView.h"
#import "SAPUserCell.h"

#import "UINib+SAPextensions.h"
#import "UITableView+SAPExtensions.h"
#import "UITableView+SAPCollectionChangeModel.h"

#import "SAPCollectionObserver.h"

#import "SAPDispatch.h"

#import "SAPViewControllerMacro.h"

SAPViewControllerBaseViewProperty(SAPFriendsViewController, SAPFriendsView, friendsView);

@interface SAPFriendsViewController () <UITableViewDelegate, UITableViewDataSource, SAPCollectionObserver, SAPModelObserver>

- (void)reloadView;

@end

@implementation SAPFriendsViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.friends = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setFriends:(SAPUsers *)friends {
    if (_friends != friends) {
        [_friends removeObserver:self];
        _friends = friends;
        [_friends addObserver:self];
        
        [_friends load];
    }
}

#pragma mark-
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.friends load];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SAPUserCell *cell = [tableView cellWithClass:[SAPUserCell class]];
    cell.user = self.friends[indexPath.row];
    
    return cell;
}

- (void)        tableView:(UITableView *)tableView
       commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
        forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        [self.friends removeObjectAtIndex:indexPath.row];
    }
}

//reordering

- (void)      tableView:(UITableView *)tableView
     moveRowAtIndexPath:(NSIndexPath *)indexPath1
            toIndexPath:(NSIndexPath *)indexPath2
{
    SAPUsers *friends = self.friends;
    [friends moveObjectFromIndex:indexPath1.row toIndex:indexPath2.row];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark -
#pragma mark SAPCollectionObserver

- (void)collection:(SAPArrayModel *)arrayModel didChangeWithModel:(SAPCollectionChangeModel *)changeModel {
    UITableView *tableView = self.friendsView.tableView;
    [tableView updateWithCollectionChangeModel:changeModel];
}

#pragma mark -
#pragma mark SAPModelObserver

- (void)modelWillLoad:(id)model {
    SAPDispatchAsyncOnMainQueue(^{
        [self.friendsView setLoadingViewVisible:YES];
    });
}

- (void)modelDidFinishLoading:(id)model {
    SAPDispatchAsyncOnMainQueue(^{
        [self reloadView];
        [self.friendsView setLoadingViewVisible:NO];
    });
}

- (void)modelDidFailLoading:(id)model {
    [self.friendsView setLoadingViewVisible:NO];
}

- (void)modelDidUnload:(id)model {
    [self.friendsView setLoadingViewVisible:NO];
}

#pragma mark -
#pragma mark Private

- (void)reloadView {
    [self.friendsView.tableView reloadData];
}

@end
