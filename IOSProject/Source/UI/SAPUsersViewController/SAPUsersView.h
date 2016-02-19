//
//  SAPTableView.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAPUsers;

@interface SAPUsersView : UIView
@property (nonatomic, strong) IBOutlet UITableView  *tableView;
@property (nonatomic, strong) IBOutlet UIButton     *addUserButton;
@property (nonatomic, strong) IBOutlet UIButton     *editButton;

@property (nonatomic, strong) SAPUsers *users;

- (void)updateEditButtonTitle:(BOOL)editingMode;

@end
