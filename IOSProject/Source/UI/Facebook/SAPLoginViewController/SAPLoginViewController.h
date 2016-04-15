//
//  SAPFacebookLoginViewController.h
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UINavigationController.h>

#import "SAPViewController.h"

@class SAPUser;

@interface SAPLoginViewController : SAPViewController <UINavigationControllerDelegate>

- (IBAction)onLogin:(id)sender;

- (void)finishLogin;

@end
