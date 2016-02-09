//
//  NSString+SAPRandomName.m
//  IOSProject
//
//  Created by S A P on 2/9/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "NSString+SAPRandomName.h"

#import "NSString+SAPExtentions.h"

static NSUInteger const kSAPRandomNameSize = 10;

@implementation NSString (SAPRandomName)

+ (NSString *)randomName {
    return [NSString randomStringWithAlphabetString:[NSString lowerCaseLetterAlphabet] length:kSAPRandomNameSize];
}

@end
