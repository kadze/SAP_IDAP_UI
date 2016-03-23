//
//  SAPFriendDetailView.h
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPView.h"

@class SAPImageView;

@interface SAPFriendDetailView : SAPView
@property (nonatomic, strong) IBOutlet SAPImageView *userImageView;
@property (nonatomic, strong) IBOutlet UILabel *firstNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *lastNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *genderLabel;

@end
