//
//  SAPTableViewController.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPArrayViewController.h"

#import "SAPUsersView.h"
#import "SAPUserCell.h"
#import "SAPArrayModel.h"
#import "SAPUser.h"
#import "SAPActivityIndicator.h"

#import "SAPDispatch.h"

#import "UINib+SAPextensions.h"
#import "UITableView+SAPExtensions.h"
#import "UITableView+SAPCollectionChangeModel.h"

#import "SAPCollectionObserver.h"

#import "SAPViewControllerMacro.h"

SAPViewControllerBaseViewProperty(SAPArrayViewController, SAPUsersView, itemsView);

@interface SAPArrayViewController () <UITableViewDelegate, UITableViewDataSource, SAPCollectionObserver, SAPModelObserver>

- (void)reloadView;

@end

@implementation SAPArrayViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.items = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setitems:(SAPArrayModel *)items {
    if (_items != items) {
        [_items removeObserver:self];
        _items = items;
        [_items addObserver:self];
        
        [_items load];
    }
}

#pragma mark-
#pragma mark View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [self.items load];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Interface Handling

//- (IBAction)onAddUser:(id)sender {
//    SAPitems *items = self.items;
//    [items addObject:[SAPUser new]];
//}
//
//- (IBAction)onEdit:(id)sender {
//    SAPitemsView *itemsView = self.itemsView;
//    itemsView.editing = !itemsView.editing;
//}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SAPUserCell *cell = [tableView cellWithClass:[SAPUserCell class]];
    cell.user = self.items[indexPath.row];
    
    return cell;
}

- (void)        tableView:(UITableView *)tableView
       commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
        forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        SAPArrayModel *items = self.items;
        [items removeObjectAtIndex:indexPath.row];
    }
}

//reordering

- (void)      tableView:(UITableView *)tableView
     moveRowAtIndexPath:(NSIndexPath *)indexPath1
            toIndexPath:(NSIndexPath *)indexPath2
{
    SAPArrayModel *items = self.items;
    [items moveObjectFromIndex:indexPath1.row toIndex:indexPath2.row];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark -
#pragma mark SAPCollectionObserver

- (void)collection:(SAPArrayModel *)arrayModel didChangeWithModel:(SAPCollectionChangeModel *)changeModel {
    UITableView *tableView = self.itemsView.tableView;
    [tableView updateWithCollectionChangeModel:changeModel];
}

#pragma mark -
#pragma mark SAPModelObserver

- (void)modelWillLoad:(id)model {
    SAPDispatchAsyncOnMainQueue(^{
        [self.itemsView setLoadingViewVisible:YES animated:YES];
    });
}

- (void)modelDidFinishLoading:(id)model {
    SAPDispatchAsyncOnMainQueue(^{
        [self reloadView];
        [self.itemsView setLoadingViewVisible:NO];
    });
}

- (void)modelDidFailLoading:(id)model {
    [self.itemsView setLoadingViewVisible:NO];
}

- (void)modelDidUnload:(id)model {
    [self.itemsView setLoadingViewVisible:NO];
}

#pragma mark -
#pragma mark Private

- (void)reloadView {
//    [self.itemsView.tableView reloadData];
}

@end
