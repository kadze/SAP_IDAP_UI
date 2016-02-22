//
//  SAPTableViewController.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAPUsers;
@class SAPArrayModelChangeModel;

@interface SAPUsersViewController : UIViewController
@property (nonatomic, strong) SAPUsers *users;

- (IBAction)onAddUser:(id)sender;
- (IBAction)onEdit:(id)sender;

- (void)saveUsers;
- (NSArray *)loadUsers;

@end
