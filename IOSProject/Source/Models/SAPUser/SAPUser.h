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

@class SAPImageModel;

@interface SAPUser : NSObject <NSCoding>
@property (nonatomic, copy)     NSString        *name;
@property (nonatomic, readonly) SAPImageModel   *imageModel;

//method uses init chain!
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

@end
