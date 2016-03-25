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

@interface SAPArrayViewController () <UITableViewDelegate, UITableViewDataSource, SAPCollectionObserver>

- (id)cellClass;

@end

@implementation SAPArrayViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.items = nil;
}

#pragma mark -
#pragma mark Class Methods

+ (Class)cellClass {
    return Nil;
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
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SAPTableViewCell *cell = [tableView cellWithClass:[self cellClass]];
    //cell.user = self.items[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark SAPCollectionObserver

- (void)collection:(SAPArrayModel *)arrayModel
didChangeWithModel:(SAPCollectionChangeModel *)changeModel
{
    UITableView *tableView = self.tableView;
    [tableView updateWithCollectionChangeModel:changeModel];
}

#pragma mark -
#pragma mark Private

- (id)cellClass {
    return [[self class] cellClass];
}

#pragma mark -
#pragma mark Public

- (UITableView *)tableView {
    return nil;
}

@end
