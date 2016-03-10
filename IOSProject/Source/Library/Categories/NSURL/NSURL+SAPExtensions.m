//
//  NSURL+SAPExtensions.m
//  IOSProject
//
//  Created by S A P on 3/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "NSURL+SAPExtensions.h"

#import "SAPClangMacro.h"

static NSString * const kSAPQuestionMark = @"?";
static NSString * const kSAPQuestionMarkSubstitute = @"SAPQuestionMark";
static NSString * const kSAPSlash = @"/";
static NSString * const kSAPSlashSubstitute = @"SAPSlash";

@implementation NSURL (SAPExtensions)

- (NSString *)fileSystemStringRepresentation {
    NSString *result = [self absoluteString];
    result = [result stringByReplacingOccurrencesOfString:kSAPQuestionMark withString:kSAPQuestionMarkSubstitute];
   
    return [result stringByReplacingOccurrencesOfString:kSAPSlash withString:kSAPSlashSubstitute];
}

@end
