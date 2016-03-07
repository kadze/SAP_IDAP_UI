//
//  SAPDataCell.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPTableViewCell.h"

#import "SAPImageView.h"

@class SAPUser;
@class SAPView;

@interface SAPUserCell : SAPTableViewCell
@property (nonatomic, strong) IBOutlet SAPImageView *view;
@property (nonatomic, strong) IBOutlet UILabel      *label;

@property (nonatomic, strong) SAPUser  *user;

@end
