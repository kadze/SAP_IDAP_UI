//
//  SAPManagedObject.h
//  IOSProject
//
//  Created by Andrey on 4/19/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface SAPManagedObject : NSManagedObject

- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;

@end
