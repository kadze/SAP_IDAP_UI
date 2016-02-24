//
//  SAPTableView.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUsersView.h"

#import <UIKit/UIButton.h>

#import "SAPUsers.h"

#import "UITableView+SAPCollectionChangeModel.h"

static NSString * const kSAPButtonTitleDone = @"Done";
static NSString * const kSAPButtonTitleEdit = @"Edit";

@implementation SAPUsersView

#pragma mark -
#pragma mark Accessors

- (void)setEditing:(BOOL)editing {
    self.tableView.editing = editing;
    [self.editButton setTitle:(editing ? kSAPButtonTitleDone : kSAPButtonTitleEdit)
                     forState:UIControlStateNormal];
}

@end
