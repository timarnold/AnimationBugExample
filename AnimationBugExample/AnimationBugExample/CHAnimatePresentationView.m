//
//  CHAnimatePresentationView.m
//  Tall Chess
//
//  Created by Tim Arnold on 1/31/14.
//  Copyright (c) 2014 Friends of The Web. All rights reserved.
//

#import "CHAnimatePresentationView.h"

@interface CHAnimatePresentationView ()

@property (nonatomic, assign) BOOL animating;
@property (nonatomic, copy) CHBlock completionBlock;

@end

@implementation CHAnimatePresentationView

#pragma mark - Animating present / dismiss

- (void)bounce {
    NSLog(@"%@ beginning method", NSStringFromSelector(_cmd));
    if (self.animating) {
        [self.layer removeAllAnimations];
    }
    self.animating = YES;
    
    CAAnimation *animation = [self animationWithType:SMCalloutAnimationBounceInPlace presenting:YES];
    animation.beginTime = CACurrentMediaTime();
    animation.delegate = self;
    
    [self.layer addAnimation:animation forKey:@"present"];
    NSLog(@"%@ add animation", NSStringFromSelector(_cmd));
}


- (CAAnimation *)animationWithType:(SMCalloutAnimation)type presenting:(BOOL)presenting {
    CAAnimation *animation = nil;
    
    if (type == SMCalloutAnimationBounceInPlace) {
        CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        CAMediaTimingFunction *easeInOut = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        bounceAnimation.values = @[@0.951807, @1.11245, @0.951807, @1.0];
        bounceAnimation.keyTimes = @[@0, @(4.0/9.0), @(4.0/9.0+5.0/18.0), @1.0];
        bounceAnimation.duration = 1.0/3.0;
        bounceAnimation.timingFunctions = @[easeInOut, easeInOut, easeInOut, easeInOut];
        
        if (!presenting)
            bounceAnimation.values = [[bounceAnimation.values reverseObjectEnumerator] allObjects]; // reverse values
        
        animation = bounceAnimation;
    }
    
    [animation setValue:@(presenting) forKey:@"presenting"];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    return animation;
}

#pragma mark - CAAnimationDelegate methods

- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    if ([[anim valueForKey:@"presenting"] boolValue]) {
        self.hidden = NO;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)finished {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    if (![[anim valueForKey:@"presenting"] boolValue]) {
        [self.layer removeAnimationForKey:@"dismiss"];
    }
    
    if (self.completionBlock) self.completionBlock();
    self.completionBlock = nil;
    self.animating = NO;
}

@end