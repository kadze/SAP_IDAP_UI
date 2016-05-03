//
//  SAPUserPhoto.h
//  IOSProject
//
//  Created by Andrey on 5/3/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface SAPUserPhoto : NSManagedObject
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSArray  *photos;

@end

