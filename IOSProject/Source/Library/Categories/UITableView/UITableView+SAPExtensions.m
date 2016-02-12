//
//  UITableView+SAPExtensions.m
//  IOSProject
//
//  Created by S A P on 2/10/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "UITableView+SAPExtensions.h"

#import "UINib+SAPExtensions.h"
#import "SAPTableViewCell.h"

@implementation UITableView (SAPExtensions)

- (id)cellWithClass:(Class)class {
    id cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(class)];
    if (!cell) {
        cell = [UINib objectWithClass:class];
    }
    
    return cell;
}

@end
