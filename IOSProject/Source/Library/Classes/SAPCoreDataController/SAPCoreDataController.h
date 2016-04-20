//
//  SAPCoreDataController.h
//  IOSProject
//
//  Created by Andrey on 4/19/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObjectContext;

@interface SAPCoreDataController : NSObject
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (void)initializeCoreData;

@end
