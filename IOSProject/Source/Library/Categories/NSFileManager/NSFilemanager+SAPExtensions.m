//
//  UIViewController+FileSystem_SAPExtentions.m
//  IOSProject
//
//  Created by S A P on 2/23/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "NSFileManager+SAPExtensions.h"

static NSString * const kSAPAppStateDirectoryName = @"appState";

@implementation NSFileManager (SAPExtensions)

+ (NSString *)searchPathForDirectory:(NSSearchPathDirectory)directory {
    return [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)libraryPath {
    return [self searchPathForDirectory:NSLibraryDirectory];
}

+ (NSString *)documentsPath {
    return [self searchPathForDirectory:NSDocumentDirectory];
}

+ (NSString *)appStatePath {
    return [[self libraryPath] stringByAppendingPathComponent:kSAPAppStateDirectoryName];
}

@end