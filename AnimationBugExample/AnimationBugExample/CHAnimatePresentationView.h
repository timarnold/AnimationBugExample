//
//  CHAnimatePresentationView.h
//  Tall Chess
//
//  Created by Tim Arnold on 1/31/14.
//  Copyright (c) 2014 Friends of The Web. All rights reserved.
//

@interface CHAnimatePresentationView : UIView

typedef NS_ENUM(int16_t, SMCalloutAnimation) {
    SMCalloutAnimationBounceInPlace
};

typedef void(^CHBlock)(void);

- (void)bounce;

@end