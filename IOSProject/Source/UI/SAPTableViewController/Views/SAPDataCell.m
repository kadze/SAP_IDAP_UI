//
//  SAPDataCell.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPDataCell.h"

@implementation SAPDataCell

#pragma mark -
#pragma mark Accessors

- (void)setData:(SAPData *)data {
    if (_data != data) {
        _data = data;
        
        [self fillWithModel:data];
    }
}

#pragma mark -
#pragma mark Public

- (void)fillWithModel:(SAPData *)data {
//    self.dataStringLabel.text =
//    self.dataImageView.image =
}
@end
