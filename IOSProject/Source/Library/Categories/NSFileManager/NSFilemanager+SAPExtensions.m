//
//  UIViewController+FileSystem_SAPExtentions.m
//  IOSProject
//
//  Created by S A P on 2/23/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "NSFileManager+SAPExtensions.h"
#import "NSPathUtilities+SAPExtensions.h"

static NSString * const kSAPAppStateDirectoryName = @"appState";

@implementation NSFileManager (SAPExtensions)

+ (NSString *)libraryPath {
    return NSSearchPathForDirectory(NSLibraryDirectory);
}

+ (NSString *)documentsPath {
    return NSSearchPathForDirectory(NSDocumentDirectory);
}

+ (NSString *)appStatePath {
    static NSString *path = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        path = [[self libraryPath] stringByAppendingPathComponent:kSAPAppStateDirectoryName];
        
        NSFileManager *fileManager = [self defaultManager];
        if (![fileManager fileExistsAtPath:path]) {
            [fileManager createDirectoryAtPath:path
                   withIntermediateDirectories:YES
                                    attributes:nil
                                         error:nil];
        }
    });
    
    return path;
}

@end