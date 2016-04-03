//
//  SAPUserDetailViewController.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUserDetailViewController.h"

#import "SAPUserDetailView.h"
#import "SAPUser.h"
#import "SAPUserDetailContext.h"

#import "SAPDispatch.h"

#import "SAPViewControllerMacro.h"

SAPViewControllerBaseViewProperty(SAPUserDetailViewController, SAPUserDetailView, mainView);

@implementation SAPUserDetailViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.user = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setUser:(SAPUser *)user {
    if (_user != user) {
        [_user removeObserver:self];
        _user = user;
        [_user addObserver:self];
    }
}

#pragma mark-
#pragma mark View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    SAPUserDetailContext *context = [SAPUserDetailContext contextWithModel:self.user];
    self.context = context;
}

#pragma mark -
#pragma mark Public

- (void)updateViewControllerWithModel:(id)model {
    self.mainView.model = model;
}

@end
