//
//  SAPDataCell.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPTableViewCell.h"

@class SAPUser;
@class SAPImageView;

@interface SAPUserCell : SAPTableViewCell
@property (nonatomic, strong) IBOutlet UILabel      *label;
@property (nonatomic, strong) IBOutlet SAPImageView *userImageView;

@property (nonatomic, strong) SAPUser  *user;

@end
