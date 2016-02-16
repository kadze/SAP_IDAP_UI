//
//  SAPTableViewController.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SAPArrayModelObserver.h"

@class SAPUsers;
@class SAPChangeModel;

@interface SAPUsersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SAPArrayModelObserver>
@property (nonatomic, strong) SAPUsers *users;

- (IBAction)onAddUser:(id)sender;

- (void)didChanged:(SAPArrayModel *)arrayModel withModel:(SAPChangeModel *)changeModel;

@end
