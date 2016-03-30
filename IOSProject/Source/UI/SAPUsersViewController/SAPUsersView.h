//
//  SAPTableView.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIButton.h>
#import <UIKit/UITableView.h>

#import "SAPView.h"

@class SAPUsers;

@interface SAPUsersView : SAPView
@property (nonatomic, strong) IBOutlet UITableView  *tableView;
@property (nonatomic, strong) IBOutlet UIButton     *addUserButton;
@property (nonatomic, strong) IBOutlet UIButton     *editButton;

@property (nonatomic, assign) BOOL editing;

@property (nonatomic, strong) SAPUsers *users;

@end
