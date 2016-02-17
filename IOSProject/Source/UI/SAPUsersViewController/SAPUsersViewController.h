//
//  SAPTableViewController.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SAPCollectionObserver.h"

@class SAPUsers;
@class SAPArrayModelChangeModel;

@interface SAPUsersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SAPCollectionObserver>
@property (nonatomic, strong) SAPUsers *users;

- (IBAction)onAddUser:(id)sender;

- (void)collection:(SAPArrayModel *)arrayModel didChangedWithModel:(SAPCollectionChangeModel *)changeModel;

@end
