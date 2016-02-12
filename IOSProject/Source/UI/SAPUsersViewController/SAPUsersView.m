//
//  SAPTableView.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUsersView.h"

@implementation SAPUsersView

- (IBAction)onLongPress:(UILongPressGestureRecognizer *)sender {
    UITableView *tableView = self.tableView;
    if (UIGestureRecognizerStateRecognized == sender.state) {
        [tableView setEditing:!tableView.editing animated:YES];
    }
}

@end
