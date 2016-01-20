//
//  UIViewController+FileSystem_SAPExtentions.h
//  IOSProject
//
//  Created by S A P on 2/23/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSFileManager (SAPExtensions)

+ (NSString *)searchPathForDirectory:(NSSearchPathDirectory)directory;
+ (NSString *)libraryPath;
+ (NSString *)documentsPath;
+ (NSString *)appStatePath;

@end

