//
//  SAPUser.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUser.h"

#import "NSString+IOPRandomName.h"

static NSString * const kSAPImageName = @"smile";
static NSString * const kSAPImageType = @"jpeg";

static NSString * const kSAPNameKey = @"name";

@interface SAPUser ()
@property (nonatomic, strong) UIImage   *image;

- (UIImage *)loadImage;
- (void)cleanupAfterProcessing;

@end

@implementation SAPUser

//@dynamic image;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.name = [NSString randomName];
    }
    
    return self;
}

#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:kSAPNameKey];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init]; //mutable observers collection initialization
    self.name = [aDecoder decodeObjectForKey:kSAPNameKey];
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)performBackgroundLoading {
    self.image = [self loadImage];
    
    sleep(1);
    
    [self cleanupAfterProcessing];
}

#pragma mark -
#pragma mark Private

- (UIImage *)loadImage {
    static UIImage *__image = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:kSAPImageName ofType:kSAPImageType];
        __image = [UIImage imageWithContentsOfFile:path];
    });
    
    return __image;
}

- (void)cleanupAfterProcessing {
    @synchronized(self) {
        self.state = kSAPModelStateDidFinishLoading;
    }
}

@end
