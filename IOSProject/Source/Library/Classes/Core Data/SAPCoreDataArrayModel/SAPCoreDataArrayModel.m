//
//  SAPCoreDataArrayModel.m
//  IOSProject
//
//  Created by Andrey on 4/25/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPCoreDataArrayModel.h"

#import <CoreData/NSEntityDescription.h>

@implementation SAPCoreDataArrayModel

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithFetchedResultsControllerForContext:(NSManagedObjectContext *)context
                                                    entity:(NSEntityDescription *)entity
{
    self = [super init];
    NSFetchRequest *fetchedRequest = [NSFetchRequest fetchRequestWithEntityName:entity.managedObjectClassName];
    fetchedRequest.sortDescriptors = [self fetchedResultsControllerSortDescriptors];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchedRequest
                                                                        managedObjectContext:context
                                                                          sectionNameKeyPath:nil cacheName:nil];;
    
    return self;
}

#pragma mark -
#pragma mark NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(nullable NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(nullable NSIndexPath *)newIndexPath
{
    if (NSFetchedResultsChangeInsert == type) {
        [self performBlockWithoutNotification:^{
            [self addObject:anObject];
        }];
    }
}

#pragma mark -
#pragma mark Public

- (NSArray *)fetchedResultsControllerSortDescriptors {
    return nil;
}

@end
