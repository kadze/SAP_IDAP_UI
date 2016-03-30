//
//  SAPUserDetailView.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//
#import <UIKit/UILabel.h>

#import "SAPUserDetailView.h"

#import "SAPUser.h"
#import "SAPImageView.h"

@interface SAPUserDetailView ()
- (void)fillWithModel:(SAPUser *)model;

@end

@implementation SAPUserDetailView

#pragma mark -
#pragma mark Accessors

- (void)setModel:(SAPUser *)model {
    if (_model != model) {
        _model = model;
        
        [self fillWithModel:model];
    }
}

#pragma mark -
#pragma mark Private

- (void)fillWithModel:(SAPUser *)model {
    self.imageView.imageModel = model.largeImageModel;
    self.firstNameLabel.text = model.firstName;
    self.lastNameLabel.text = model.lastName;
    self.genderLabel.text = model.gender;
}

@end
