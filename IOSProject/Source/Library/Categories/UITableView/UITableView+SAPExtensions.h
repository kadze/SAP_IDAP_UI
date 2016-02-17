//
//  UITableView+SAPExtensions.h
//  IOSProject
//
//  Created by S A P on 2/10/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (SAPExtensions)

- (id)cellWithClass:(Class)class;
- (void)updateWithBlock:(void(^)(UITableView *))block;

@end
