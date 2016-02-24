//
//  UIViewController+FileSystem_SAPExtentions.h
//  IOSProject
//
//  Created by S A P on 2/23/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

extern
NSString *SAPSearchPathForDirectory(NSSearchPathDirectory directory);

extern
NSString *SAPPathForLibraryDirectory(void);

extern
NSString *SAPPathForDocumentsDirectory(void);

extern
NSString *SAPPathForAppStateDirectory(void);