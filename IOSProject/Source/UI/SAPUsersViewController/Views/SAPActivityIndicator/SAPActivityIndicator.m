//
//  SAPLoadWaitView.m
//  IOSProject
//
//  Created by S A P on 2/24/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPActivityIndicator.h"

#import "UINib+SAPExtensions.h"

static NSTimeInterval const kSAPHideAnimationDuration  = 1.0;

@implementation SAPActivityIndicator

+ (instancetype)objectWithSuperView:(UIView *)superview {
    SAPActivityIndicator *view = [UINib objectWithClass:[self class]];
    view.frame = superview.bounds;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [superview addSubview:view];
    [view startAnimating];
    
    return view;
}

- (void)hide {
    [UIView animateWithDuration:kSAPHideAnimationDuration
                    animations:^{
                        [self stopAnimating];
    }];
}

@end

