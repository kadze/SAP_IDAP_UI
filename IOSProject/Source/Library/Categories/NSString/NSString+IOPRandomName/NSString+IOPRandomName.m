//
//  NSString+SAPRandomName.m
//  IOSProject
//
//  Created by S A P on 2/9/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "NSString+IOPRandomName.h"

#import "NSString+SAPextensions.h"

static NSUInteger const kSAPRandomNameSize = 10;

@implementation NSString (IOPRandomName)

+ (NSString *)randomName {
    return [NSString randomStringWithAlphabetString:[NSString lowerCaseLetterAlphabet]
                                             length:kSAPRandomNameSize].capitalizedString;
}

@end
