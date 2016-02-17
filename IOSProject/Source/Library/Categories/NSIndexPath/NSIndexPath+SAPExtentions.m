//
//  NSIndexPath+SAPExtentions.m
//  IOSProject
//
//  Created by S A P on 2/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "NSIndexPath+SAPExtentions.h"
#import <UIKit/UIKit.h>

@implementation NSIndexPath (SAPExtentions)

+ (instancetype)indexPathForRow:(NSUInteger)row {
    return [NSIndexPath indexPathForRow:row inSection:0];
}

@end
