//
//  UIWindow+SAPExtentions.m
//  IOSProject
//
//  Created by S A P on 1/29/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "UIWindow+SAPExtentions.h"

@implementation UIWindow (SAPExtentions)

#pragma mark -
#pragma mark Class Methods

+ (instancetype)initWithMainScreen {
    return [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

@end
