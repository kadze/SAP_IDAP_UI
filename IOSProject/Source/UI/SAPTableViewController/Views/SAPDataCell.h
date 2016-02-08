//
//  SAPDataCell.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPTableViewCell.h"

@class SAPDataElement;

@interface SAPDataCell : SAPTableViewCell
@property (nonatomic, strong) IBOutlet UILabel      *dataStringLabel;
@property (nonatomic, strong) IBOutlet UIImageView  *dataImageView;

@property (nonatomic, strong) SAPDataElement  *data;

- (void)fillWithModel:(SAPDataElement *)data;

@end
