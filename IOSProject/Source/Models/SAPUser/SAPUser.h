//
//  SAPUser.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SAPModel.h"

@interface SAPUser : SAPModel <NSCoding>
@property (nonatomic, copy)     NSString  *name;
@property (nonatomic, readonly) UIImage   *image;

//warning! initWithCoder uses [super init]. People who create their own drama, deserve their own karma.

@end
