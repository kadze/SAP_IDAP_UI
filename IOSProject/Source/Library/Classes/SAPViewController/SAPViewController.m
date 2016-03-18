//
//  SAPViewController.m
//  IOSProject
//
//  Created by SAP on 3/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPViewController.h"

#import "SAPView.h"
//#import "SAPUsersView.h"
//#import "SAPUserCell.h"
//#import "SAPArrayModel.h"
//#import "SAPUser.h"
//#import "SAPActivityIndicator.h"
//
#import "SAPDispatch.h"
//
//#import "UINib+SAPextensions.h"
//#import "UITableView+SAPExtensions.h"
//#import "UITableView+SAPCollectionChangeModel.h"
//
//#import "SAPCollectionObserver.h"
#import "SAPModelObserver.h"

#import "SAPViewControllerMacro.h"

SAPViewControllerBaseViewProperty(SAPViewController,
                                  SAPView,
                                  baseView);

@interface SAPViewController () <SAPModelObserver>

@end

@implementation SAPViewController

#pragma mark -
#pragma mark Class Methods

+ (Class)baseViewClass {
    return [SAPView class];
}

#pragma mark-
#pragma mark View Lifecycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark SAPModelObserver

- (void)modelWillLoad:(id)model {
    SAPDispatchAsyncOnMainQueue(^{
        [self.baseView setLoadingViewVisible:YES];
    });
}

- (void)modelDidFinishLoading:(id)model {
    SAPDispatchAsyncOnMainQueue(^{
        [self.baseView setLoadingViewVisible:NO];
    });
}

- (void)modelDidFailLoading:(id)model {
    [self.baseView setLoadingViewVisible:NO];
}

- (void)modelDidUnload:(id)model {
    [self.baseView setLoadingViewVisible:NO];
}


@end
