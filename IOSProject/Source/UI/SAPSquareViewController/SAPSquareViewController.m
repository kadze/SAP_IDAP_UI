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

static NSTimeInterval kSAPTimerInterval = 0.3;

SAPViewControllerBaseViewProperty(SAPSquareViewController, squareView, SAPSquareView, SAPPrivateViewGetterCategory)

@interface SAPSquareViewController ()
@property (nonatomic, strong) NSTimer *timer;

- (void)moveSquare;

@end

@implementation SAPSquareViewController

#pragma mark -
#pragma mark Accessors

- (void)setSquareMoving:(BOOL)squareMoving {
    if (_squareMoving != squareMoving) {
        _squareMoving = squareMoving;
        if (squareMoving) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:kSAPTimerInterval
                                                       target:self
                                                     selector:@selector(moveSquare)
                                                     userInfo:nil
                                                      repeats:YES];
        } else {
            self.timer = nil;
        }
    }
}

- (void)setTimer:(NSTimer *)timer {
    if (_timer != timer) {
        [_timer invalidate];
        _timer = timer;
    }
}

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
    [self moveSquare];
}

- (IBAction)onStartStop:(id)sender {
    SAPSquareView *squareView = self.squareView;
    if (self.isSquareMoving) {
        [self setSquareMoving:NO];
        [squareView changeButtonAppearanceForStart];
    } else {
        [self setSquareMoving:YES];
        [squareView changeButtonAppearanceForStop];
    }
}

#pragma mark -
#pragma mark Private

- (void)moveSquare {
    [self.squareView moveSquare];
}

@end
