//
//  SAPFacebookLoginViewController.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPLoginViewController.h"

#import "SAPLoginView.h"

#import "SAPViewControllerMacro.h"

SAPViewControllerBaseViewProperty(SAPLoginViewController, SAPLoginView, loginView);

@interface SAPLoginViewController ()

@end

@implementation SAPLoginViewController

#pragma mark-
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onLogin:(id)sender {
    
}

@end
