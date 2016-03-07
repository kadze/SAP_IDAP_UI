//
//  SAPImageModel.h
//  IOSProject
//
//  Created by S A P on 3/3/16.
//  Copyright © 2016 SAP. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "SAPCacheableModel.h"

@interface SAPImageModel : SAPModel
@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) NSURL   *url;

+ (instancetype)imageWithUrl:(NSURL *)url;

- (instancetype)initWithUrl:(NSURL *)url;

@end
