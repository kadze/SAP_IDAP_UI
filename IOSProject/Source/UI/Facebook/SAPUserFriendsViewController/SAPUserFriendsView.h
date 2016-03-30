//
//  SAPUserFriendsView.h
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//
#import <UIKit/UITableView.h>

#import "SAPView.h"

@class SAPUsers;

@interface SAPUserFriendsView : SAPView
@property (nonatomic, strong) IBOutlet UITableView  *tableView;

@property (nonatomic, strong) SAPUsers *users;

@end
