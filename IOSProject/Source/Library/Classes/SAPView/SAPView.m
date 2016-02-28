//
//  SAPView.m
//  IOSProject
//
//  Created by S A P on 2/26/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPView.h"

@implementation SAPView

#pragma mark -
#pragma mark Accessors

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
    [self.loadingView setVisible:loadingViewVisible animated:animated completion:completion];
}

//- (UIView *)loadingView {
//    return nil;
//}

@end
