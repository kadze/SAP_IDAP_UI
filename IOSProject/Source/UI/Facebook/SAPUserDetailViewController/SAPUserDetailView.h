//
//  SAPUserDetailView.h
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//
#import <UIKit/UILabel.h>

#import "SAPView.h"

@class SAPImageView;
@class SAPUser;

@interface SAPUserDetailView : SAPView
@property (nonatomic, strong) IBOutlet SAPImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel      *firstNameLabel;
@property (nonatomic, strong) IBOutlet UILabel      *lastNameLabel;
@property (nonatomic, strong) IBOutlet UILabel      *genderLabel;

@property (nonatomic, strong) SAPUser  *model;

@end
