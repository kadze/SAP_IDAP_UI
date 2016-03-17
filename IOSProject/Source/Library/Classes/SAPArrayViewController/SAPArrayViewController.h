//
//  SAPTableViewController.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SAPArrayModel;
@class SAPArrayModelChangeModel;
@class SAPActivityIndicator;

@interface SAPArrayViewController : UIViewController
@property (nonatomic, strong) SAPArrayModel *items;

//- (IBAction)onAddUser:(id)sender;
//- (IBAction)onEdit:(id)sender;

@end
