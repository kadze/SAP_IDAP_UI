//
//  SAPUsers.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SAPArrayModel.h"

@class SAPUser;

@interface SAPUsers : SAPArrayModel <NSCoding>

- (void)save;
- (NSArray *)load;

@end
