//
//  SAPLoadWaitView.m
//  IOSProject
//
//  Created by S A P on 2/24/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPLoadWaitView.h"

#import "UINib+SAPExtensions.h"

@implementation SAPLoadWaitView

+ (instancetype)objectWithSuperView:(UIView *)superview {
    SAPLoadWaitView *view = [UINib objectWithClass:[self class]];
    [superview addSubview:view];
    
    return view;
}

@end

