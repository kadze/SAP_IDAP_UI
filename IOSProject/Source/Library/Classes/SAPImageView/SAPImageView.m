//
//  SAPImageView.m
//  IOSProject
//
//  Created by S A P on 3/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPImageView.h"

#import "SAPDispatch.h"

@interface SAPImageView ()
@property (nonatomic, strong) UIImageView *imageView;

- (void)fillWithModel:(SAPImageModel *)imageModel;
- (void)prepareImageSubview;

@end

@implementation SAPImageView

#pragma mark -
#pragma mark NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self prepareImageSubview];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self prepareImageSubview];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setImageModel:(SAPImageModel *)imageModel {
    if (_imageModel != imageModel) {
        [self fillWithModel:nil];
        [_imageModel removeObserver:self];
        _imageModel = imageModel;
        [_imageModel addObserver:self];
        [_imageModel load];
    }
}

#pragma mark -
#pragma mark SAPModelObserver

- (void)modelWillLoad:(id)model {
    SAPDispatchAsyncOnMainQueue(^{
        [self setLoadingViewVisible:YES animated:YES];
    });
}

- (void)modelDidFinishLoading:(id)model {
    SAPDispatchAsyncOnMainQueue(^{
        [self fillWithModel:model];
        [self setLoadingViewVisible:NO];
    });
}

- (void)modelDidFailLoading:(id)model {
    [self setLoadingViewVisible:NO];
}

#pragma mark -
#pragma mark Private

- (void)fillWithModel:(SAPImageModel *)model {
    self.imageView.image = model.image;
}

- (void)prepareImageSubview {
    UIImageView *subview = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imageView = subview;
    [self addSubview:subview];
    subview.autoresizingMask = UIViewAutoresizingFlexibleWidth
                                      | UIViewAutoresizingFlexibleHeight;
}

@end
