//
//  SAPDataElement.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPDataElement.h"
#import "NSString+SAPStringExtentions.h"

static NSUInteger const kSAPRandomWordSize  = 10;

@implementation SAPDataElement

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.randomString = [self generateRandomString];
    }
    
    return self;
}

#pragma mark -
#pragma mark Private

- (NSString *)generateRandomString {
    return [NSString generateRandomStringWithAlphabetString:[NSString lowerCaseLetterAlphabet] ofSize:kSAPRandomWordSize];
}

@end
