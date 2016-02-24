//
//  UIViewController+FileSystem_SAPExtentions.m
//  IOSProject
//
//  Created by S A P on 2/23/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "NSFileManager+SAPExtentions.h"

static NSString * const kSAPAppStateDirectoryName = @"appState";

NSString *SAPSearchPathForDirectory(NSSearchPathDirectory directory) {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}

NSString *SAPPathForLibraryDirectory(void) {
    return SAPSearchPathForDirectory(NSLibraryDirectory);
}

NSString *SAPPathForDocumentsDirectory(void) {
    return SAPSearchPathForDirectory(NSDocumentDirectory);
}

NSString *SAPPathForAppStateDirectory(void) {
    return [SAPPathForLibraryDirectory() stringByAppendingPathComponent:kSAPAppStateDirectoryName];
}