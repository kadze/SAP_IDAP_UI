//
//  UIViewController+FileSystem_SAPExtentions.h
//  IOSProject
//
//  Created by S A P on 2/23/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSFileManager (SAPExtensions)

@end
extern
NSString *SAPSearchPathForDirectory(NSSearchPathDirectory directory);

extern
NSString *SAPlibraryPath(void);

extern
NSString *SAPDocumentsPath(void);

extern
void SAPProvidePathExistence(NSString *path);
