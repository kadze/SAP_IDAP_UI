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
    UITableView *usersView = self.usersView;
    if (UIGestureRecognizerStateBegan == sender.state) {
        [usersView setEditing:!usersView.editing animated:YES];
    }
}

@end
