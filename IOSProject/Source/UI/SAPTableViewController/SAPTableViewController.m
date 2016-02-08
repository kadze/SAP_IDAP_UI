//
//  SAPTableViewController.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPTableViewController.h"
#import "SAPTableView.h"
#import "SAPDataCell.h"
#import "SAPDataArray.h"

#import "SAPViewControllerMacro.h"

SAPCategoryForViewProperty(SAPTableViewController, SAPTableView, tableView);

@implementation SAPTableViewController

#pragma mark -
#pragma mark Accessors

- (void)setDataArray:(SAPDataArray *)dataArray {
    if (_dataArray != dataArray) {
        _dataArray = dataArray;
    }
}

#pragma mark-
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView.tableViewControl reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellClass = NSStringFromClass([SAPDataCell class]);
    SAPDataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellClass];
    if (!cell) {
        UINib *nib = [UINib nibWithNibName:cellClass bundle:nil];
        NSArray *cells = [nib instantiateWithOwner:nil options:nil];
        cell = [cells firstObject];
    }
    
    cell.data = self.dataArray[indexPath.row];
    
    return cell;
}

@end
