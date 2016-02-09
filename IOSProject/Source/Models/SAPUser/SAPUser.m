//
//  SAPUser.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUser.h"

#import "NSString+SAPStringExtentions.h"

static NSUInteger const kSAPRandomWordSize  = 10;

static NSString * const kSAPImageName = @"smile";
static NSString * const kSAPImageType = @"jpeg";

@implementation SAPUser

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.name = [self generateRandomString];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (UIImage *)image {
    NSString *path = [[NSBundle mainBundle] pathForResource:kSAPImageName ofType:kSAPImageType];
    
    return [UIImage imageWithContentsOfFile:path];
}

#pragma mark -
#pragma mark Private

- (NSString *)generateRandomString {
    return [NSString generateRandomStringWithAlphabetString:[NSString lowerCaseLetterAlphabet] ofSize:kSAPRandomWordSize];
}

@end
