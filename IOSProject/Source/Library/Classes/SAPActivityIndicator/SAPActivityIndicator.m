//
//  SAPLoadWaitView.m
//  IOSProject
//
//  Created by S A P on 2/24/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPActivityIndicator.h"

#import "UINib+SAPExtensions.h"

#import "SAPOwnershipMacro.h"

static NSTimeInterval const kSAPAnimationDuration  = 1.0;
CGFloat const visibleAlpha = 0.5;
CGFloat const invisibleAlpha = 0.0;

@implementation SAPActivityIndicator

@synthesize visible = _visible;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)objectWithSuperView:(UIView *)superview {
    SAPActivityIndicator *view = [UINib objectWithClass:[self class]];
    view.frame = superview.bounds;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [superview addSubview:view];
    
    return view;
}

#pragma mark -
#pragma mark SAPLoadingView 

- (void)setVisible:(BOOL)visible animated:(BOOL)animated {
    [self setVisible:visible animated:animated completion:nil];
}

- (void)setVisible:(BOOL)visible animated:(BOOL)animated completion:(void(^)(void))completion {
    if (_visible != visible) {
    CGFloat alpha = visible ? visibleAlpha : invisibleAlpha;
    [UIView animateWithDuration:animated ? kSAPAnimationDuration : 0.0
                     animations:^{
                         self.alpha = alpha;
                     }
                     completion:^(BOOL finished) {
                         _visible = visible;
                         if (completion) {
                             completion();
                         }
                     }];
    }
}

@end

