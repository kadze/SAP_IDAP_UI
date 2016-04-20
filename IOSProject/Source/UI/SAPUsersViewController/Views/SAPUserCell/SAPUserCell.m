//
//  SAPDataCell.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UILabel.h>

#import "SAPUserCell.h"

#import "SAPUser.h"
#import "SAPImageView.h"

#import "SAPDispatch.h"

@implementation SAPUserCell
@synthesize model = _model;

#pragma mark -
#pragma mark Accessors

- (void)setModel:(SAPUser *)model {
    if (_model != model) {
        _model = model;
        
        [self fillWithModel:model];
    }
}

#pragma mark -
#pragma mark SAPModelView

- (void)fillWithModel:(SAPUser *)model {
    self.label.text = [NSString stringWithFormat:@"%@ %@", model.firstName, model.lastName];
//    self.userImageView.imageModel = model.smallImageModel;
}

@end
