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

@property (nonatomic, strong) NSURLSession              *session;
@property (nonatomic, strong) NSURLSessionConfiguration *configuration;

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
    static NSURLSession *session = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [NSURLSession sessionWithConfiguration:self.configuration];
    });
    
    return session;
}

#pragma mark -
#pragma mark SAPCacheableModel

- (BOOL)cached {
    return [[NSFileManager defaultManager] fileExistsAtPath:self.path];
}

- (NSString *)path {
    return [[NSFileManager appStatePath] stringByAppendingPathComponent:[self.url convertIntoFilename]];
}

- (void)save {
    
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
    self.configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    SAPWeakify(self);
    void (^taskCompletion) (NSURL * location, NSURLResponse * response, NSError * error) = ^void(NSURL * location, NSURLResponse * response, NSError * error) {
        NSFileManager *manager = [NSFileManager defaultManager];
        SAPStrongify(self);
        [manager moveItemAtURL:location
                         toURL:[NSURL fileURLWithPath:self.path]
                         error:nil];
        self.image = [UIImage imageWithContentsOfFile:self.path];
        
        @synchronized(self) {
            self.state = kSAPModelStateDidFinishLoading;
        }
    };
    
    NSURLSessionDownloadTask *task = [self.session downloadTaskWithURL:self.url
                                                completionHandler:taskCompletion];
    [task resume];
}

- (void)loadFromDisk {
    sleep(2);
    self.image = [UIImage imageWithContentsOfFile:self.path];
    @synchronized(self) {
        self.state = kSAPModelStateDidFinishLoading;
    }
}

@end
