//
//  SAPSquareView.m
//  IOSProject
//
//  Created by S A P on 1/28/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPSquareView.h"

#import "CGGeometry+SAPExtentions.h"

#import "SAPOwnershipMacro.h"
#import "SAPClangMacro.h"

static NSTimeInterval const kSAPAnimationDuration  = 1.0;

static NSString * const kSAPButtonTitleStop  = @"Stop";
static NSString * const kSAPButtonTitleStart = @"Start";

@interface SAPSquareView ()
@property (nonatomic, assign) BOOL animating;

- (CGRect)squareFrameWithSquarePosition:(SAPSquarePosition)squarePosition;
- (SAPSquarePosition)nextPositionWithSquarePosition:(SAPSquarePosition)squarePosition;

- (void)setAnimateButtonColor:(UIColor *)color title:(NSString *)title;
- (void)updateAnimateButtonAppearanceIfLoopedMoving:(BOOL)loopedMoving;

@end

@implementation SAPSquareView

#pragma mark -
#pragma mark Accessors

- (void)setSquarePosition:(SAPSquarePosition)squarePosition {
    [self setSquarePosition:squarePosition animated:NO];
}

- (void)setSquarePosition:(SAPSquarePosition)squarePosition animated:(BOOL)animated {
    [self setSquarePosition:squarePosition animated:animated completionHandler:nil];
}

- (void)setSquarePosition:(SAPSquarePosition)squarePosition
                 animated:(BOOL)animated
        completionHandler:(SAPVoidBlock)handler
{
    if (self.animating) {
        return;
    }
    
    self.animating = YES;
    [UIView animateWithDuration:animated ? kSAPAnimationDuration : 0.0
                     animations: ^{
                         self.squareLabel.frame = [self squareFrameWithSquarePosition:squarePosition];
                     }
                     completion:^(BOOL finished) {
                         self.animating = NO;
                         if (finished) {
                             _squarePosition = squarePosition;
                         }
                         
                         if (handler) {
                             handler();
                         }
                     }];
}

- (void)setLoopedMoving:(BOOL)loopedMoving {
    if (_loopedMoving != loopedMoving) {
        _loopedMoving = loopedMoving;
        
        [self updateAnimateButtonAppearanceIfLoopedMoving:loopedMoving];
        if (loopedMoving) {
            [self moveToNextPosition];
        }
    }
}

- (void)setAnimateButtonColor:(UIColor *)color title:(NSString *)title {
    UIButton *animateButton = self.animateButton;
    animateButton.backgroundColor = color;
    [animateButton setTitle:title forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark Public

- (void)moveToNextPosition {
    SAPWeakify(self);
    [self setSquarePosition:[self nextPositionWithSquarePosition:self.squarePosition]
                   animated:YES
          completionHandler:^{
              SAPStrongifyAndReturnIfNil(self)
              if (self.loopedMoving) {
                  [self moveToNextPosition];
              }
          }
     ];
}

#pragma mark -
#pragma mark Private

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
    return (squarePosition + 1) % kSAPSquarePositionsCount;
}

- (void)updateAnimateButtonAppearanceIfLoopedMoving:(BOOL)loopedMoving {
    UIColor *color = loopedMoving ? [UIColor redColor] : [UIColor greenColor];
    NSString *title = loopedMoving ? kSAPButtonTitleStop : kSAPButtonTitleStart;
    
    [self setAnimateButtonColor:color title:title];
}

@end
