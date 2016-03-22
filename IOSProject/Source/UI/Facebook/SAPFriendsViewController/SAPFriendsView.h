//
//  SAPFriendsView.h
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPView.h"

@class SAPUsers;

@interface SAPFriendsView : SAPView
@property (nonatomic, strong) IBOutlet UITableView  *tableView;

@property (nonatomic, strong) SAPUsers *users;

@end
