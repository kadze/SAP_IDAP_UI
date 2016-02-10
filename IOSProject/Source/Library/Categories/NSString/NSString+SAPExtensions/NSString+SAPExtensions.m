//
//  SAPStringAdditions.m
//  MacCourse
//
//  Created by S A P on 11/24/15.
//  Copyright © 2015 Yosemite Retail. All rights reserved.
//

#import "NSString+SAPExtensions.h"

static const unichar kSAPFirstLowerCaseLetter = 'a';
static const unichar kSAPLastLowerCaseLetter = 'z';
static const unichar kSAPFirstCapitalLetter = 'A';
static const unichar kSAPLastCapitalLetter = 'Z';
static const unichar kSAPFirstNumberSign = '0';
static const unichar kSAPLastNumberSign = '9';

@implementation NSString (SAPStringExtentions)

#pragma mark -
#pragma mark Class Methods

//alphabets
+ (NSString *)alphanumericAlphabet {
    NSMutableString *result = [NSMutableString stringWithString:[self numericAlphabet]];
    [result appendString:[self letterAlphabet]];
    
    return [self stringWithString:result];
}

+ (NSString *)numericAlphabet {
    return [self alphabetWithUnicodeRange:NSMakeRange(kSAPFirstNumberSign,
                                                      kSAPLastNumberSign - kSAPFirstNumberSign)];
}

+ (NSString *)letterAlphabet {
    NSMutableString *result = [NSMutableString stringWithString:[self lowerCaseLetterAlphabet]];
    [result appendString:[self capitalizedCaseLetterAlphabet]];
    
    return [self stringWithString:result];
}

+ (NSString *)lowerCaseLetterAlphabet {
    return [self alphabetWithUnicodeRange:NSMakeRange(kSAPFirstLowerCaseLetter,
                                                      kSAPLastLowerCaseLetter - kSAPFirstLowerCaseLetter)];
}

+ (NSString *)capitalizedCaseLetterAlphabet {
    return [self alphabetWithUnicodeRange:NSMakeRange(kSAPFirstCapitalLetter,
                                                      kSAPLastCapitalLetter - kSAPFirstCapitalLetter)];
}

+ (NSString *)alphabetWithUnicodeRange:(NSRange)range {
    NSMutableString *result = [NSMutableString string];
    for (unichar symbol = range.location; symbol <= NSMaxRange(range); symbol++) {
        [result appendFormat:@"%c", symbol];
    }
    
    return [self stringWithString:result];
}

//random strings
+ (NSString *)randomStringWithAlphabetString:(NSString *)alphabet length:(NSUInteger)length {
    int alphabetLength = (int)alphabet.length;
    unichar unichars[length];
    for (uint index = 0; index < length; index++) {
        unichars[index] = [alphabet characterAtIndex:arc4random_uniform(alphabetLength)];
    }
    
    return [self stringWithCharacters:unichars length:length];
}

#pragma mark -
#pragma mark Public Methods

- (NSString *)generateRandomStringFromSelfOfLength:(NSUInteger)length {
    return [[self class] randomStringWithAlphabetString:self length:length];
}

@end
