//
//  SAPSquareView.m
//  IOSProject
//
//  Created by S A P on 1/28/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPSquareView.h"

#import "SAPEmptyMacro.h"
#import "SAPOwnershipMacro.h"
#import "SAPClangMacro.h"

static NSTimeInterval const kSAPAnimationDuration  = 1.0;
static NSString * const kSAPButtonTitleStop    = @"Stop";
static NSString * const kSAPButtonTitleStart   = @"Start";

@interface SAPSquareView ()
@property (nonatomic, assign)                       BOOL    loopedMoving;

static inline
CGPoint CGPointBySubstractingRects(CGRect minuend, CGRect subtrahend);

- (CGRect)squareFrameWithSquarePosition:(SAPSquarePosition)squarePosition;
- (SAPSquarePosition)nextPositionWithSquarePosition:(SAPSquarePosition)squarePosition;

- (void)changeStartStopButtonColor:(UIColor *)color title:(NSString *)title;
- (void)updateStartStopButtonAppearanceIfMoving:(BOOL)moving;

- (void)loopMove;

@end

@implementation SAPSquareView

#pragma mark -
#pragma mark Accessors

- (void)setSquarePosition:(SAPSquarePosition)squarePosition {
    [self setSquarePosition:squarePosition animated:NO];
}

- (void)setMoving:(BOOL)moving {
    if (_moving != moving) {
        _moving = moving;
        
        self.loopedMoving = moving;
        [self updateStartStopButtonAppearanceIfMoving:moving];
        if (moving) {
            [self loopMove];
        }
    }
}

#pragma mark -
#pragma mark Public

- (void)moveSquare {
    [self setSquarePosition:[self nextPositionWithSquarePosition:self.squarePosition]
                   animated:YES];
}

- (void)setSquarePosition:(SAPSquarePosition)squarePosition animated:(BOOL)animated {
    [self setSquarePosition:squarePosition animated:animated completionHandler:nil];
}

- (void)setSquarePosition:(SAPSquarePosition)squarePosition
                 animated:(BOOL)animated
        completionHandler:(SAPVoidBlock)handler
{
    [UIView animateKeyframesWithDuration:animated ? kSAPAnimationDuration : 0.0
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionBeginFromCurrentState
                              animations: ^{
                                  self.squareLabel.frame = [self squareFrameWithSquarePosition:squarePosition];
                              }
                              completion:^(BOOL finished) {
                                  if (finished) {
                                      _squarePosition = squarePosition;
                                  }
                                  
                                  if (handler) {
                                      handler();
                                  }
                              }];
}

#pragma mark -
#pragma mark Private

static inline
CGPoint CGPointBySubstractingRects(CGRect minuend, CGRect subtrahend) {
    return CGPointMake(CGRectGetMaxX(minuend) - CGRectGetWidth(subtrahend),
                       CGRectGetMaxY(minuend) - CGRectGetHeight(subtrahend));
}

- (CGRect)squareFrameWithSquarePosition:(SAPSquarePosition)squarePosition{
    CGRect squareFrame = self.squareLabel.frame;
    CGPoint visibleOrigin = CGPointBySubstractingRects(self.bounds, squareFrame);
    CGPoint resultOrigin = CGPointZero;
    switch (squarePosition) {
        case kSAPSquarePositionTopRight:
            resultOrigin.x = visibleOrigin.x;
            break;
            
        case kSAPSquarePositionBottomLeft:
            resultOrigin.y = visibleOrigin.y;
            break;
            
        case kSAPSquarePositionBottomRight:
            resultOrigin = visibleOrigin;
            break;
            
        default:
            break;
    }
    
    squareFrame.origin = resultOrigin;
    
    return squareFrame;
}

- (SAPSquarePosition)nextPositionWithSquarePosition:(SAPSquarePosition)squarePosition {
    NSUInteger nextPositionSummand = kSAPSquarePositionBottomLeft == squarePosition ? 2 : 1;
    
    return (squarePosition + nextPositionSummand) % kSAPSquarePositionsCount;
}

- (void)changeStartStopButtonColor:(UIColor *)color title:(NSString *)title {
    UIButton *startStopButton = self.startStopButton;
    startStopButton.backgroundColor = color;
    [startStopButton setTitle:title forState:UIControlStateNormal];
}

- (void)updateStartStopButtonAppearanceIfMoving:(BOOL)moving {
    UIColor *color = moving ? [UIColor redColor] : [UIColor greenColor];
    NSString *title = moving ? kSAPButtonTitleStop : kSAPButtonTitleStart;
    
    [self changeStartStopButtonColor:color title:title];
}

- (void)loopMove {
    SAPWeakify(self);
    [self setSquarePosition:[self nextPositionWithSquarePosition:self.squarePosition]
                   animated:YES
          completionHandler:^{
              SAPStrongifyAndReturnIfNil(self)
              if (self.loopedMoving) {
                  [self loopMove];
              }
          }
     ];
}

@end
