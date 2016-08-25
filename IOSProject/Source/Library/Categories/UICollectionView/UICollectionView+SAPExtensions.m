//
//  UICollectionView+SAPExtensions.m
//  IOSProject
//
//  Created by Andrey on 8/15/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "UICollectionView+SAPExtensions.h"

#import "UINib+SAPExtensions.h"
#import "SAPTableViewCell.h"

@implementation UICollectionView (SAPExtensions)

- (id)cellWithClass:(Class)aClass {
    id cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(aClass)];
    if (!cell) {
        cell = [UINib objectWithClass:aClass];
    }
    
    return cell;
}

- (void)updateWithBlock:(void(^)(UITableView *))block {
    if (!block) {
        return;
    }
    
    [self beginUpdates];
    block(self);
    [self endUpdates];
}

@end
