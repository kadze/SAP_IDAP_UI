//
//  SAPDataCell.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPDataCell.h"
#import "SAPDataElement.h"

@implementation SAPDataCell

#pragma mark -
#pragma mark Accessors

- (void)setData:(SAPDataElement *)data {
    if (_data != data) {
        _data = data;
        
        [self fillWithModel:data];
    }
}

#pragma mark -
#pragma mark Public

- (void)fillWithModel:(SAPDataElement *)data {
    self.dataStringLabel.text = data.randomString;
//    self.dataImageView.image =
}
@end
