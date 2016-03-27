//
//  SAPDataCell.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPTableViewCell.h"
#import "SAPModelKeeper.h"
#import "SAPUser.h"

@class SAPImageView;

@interface SAPUserCell : SAPTableViewCell <SAPModelKeeper>
@property (nonatomic, strong) IBOutlet UILabel      *label;
@property (nonatomic, strong) IBOutlet SAPImageView *userImageView;

@property (nonatomic, strong) SAPUser  *model;

@end
