//
//  SAPTableViewController.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAPDataArray;

@interface SAPTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) SAPDataArray *dataArray;

@end
