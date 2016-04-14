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
#pragma mark Public

- (void)updateViewControllerWithModel:(id)model {
    self.mainView.model = model;
}

- (void)finishModelSetting {
    SAPUserDetailContext *context = [SAPUserDetailContext contextWithModel:self.model];
    self.context = context;
}

@end
