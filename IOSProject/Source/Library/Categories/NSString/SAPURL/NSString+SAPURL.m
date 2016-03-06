//
//  NSString+SAPURL.m
//  IOSProject
//
//  Created by S A P on 3/6/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "NSString+SAPURL.h"

static NSString * const kSAPQuestionMark = @"?";
static NSString * const kSAPQuestionMarkSubstitute = @"SAPQuestionMark";
static NSString * const kSAPSlash = @"/";
static NSString * const kSAPSlashSubstitute = @"SAPSlash";

@implementation NSString (SAPURL)

+ (NSString *)fileNameFromURL:(NSURL *)url {
    NSString *result = [url absoluteString];
    result = [result stringByReplacingOccurrencesOfString:kSAPQuestionMark withString:kSAPQuestionMarkSubstitute];
    result = [result stringByReplacingOccurrencesOfString:kSAPSlash withString:kSAPSlashSubstitute];
    
    return result;
}

+ (NSURL *)urlFromFileName:(NSString *)fileName {
    NSString *convertedFilename = [fileName stringByReplacingOccurrencesOfString:kSAPQuestionMarkSubstitute withString:kSAPQuestionMark];
    convertedFilename = [fileName stringByReplacingOccurrencesOfString:kSAPSlashSubstitute withString:kSAPSlash];
    
    return [NSURL URLWithString:convertedFilename];
}

@end
