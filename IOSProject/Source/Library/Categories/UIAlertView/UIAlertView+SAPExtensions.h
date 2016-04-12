//
//  UIAlertView+SAPExtensions.h
//  IOSProject
//
//  Created by SAP on 4/1/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (SAPExtensions)

+ (void)showWithError:(NSError *)error;

@end
