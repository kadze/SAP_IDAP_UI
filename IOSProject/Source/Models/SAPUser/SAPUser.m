//
//  SAPUser.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUser.h"

#import "SAPImageModel.h"

#import "NSString+IOPRandomName.h"

static NSString * const kSAPImageName = @"smile";
static NSString * const kSAPImageType = @"jpeg";

static NSString * const kSAPNameKey = @"name";

@interface SAPUser ()
@property (nonatomic, strong) UIImage   *image;

- (UIImage *)loadImage;

@end

@implementation SAPUser

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
    sleep(5);
    self.image = [self loadImage];
    @synchronized(self) {
        self.state = kSAPModelStateDidFinishLoading;
    }
}

#pragma mark -
#pragma mark Private

//- (UIImage *)loadImage {
//    NSString *path = [[NSBundle mainBundle] pathForResource:kSAPImageName ofType:kSAPImageType];
//    
//    return [UIImage imageWithContentsOfFile:path];
//}

- (UIImage *)loadImage {
    static NSString * const kSAPImageURL = @"https://coubsecure-a.akamaihd.net/get/b23/p/coub/simple/cw_timeline_pic/75aa6be5afc/3c49409c2f76f0e077a5a/med_1418748390_image.jpg";
    
    SAPImageModel *imageModel = [SAPImageModel imageWithUrl:[NSURL URLWithString:kSAPImageURL]];
    [imageModel load];
    return imageModel.image;
}

@end
