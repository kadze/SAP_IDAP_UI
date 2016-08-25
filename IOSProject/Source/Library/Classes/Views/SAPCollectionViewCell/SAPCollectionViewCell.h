//
//  SAPCollectionViewCell.h
//  Study training
//
//  Created by Andrey on 8/15/16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import <UIKit/UICollectionViewCell.h>

#import "SAPModelObserver.h"

//You should never expect the cell to have the reuseIdentifier you passed during initialization
@interface SAPCollectionViewCell : UICollectionViewCell <SAPModelObserver>

@end
