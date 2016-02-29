//
//  UIView+SAPLoadingView.h
//  IOSProject
//
//  Created by S A P on 2/29/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SAPLoadingView.h"

@interface UIView (SAPLoadingView)
@property (nonatomic, readonly) UIView<SAPLoadingView> *loadingView;

@property (nonatomic, assign) BOOL loadingViewVisible;

- (void)setLoadingViewVisible:(BOOL)loadingViewVisible
                     animated:(BOOL)animated;
- (void)setLoadingViewVisible:(BOOL)loadingViewVisible
                     animated:(BOOL)animated
                   completion:(void(^)(void))completion;

@end
