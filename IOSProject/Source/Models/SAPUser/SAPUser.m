//
//  SAPUser.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUser.h"

#import "NSString+IOPRandomName.h"

static NSString * const kSAPNameKey = @"name";

//static NSString * const kSAPImageURL = @"https://coubsecure-a.akamaihd.net/get/b23/p/coub/simple/cw_timeline_pic/75aa6be5afc/3c49409c2f76f0e077a5a/med_1418748390_image.jpg";
static NSString * const kSAPImageURL = @"http://weknowyourdreamz.com/images/smile/smile-08.jpg";

@interface SAPUser ()
@property (nonatomic, strong) SAPImageModel  *image;

@end

@implementation SAPUser

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.name = [NSString randomName];
        self.image = [SAPImageModel imageWithUrl:[NSURL URLWithString:kSAPImageURL]];
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
    self.image = [SAPImageModel imageWithUrl:[NSURL URLWithString:kSAPImageURL]];
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)performBackgroundLoading {
//    sleep(5);
    [self.image load];
    @synchronized(self) {
        self.state = kSAPModelStateDidFinishLoading;
    }
}

@end
