//
//  SAPTableView.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAPUsersView : UIView
@property (nonatomic, strong) IBOutlet UITableView  *tableView;
@property (nonatomic, strong) IBOutlet UIButton     *addUserButton;

- (IBAction)onLongPress:(UILongPressGestureRecognizer *)sender;

@end
