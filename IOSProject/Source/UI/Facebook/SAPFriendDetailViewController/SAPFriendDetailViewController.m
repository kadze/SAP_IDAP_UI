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

SAPViewControllerBaseViewProperty(SAPFriendDetailViewController, SAPFriendDetailView, friendDetailView);

@interface SAPFriendDetailViewController ()
@property (nonatomic, strong) SAPFriendDetailContext *context;

- (void)fillWithModel;

@end

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
#pragma mark SAPModelObserver

- (void)modelWillLoad:(id)model {
    SAPDispatchAsyncOnMainQueue(^{
        self.friendDetailView.loadingViewVisible = YES;
    });
}

- (void)modelDidFinishLoading:(id)model {
    SAPDispatchAsyncOnMainQueue(^{
        [self fillWithModel];
        self.friendDetailView.loadingViewVisible = NO;
    });
}

- (void)modelDidFailLoading:(id)model {
    self.friendDetailView.loadingViewVisible = NO;
}

- (void)modelDidUnload:(id)model {
    self.friendDetailView.loadingViewVisible = NO;
}

#pragma mark -
#pragma mark Private

- (void)fillWithModel {
    SAPFriendDetailView *view = self.friendDetailView;
    SAPUser *friend = self.friend;
    
    view.userImageView.imageModel = friend.largeImageModel;
    view.firstNameLabel.text = friend.firstName;
    view.lastNameLabel.text = friend.lastName;
    view.genderLabel.text = friend.gender;
}

@end
