//
//  SAPSquareView.h
//  IOSProject
//
//  Created by S A P on 1/28/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, SAPSquarePosition) {
    kSAPSquarePositionTopLeft,
    kSAPSquarePositionTopRight,
    kSAPSquarePositionBottomRight,
    kSAPSquarePositionBottomLeft,
    kSAPSquarePositionsCount
};

typedef void(^SAPVoidBlock)(void);

@interface SAPSquareView : UIView
@property (nonatomic, assign) BOOL              loopedMoving;
@property (nonatomic, assign) SAPSquarePosition squarePosition;
@property (nonatomic, strong) IBOutlet UILabel  *squareLabel;
@property (nonatomic, strong) IBOutlet UIButton *moveButton;
@property (nonatomic, strong) IBOutlet UIButton *startStopButton;

- (void)moveToNextPosition;

- (void)setSquarePosition:(SAPSquarePosition)squarePosition
                 animated:(BOOL)animated;

- (void)setSquarePosition:(SAPSquarePosition)squarePosition
                 animated:(BOOL)animated
        completionHandler:(SAPVoidBlock)handler;

@end
