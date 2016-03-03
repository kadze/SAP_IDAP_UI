//
//  SAPImageModel.h
//  IOSProject
//
//  Created by S A P on 3/3/16.
//  Copyright © 2016 SAP. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "SAPModel.h"

@interface SAPImageModel : SAPModel
@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) NSURL   *url;
@property (nonatomic, readonly) BOOL    imageLoaded;

+ (instancetype)imageWithUrl:(NSURL *)url;

- (instancetype)initWithUrl:(NSURL *)url;

- (void)dump;

@end
