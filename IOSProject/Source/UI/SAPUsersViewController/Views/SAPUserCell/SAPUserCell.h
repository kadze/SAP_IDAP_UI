//
//  SAPDataCell.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPTableViewCell.h"

#import "SAPUser.h"

#import "SAPModelOwner.h"

@class SAPImageView;

@interface SAPUserCell : SAPTableViewCell <SAPModelOwner>
@property (nonatomic, strong) IBOutlet UILabel      *label;
@property (nonatomic, strong) IBOutlet SAPImageView *userImageView;

@end
