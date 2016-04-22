//
//  SAPData.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPUsers.h"

#import "SAPUser.h"

static NSString * const kSAPDescriptorKey = @"firstName";

@implementation SAPUsers

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithFetchedResultsControllerForContext:(NSManagedObjectContext *)context
                                            entity:(NSEntityDescription *)entity
{
    self = [super init];
    NSFetchRequest *fetchedRequest = [NSFetchRequest fetchRequestWithEntityName:entity.managedObjectClassName];
    fetchedRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:kSAPDescriptorKey ascending:YES]];
    
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

@end
