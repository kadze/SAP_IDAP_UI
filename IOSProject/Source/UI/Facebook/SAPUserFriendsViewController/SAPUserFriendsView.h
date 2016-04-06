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
@class SAPUser;
@class SAPImageView;

@interface SAPUserFriendsView : SAPView
@property (nonatomic, strong) IBOutlet SAPImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel      *firstNameLabel;
@property (nonatomic, strong) IBOutlet UILabel      *lastNameLabel;
@property (nonatomic, strong) IBOutlet UILabel      *genderLabel;

@property (nonatomic, strong) IBOutlet UITableView  *tableView;

@property (nonatomic, strong) SAPUsers *users;
@property (nonatomic, strong) SAPUser  *model;

@end
