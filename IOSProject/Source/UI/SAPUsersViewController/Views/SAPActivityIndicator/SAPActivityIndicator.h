//
//  SAPLoadWaitView.h
//  IOSProject
//
//  Created by S A P on 2/24/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAPActivityIndicator : UIView
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

+ (instancetype)objectWithSuperView:(UIView *)superview;

- (void)hide;

@end
