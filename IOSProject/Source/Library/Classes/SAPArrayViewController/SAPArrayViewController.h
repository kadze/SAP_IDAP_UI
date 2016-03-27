//
//  SAPTableViewController.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SAPViewController.h"
#import "SAPCollectionObserver.h"

@class SAPArrayModel;
@class SAPArrayModelChangeModel;
@class SAPActivityIndicator;

@interface SAPArrayViewController : SAPViewController<UITableViewDelegate, UITableViewDataSource, SAPCollectionObserver>
@property (nonatomic, strong) SAPArrayModel *items;

+ (Class)cellClass;

- (UITableView *)tableView;

@end
