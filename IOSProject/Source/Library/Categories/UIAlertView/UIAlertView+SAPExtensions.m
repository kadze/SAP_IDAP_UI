//
//  UIAlertView+SAPExtensions.m
//  IOSProject
//
//  Created by SAP on 4/1/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "UIAlertView+SAPExtensions.h"

static NSString * const kSAPCancelButtonTitle = @"OK";
static NSString * const kSAPErrorTitle        = @"Error!";

@implementation UIAlertView (SAPExtensions)

+ (void)showWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kSAPErrorTitle
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:kSAPCancelButtonTitle
                                          otherButtonTitles:nil];
    [alert show];
}

@end
