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

- (void)fillWithModel:(SAPImageModel *)model;

@end

@implementation SAPImageView

#pragma mark -
#pragma mark NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.imageView];
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth
                                      | UIViewAutoresizingFlexibleHeight;

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.imageView];
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth
                                      | UIViewAutoresizingFlexibleHeight;
    
    return self;
}


#pragma mark -
#pragma mark Accessors

- (void)setModel:(SAPImageModel *)model {
    if (_model != model) {
        [_model removeObserver:self];
        
        _model = model;
        
        [_model addObserver:self];
        
        [_model load];
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

- (void)modelDidUnload:(id)model {
    [self setLoadingViewVisible:NO];
}

#pragma mark -
#pragma mark Private

- (void)fillWithModel:(SAPImageModel *)model {
    self.imageView.image = model.image;
}

@end
