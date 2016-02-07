//
//  SAPData.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPData.h"

#import "NSString+SAPStringExtentions.h"

static NSUInteger const kSAPRandomWordSize  = 10;
static NSUInteger const kSAPArraySize       = 100;

@interface SAPData ()
@property (nonatomic, strong) NSMutableArray *mutableStrings;

@end

@implementation SAPData

@dynamic mutableStrings;

#pragma mark - 
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.mutableStrings = [[NSMutableArray alloc] initWithCapacity:kSAPArraySize];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)strings {
    return [self.mutableStrings copy];
}

#pragma mark -
#pragma mark Public

- (void)fillWithRandomStrings {
    NSMutableArray *mutableStrings = self.mutableStrings;
    for (NSUInteger index = 0; index < kSAPArraySize; index++) {
        [mutableStrings addObject:[self randomString]];
    }
}

#pragma mark -
#pragma mark Private

- (NSString *)randomString {
    return [NSString generateRandomStringWithAlphabetString:[NSString lowerCaseLetterAlphabet] ofSize:kSAPRandomWordSize];
}

@end
