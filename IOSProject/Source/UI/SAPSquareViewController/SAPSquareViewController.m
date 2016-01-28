//
//  SAPSquareViewController.m
//  IOSProject
//
//  Created by S A P on 1/28/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPSquareViewController.h"
#import "SAPSquareView.h"
#import "SAPMacro.h"

SAPViewControllerBaseViewProperty(SAPSquareViewController, squareView, SAPSquareView, SAPPrivateViewGetterCategory)

@implementation SAPSquareViewController

#pragma mark -
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

- (IBAction)onSquareMove:(id)sender {
    [self.squareView moveSquare];
}

@end
