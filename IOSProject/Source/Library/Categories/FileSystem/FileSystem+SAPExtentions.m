//
//  UIViewController+FileSystem_SAPExtentions.m
//  IOSProject
//
//  Created by S A P on 2/23/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "FileSystem+SAPExtentions.h"

NSString *SAPSearchPath(void) {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}