//
//  SAPUser.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SAPObservableObject.h"

@interface SAPUser : SAPObservableObject
@property (nonatomic, copy)     NSString  *name;
@property (nonatomic, readonly) UIImage   *image;

@end
