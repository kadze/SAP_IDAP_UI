//
//  SAPDBImage+CoreDataProperties.h
//  IOSProject
//
//  Created by Andrey on 4/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SAPDBImage.h"

@interface SAPDBImage (CoreDataProperties)
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, strong) NSSet    *user;

@end

@interface SAPDBImage (CoreDataGeneratedAccessors)

- (void)addUserObject:(SAPDBUser *)value;
- (void)removeUserObject:(SAPDBUser *)value;
- (void)addUser:(NSSet *)values;
- (void)removeUser:(NSSet *)values;

@end
