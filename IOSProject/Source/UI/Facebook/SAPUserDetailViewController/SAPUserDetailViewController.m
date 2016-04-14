//
//  SAPUserDetailViewController.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUserDetailViewController.h"

#import "SAPUserDetailView.h"
#import "SAPUserDetailContext.h"

#import "SAPViewControllerMacro.h"

SAPViewControllerBaseViewProperty(SAPUserDetailViewController, SAPUserDetailView, mainView);

@implementation SAPUserDetailViewController

@dynamic modelContext;

#pragma mark -
#pragma mark Accessors

- (SAPContext *)modelContext {
    return [SAPUserDetailContext contextWithModel:self.model];
}

#pragma mark -
#pragma mark Public

- (void)updateViewControllerWithModel:(id)model {
    self.mainView.model = model;
}

- (void)finishModelSetting {
    self.context = self.modelContext;
}

@end
