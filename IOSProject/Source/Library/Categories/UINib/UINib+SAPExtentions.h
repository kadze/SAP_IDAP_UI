//
//  UINib+SAPExtentions.h
//  IOSProject
//
//  Created by S A P on 2/9/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINib (SAPExtentions)

+ (UINib *)nibWithClass:(Class)aClass;
+ (UINib *)nibWithClass:(Class)aClass bundle:(NSBundle *)bundle;

- (id)getObjectOfClass:(Class)aClass;

@end
