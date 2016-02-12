//
//  SAPTableViewController.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAPUsers;

@interface SAPUsersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) SAPUsers *users;

- (IBAction)onAddUser:(id)sender;

- (void)deleteRowWithIndexPath:(NSIndexPath *)indexPath;

- (void)insertRowWithIndexPath:(NSIndexPath *)indexPath;

@end
