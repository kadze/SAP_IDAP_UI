//
//  SAPSquareView.h
//  IOSProject
//
//  Created by S A P on 1/28/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, SAPSquarePosition) {
    kSAPSquarePositionTopLeft = 1,
    kSAPSquarePositionTopRight,
    kSAPSquarePositionBottomLeft,
    kSAPSquarePositionBottomRight
};

typedef void(^SAPVoidBlock)(void);

@interface SAPSquareView : UIView
@property (nonatomic, assign) SAPSquarePosition squarePosition;
@property (nonatomic, strong) IBOutlet UILabel  *square;
@property (nonatomic, strong) IBOutlet UIButton *move;
@property (nonatomic, strong) IBOutlet UIButton *startStop;

- (void)moveSquare;

- (void)setSquarePosition:(SAPSquarePosition)squarePosition
                 animated:(BOOL)animated;

- (void)setSquarePosition:(SAPSquarePosition)squarePosition
                 animated:(BOOL)animated
        completionHandler:(SAPVoidBlock)handler;

- (void)changeButtonAppearanceForStop;
- (void)changeButtonAppearanceForStart;

@end
