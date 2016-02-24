//
//  SAPSquareViewController.m
//  IOSProject
//
//  Created by S A P on 1/28/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPSquareViewController.h"

#import "SAPSquareView.h"
#import "SAPViewControllerMacro.h"

SAPViewControllerBaseViewProperty(SAPSquareViewController, SAPSquareView, squareView);

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
    [self.squareView moveToNextPosition];
}

- (IBAction)onAnimate:(id)sender {
    SAPSquareView *squareView = self.squareView;
    squareView.loopedMoving = !squareView.loopedMoving;
}


@end
