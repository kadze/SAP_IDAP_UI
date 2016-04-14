//
//  SAPUser.h
//  IOSProject
//
//  Created by SAP on 3/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPModel.h"

#import "SAPCacheableModel.h"

@class SAPImageModel;
@class SAPUsers;

@interface SAPUser : SAPModel <NSCoding, SAPCacheableModel>
@property (nonatomic, copy)     NSString         *userId;
@property (nonatomic, copy)     NSString         *firstName;
@property (nonatomic, copy)     NSString         *lastName;
@property (nonatomic, copy)     NSString         *gender;

@property (nonatomic, readonly) SAPImageModel    *smallImageModel;
@property (nonatomic, copy)     NSURL            *smallImageURL;

@property (nonatomic, readonly) SAPImageModel    *largeImageModel;
@property (nonatomic, copy)     NSURL            *largeImageURL;

@property (nonatomic, readonly) SAPUsers         *friends;

//method uses init chain!
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

@end
