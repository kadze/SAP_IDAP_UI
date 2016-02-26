//
//  UIViewController+FileSystem_SAPExtentions.m
//  IOSProject
//
//  Created by S A P on 2/23/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "NSFileManager+SAPExtensions.h"

NSString *SAPSearchPathForDirectory(NSSearchPathDirectory directory) {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}

NSString *SAPlibraryPath(void) {
    return SAPSearchPathForDirectory(NSLibraryDirectory);
}

NSString *SAPDocumentsPath(void) {
    return SAPSearchPathForDirectory(NSDocumentDirectory);
}

void SAPProvidePathExistence(NSString *path) {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path
               withIntermediateDirectories:NO
                                attributes:nil error:nil];
    }
}