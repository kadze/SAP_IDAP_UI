//
//  SAPCollectionViewCell.m
//  Study training
//
//  Created by Andrey on 8/15/16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "SAPCollectionViewCell.h"

@implementation SAPCollectionViewCell

#pragma mark-
#pragma mark Accessors

- (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
