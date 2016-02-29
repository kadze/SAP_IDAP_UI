//
//  SAPDataCell.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUserCell.h"

#import "SAPUser.h"

@interface SAPUserCell ()

- (void)fillWithModel:(SAPUser *)user;

@end

@implementation SAPUserCell

#pragma mark -
#pragma mark Accessors

- (void)setUser:(SAPUser *)user {
    if (_user != user) {
        [_user removeObserver:self];
        _user = user;
        [_user addObserver:self];
        [self fillWithModel:user];
    }
}

#pragma mark -
#pragma mark Private

- (void)fillWithModel:(SAPUser *)user {
    self.userLabel.text = user.name;
    self.userImageView.image = user.image;
}

#pragma mark -
#pragma mark SAPModelObserver

- (void)modelWillLoad:(id)model {
    [self setLoadingViewVisible:YES animated:YES];
    
}

- (void)modelDidFinishLoading:(id)model {
//    [self updateViewWithModel];
//    [self.usersView setLoadingViewVisible:NO];
}

- (void)modelDidFailLoading:(id)model {
//    [self.usersView setLoadingViewVisible:NO];
}

- (void)modelDidBecomeUnloaded:(id)model {
//    [self.usersView setLoadingViewVisible:NO];
}


@end
