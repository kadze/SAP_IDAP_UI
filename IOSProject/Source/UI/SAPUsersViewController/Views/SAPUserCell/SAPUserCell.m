//
//  SAPDataCell.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUserCell.h"

#import "SAPUser.h"
#import "SAPView.h"

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
    self.label.text = user.name;
    self.contentImageView.image = user.image;
}

#pragma mark -
#pragma mark SAPModelObserver

- (void)modelWillLoad:(id)model {
    [self.view setLoadingViewVisible:YES animated:YES];
    
}

- (void)modelDidFinishLoading:(id)model {
    [self.view setLoadingViewVisible:NO];
}

- (void)modelDidFailLoading:(id)model {
    [self.view setLoadingViewVisible:NO];
}

- (void)modelDidBecomeUnloaded:(id)model {
    [self.view setLoadingViewVisible:NO];
}


@end
