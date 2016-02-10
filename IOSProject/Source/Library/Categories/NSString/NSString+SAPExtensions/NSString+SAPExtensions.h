//
//  SAPStringAdditions.h
//  MacCourse
//
//  Created by S A P on 11/24/15.
//  Copyright © 2015 Yosemite Retail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SAPExtentions)

+ (NSString *)alphanumericAlphabet;
+ (NSString *)numericAlphabet;
+ (NSString *)letterAlphabet;
+ (NSString *)lowerCaseLetterAlphabet;
+ (NSString *)capitalizedCaseLetterAlphabet;
+ (NSString *)alphabetWithUnicodeRange:(NSRange)range;

+ (NSString *)randomStringWithAlphabetString:(NSString *)alphabet length:(NSUInteger)length;

- (NSString *)randomStringFromSelfOfLength:(NSUInteger)length;

@end
