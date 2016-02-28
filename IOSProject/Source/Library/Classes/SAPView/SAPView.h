//
//  SAPView.h
//  IOSProject
//
//  Created by S A P on 2/26/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SAPLoadingView.h"

@interface SAPView : UIView
@property (nonatomic, assign) BOOL loadingViewVisible;

@property (nonatomic, strong) UIView<SAPLoadingView> *loadingView;

- (void)setLoadingViewVisible:(BOOL)loadingViewVisible
                     animated:(BOOL)animated;
- (void)setLoadingViewVisible:(BOOL)loadingViewVisible
                     animated:(BOOL)animated
                   completion:(void(^)(void))completion;

//- (UIView<SAPLoadingView> *)loadingView;

@end
