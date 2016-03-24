//
//  SAPDataCell.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUserCell.h"

#import "SAPUser.h"
#import "SAPImageView.h"

#import "SAPDispatch.h"

@interface SAPUserCell ()

- (void)fillWithModel:(SAPUser *)user;

@end

@implementation SAPUserCell

#pragma mark -
#pragma mark Accessors

- (void)setUser:(SAPUser *)user {
    if (_user != user) {
        _user = user;
        
        [self fillWithModel:user];
    }
}

#pragma mark -
#pragma mark Private

- (void)fillWithModel:(SAPUser *)user {
    self.label.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    self.userImageView.imageModel = user.imageModel;
}

@end
