//
//  SAPStringAdditions.m
//  MacCourse
//
//  Created by S A P on 11/24/15.
//  Copyright © 2015 Yosemite Retail. All rights reserved.
//

#import "NSString+SAPStringExtentions.h"

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
+ (NSString *)generateRandomStringWithAlphabetString:(NSString *)alphabet ofSize:(NSUInteger)size {
    int alphabetLength = (int)alphabet.length;
    unichar unichars[size];
    for (uint index = 0; index < size; index++) {
        unichars[index] = [alphabet characterAtIndex:arc4random_uniform(alphabetLength)];
    }
    
    return [self stringWithCharacters:unichars length:size];
}

#pragma mark -
#pragma mark Public Methods

- (NSString *)generateRandomStringFromSelfOfSize:(NSUInteger)size {
    return [[self class] generateRandomStringWithAlphabetString:self ofSize:size];
}

@end
