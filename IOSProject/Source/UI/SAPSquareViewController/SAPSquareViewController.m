//
//  SAPSquareViewController.m
//  IOSProject
//
//  Created by S A P on 1/28/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPSquareViewController.h"

#import "SAPSquareView.h"
#import "SAPViewPropertyMacro.h"

SAPCategoryForViewProperty(SAPSquareViewController, SAPSquareView, squareView);

@implementation SAPSquareViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onMove:(id)sender {
    [self.squareView moveSquare];
}

- (IBAction)onStartStop:(id)sender {
    self.squareView.moving = !self.squareView.moving;
}


@end
