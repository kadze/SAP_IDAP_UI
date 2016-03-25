//
//  SAPFriendDetailViewController.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFriendDetailViewController.h"

#import "SAPFriendDetailView.h"
#import "SAPUser.h"
#import "SAPFriendDetailContext.h"
#import "SAPImageView.h"

#import "SAPDispatch.h"

#import "SAPViewControllerMacro.h"

SAPViewControllerBaseViewProperty(SAPFriendDetailViewController, SAPFriendDetailView, baseView);

@implementation SAPFriendDetailViewController

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
    SAPFriendDetailContext *context = [SAPFriendDetailContext contextWithModel:self.friend];
    self.context = context;
    [context execute];
}

#pragma mark -
#pragma mark Public

- (void)finishModelLoading {
    SAPFriendDetailView *view = self.baseView;
    SAPUser *friend = self.friend;
    
    view.userImageView.imageModel = friend.largeImageModel;
    view.firstNameLabel.text = friend.firstName;
    view.lastNameLabel.text = friend.lastName;
    view.genderLabel.text = friend.gender;
}

@end
