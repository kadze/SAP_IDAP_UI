//
//  SAPTableViewController.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPTableViewController.h"
#import "SAPTableView.h"

#import "SAPViewControllerMacro.h"

static NSUInteger const kSAPNumberOfRowsInSection = 100;

SAPCategoryForViewProperty(SAPTableViewController, SAPTableView, tableView);

@implementation SAPTableViewController

#pragma mark -
#pragma mark Accessors

- (void)setData:(SAPData *)data {
    if (_data != data) {
        _data = data;
    }
    
    //fill view
}

#pragma mark-
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.data = self.data;
    
    [self.tableView.tableViewControl reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kSAPNumberOfRowsInSection;
}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}

@end
