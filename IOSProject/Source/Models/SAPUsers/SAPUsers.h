//
//  SAPUsers.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPArrayModel.h"

#import <CoreData/NSFetchedResultsController.h>

#import "SAPCacheableModel.h"

@interface SAPUsers : SAPArrayModel <SAPCacheableModel, NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

- (instancetype)initWithFetchedResultsControllerForContext:(NSManagedObjectContext *)context
                                                    entity:(NSEntityDescription *)entity;

@end
