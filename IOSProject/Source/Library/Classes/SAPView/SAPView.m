//
//  SAPView.m
//  IOSProject
//
//  Created by S A P on 2/26/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPView.h"

#import "SAPActivityIndicator.h"

@interface SAPView ()
@property (nonatomic, strong) UIView<SAPLoadingView> *loadingView;

- (UIView<SAPLoadingView> *)createLoadingView;

@end

@implementation SAPView

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.loadingView = [self createLoadingView];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setLoadingView:(UIView<SAPLoadingView> *)loadingView {
    if (_loadingView != loadingView) {
        [_loadingView removeFromSuperview];
        _loadingView = loadingView;
        loadingView.frame = self.bounds;
        loadingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:loadingView];
    }
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
    if (_loadingViewVisible != loadingViewVisible) {
        if (loadingViewVisible && !self.loadingView) {
            self.loadingView = [self createLoadingView];
        }
        
        [self.loadingView setVisible:loadingViewVisible animated:animated completion:completion];
        [self bringSubviewToFront:self.loadingView];
    }
}

#pragma mark -
#pragma mark Private

- (UIView<SAPLoadingView> *)createLoadingView {
    return [SAPActivityIndicator new];
}

//- (UIView *)loadingView {
//    return nil;
//}

@end
