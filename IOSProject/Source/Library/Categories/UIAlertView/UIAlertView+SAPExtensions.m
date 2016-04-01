//
//  UIAlertView+SAPExtensions.m
//  IOSProject
//
//  Created by SAP on 4/1/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "UIAlertView+SAPExtensions.h"

static NSString * const kSAPCancelButtonTitle = @"OK";

@implementation UIAlertView (SAPExtensions)

+ (instancetype)alertWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                    message:[error localizedRecoverySuggestion]
                                                   delegate:nil
                                          cancelButtonTitle:kSAPCancelButtonTitle
                                          otherButtonTitles:nil];
    [alert show];
    
    return alert;
}

@end
