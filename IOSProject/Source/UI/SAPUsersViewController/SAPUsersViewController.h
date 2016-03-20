//
//  SAPTableViewController.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SAPViewController.h"

@class SAPUsers;
@class SAPActivityIndicator;

@interface SAPUsersViewController : SAPViewController
@property (nonatomic, strong) SAPUsers *users;

- (IBAction)onAddUser:(id)sender;
- (IBAction)onEdit:(id)sender;

@end
