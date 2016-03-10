//
//  SAPImageModel.m
//  IOSProject
//
//  Created by S A P on 3/3/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPImageModel.h"

#import "NSFileManager+SAPExtensions.h"
#import "NSURL+SAPExtensions.h"

#import "SAPOwnershipMacro.h"

@interface SAPImageModel ()
@property (nonatomic, strong) UIImage      *image;
@property (nonatomic, strong) NSURL        *url;

@property (nonatomic, readonly) NSURLSession   *session;

- (void)loadFromWeb;
- (void)loadFromDisk;

@end

@implementation SAPImageModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)imageWithUrl:(NSURL *)url {
    return [[self alloc] initWithUrl:url];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        self.url = url;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSURLSession *)session {
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    
    return session;
}

#pragma mark -
#pragma mark SAPCacheableModel

- (BOOL)cached {
    return [[NSFileManager defaultManager] fileExistsAtPath:self.path];
}

- (NSString *)path {
    return [[NSFileManager appStatePath] stringByAppendingPathComponent:[self.url fileSystemStringRepresentation]];
}

#pragma mark -
#pragma mark Public

- (void)performBackgroundLoading {
    if (!self.cached) {
        [self loadFromWeb];
    } else {
        [self loadFromDisk];
    }
}

#pragma mark -
#pragma mark Private

- (void)loadFromWeb {
    SAPWeakify(self);
    id taskCompletion = ^(NSURL * location, NSURLResponse * response, NSError * error) {
        if (error) {
            @synchronized(self) {
                SAPStrongify(self);
                self.state = kSAPModelStateDidFailLoading;
            }
        } else {
            SAPStrongify(self);
            [[NSFileManager defaultManager] moveItemAtURL:location
                                                    toURL:[NSURL fileURLWithPath:self.path]
                                                    error:nil];
            [self loadFromDisk];
        }
    };

    NSURLSessionDownloadTask *task = [self.session downloadTaskWithURL:self.url
                                                completionHandler:taskCompletion];
    [task resume];
}

- (void)loadFromDisk {
    //sleep(2);
    NSString *path = self.path;
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    if (image) {
        self.image = image;
        
        @synchronized(self) {
            self.state = kSAPModelStateDidFinishLoading;
        }
    } else {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        [self loadFromWeb];
        
        @synchronized(self) {
            self.state = kSAPModelStateDidFailLoading;
        }
    }
}

@end
