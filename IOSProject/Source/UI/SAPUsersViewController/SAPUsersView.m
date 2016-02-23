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
#pragma mark Public

- (void)updateEditButtonTitle:(BOOL)editingMode {
    [self.editButton setTitle:(editingMode ? kSAPButtonTitleDone : kSAPButtonTitleEdit)
                     forState:UIControlStateNormal];
}

@end
