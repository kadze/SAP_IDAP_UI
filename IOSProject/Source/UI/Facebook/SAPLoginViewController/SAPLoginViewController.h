//
//  SAPFacebookLoginViewController.h
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPViewController.h"

@class SAPFacebookUser;

@interface SAPLoginViewController : SAPViewController
@property (nonatomic, strong) SAPFacebookUser *user;

- (IBAction)onLogin:(id)sender;

@end
