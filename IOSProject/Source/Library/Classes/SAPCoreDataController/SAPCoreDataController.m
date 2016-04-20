//
//  SAPCoreDataController.m
//  IOSProject
//
//  Created by Andrey on 4/19/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPCoreDataController.h"

#import <CoreData/CoreData.h>

#import "UIAlertView+SAPExtensions.h"

static NSString * const kSAPMomResource = @"IOSProject";
static NSString * const kSAPMomExtension = @"momd";
static NSString * const kSAPErrorLocalizedDescription = @"Error initializing Managed Object Model";
static NSString * const kSAPDatabaseFileName = @"Users.sqlite";

@implementation SAPCoreDataController

#pragma mark - 
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    
    [self initializeCoreData];
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)initializeCoreData {
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kSAPMomResource withExtension:kSAPMomExtension];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    if (!mom) {
        [UIAlertView showWithError:[NSError errorWithDomain:NSCocoaErrorDomain
                                                      code:0
                                                  userInfo:@{NSLocalizedDescriptionKey : kSAPErrorLocalizedDescription}]];
    }
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator =
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    
    NSManagedObjectContext *managedObjectContext =
    [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator;
    
    self.managedObjectContext = managedObjectContext;
    
    NSURL *libraryURL = [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory
                                                               inDomains:NSUserDomainMask] lastObject];
    
    NSURL *storeURL = [libraryURL URLByAppendingPathComponent:kSAPDatabaseFileName];
    
    NSError *error = nil;
    
    [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                             configuration:nil
                                                       URL:storeURL
                                                   options:nil
                                                     error:&error];
    if (error) {
        [UIAlertView showWithError:error];
    }
}

@end
