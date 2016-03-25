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
#import "SAPImageView.h"

#import "SAPDispatch.h"

#import "SAPViewControllerMacro.h"

SAPViewControllerBaseViewProperty(SAPUserDetailViewController, SAPUserDetailView, baseView);

@implementation SAPUserDetailViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.friend = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setFriend:(SAPUser *)friend {
    if (_friend != friend) {
        [_friend removeObserver:self];
        _friend = friend;
        [_friend addObserver:self];
    }
}

#pragma mark-
#pragma mark View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    SAPUserDetailContext *context = [SAPUserDetailContext contextWithModel:self.friend];
    self.context = context;
    [context execute];
}

#pragma mark -
#pragma mark Public

- (void)finishModelLoading {
    SAPUserDetailView *view = self.baseView;
    SAPUser *friend = self.friend;
    
    view.userImageView.imageModel = friend.largeImageModel;
    view.firstNameLabel.text = friend.firstName;
    view.lastNameLabel.text = friend.lastName;
    view.genderLabel.text = friend.gender;
}

@end
