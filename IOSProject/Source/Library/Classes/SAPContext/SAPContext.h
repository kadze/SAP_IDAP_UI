//
//  SAPContext.h
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SAPModel.h"

@interface SAPContext : NSObject
@property (nonatomic, retain) SAPModel *model;

+ (instancetype)contextWithModel:(SAPModel *)model;

- (instancetype)initWithModel:(SAPModel *)model;

- (void)execute;
- (void)cancel;

@end
