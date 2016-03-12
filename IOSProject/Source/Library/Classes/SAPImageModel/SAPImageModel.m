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
@property (nonatomic, strong) UIImage           *image;
@property (nonatomic, strong) NSURL             *url;
@property (nonatomic, strong) NSURLSessionTask  *task;
@property (nonatomic, readonly) NSURLSession    *session;
@property (nonatomic, readonly) NSURLRequest    *request;

- (void)loadFromWeb;
- (void)startDownloading:(NSURLRequest *)request;
- (void)loadFromDisk;
- (id)taskCompletion;
- (void)setAtomicState:(NSUInteger)state;
- (void)setImageWithNotification:(UIImage *)image;

@end

@implementation SAPImageModel

@dynamic request;

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

- (void)dealloc {
    self.task = nil;
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

- (void)setTask:(NSURLSessionTask *)task {
    if (_task != task) {
        [_task cancel];
        
        _task = task;
    }
}

- (NSURLRequest *)request {
    return [NSURLRequest requestWithURL:self.url];
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
    [self startDownloading:self.request];
}

- (void)startDownloading:(NSURLRequest *)request {
    [[NSFileManager defaultManager] removeItemAtPath:self.path error:nil];
    
    NSURLSessionDownloadTask *task = [self.session downloadTaskWithRequest:self.request
                                                     completionHandler:[self taskCompletion]];
    self.task = task;
    [task resume];
}

- (void)loadFromDisk {
    //sleep(2);
    UIImage *image = [UIImage imageWithContentsOfFile:self.path];
    if (image) {
        [self setImageWithNotification:image];
    } else {
        [self loadFromWeb];
    }
}

- (id)taskCompletion {
    SAPWeakify(self);
    
    return ^(NSURL * location, NSURLResponse * response, NSError * error) {
        SAPStrongifyAndReturnIfNil(self);
        if (error) {
            [self setAtomicState:kSAPModelStateDidFailLoading];
            
            return;
        }
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        if (image) {
            [[NSFileManager defaultManager] moveItemAtURL:location
                                                    toURL:[NSURL fileURLWithPath:self.path]
                                                    error:nil];
        }
        
        [self setImageWithNotification:image];
    };
}

- (void)setAtomicState:(NSUInteger)state {
    @synchronized(self) {
        self.state = state;
    }
}

- (void)setImageWithNotification:(UIImage *)image {
    self.image = image;
    [self setAtomicState:image ? kSAPModelStateDidFinishLoading : kSAPModelStateDidFailLoading];
}

@end
