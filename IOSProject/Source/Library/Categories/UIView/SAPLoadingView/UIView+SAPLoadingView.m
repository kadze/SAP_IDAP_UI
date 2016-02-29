//
//  UIView+SAPLoadingView.m
//  IOSProject
//
//  Created by S A P on 2/29/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "UIView+SAPLoadingView.h"

#import "SAPActivityIndicator.h"

#import "UINib+SAPExtensions.h"
#import "NSObject+SAPAssociatedObjects.h"

@implementation UIView (SAPLoadingView)

#pragma mark -
#pragma mark Accessors

- (UIView<SAPLoadingView> *)loadingView {
    return [self associatedValueForKey:@selector(loadingView)];
}

- (void)setLoadingView:(UIView<SAPLoadingView> *)loadingView {
    UIView<SAPLoadingView> * loadingViewBefore = self.loadingView;
    if (loadingViewBefore != loadingView) {
        [loadingViewBefore removeFromSuperview];
        
        [self associateValue:loadingView withKey:@selector(loadingView)];
        
        loadingView.frame = self.bounds;
        [self addSubview:loadingView];
    }
    
}

- (BOOL)loadingViewVisible {
    return [self associatedBoolValueForKey:@selector(loadingViewVisible)];
}

- (void)setLoadingViewVisible:(BOOL)loadingViewVisible {
    [self setLoadingViewVisible:loadingViewVisible animated:YES];
}

- (void)setLoadingViewVisible:(BOOL)loadingViewVisible
                     animated:(BOOL)animated
{
    [self setLoadingViewVisible:loadingViewVisible animated:animated completion:nil];
}

- (void)setLoadingViewVisible:(BOOL)loadingViewVisible
                     animated:(BOOL)animated
                   completion:(void(^)(void))completion
{
    BOOL visibleBefore = self.loadingViewVisible;
    if (visibleBefore != loadingViewVisible) {
        if (loadingViewVisible && !self.loadingView) {
            self.loadingView = [self createLoadingView];
        }
        
        [self associateBoolValue:loadingViewVisible withKey:@selector(loadingViewVisible)];
        
        [self bringSubviewToFront:self.loadingView];
        [self.loadingView setVisible:loadingViewVisible animated:animated completion:completion];
    }
}

#pragma mark -
#pragma mark Private

- (UIView<SAPLoadingView> *)createLoadingView {
    return [UINib objectWithClass:[SAPActivityIndicator class]];
}

@end
