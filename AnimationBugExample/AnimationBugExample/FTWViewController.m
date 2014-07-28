//
//  FTWViewController.m
//  AnimationBugExample
//
//  Created by Tim Arnold on 7/28/14.
//  Copyright (c) 2014 Friends of The Web. All rights reserved.
//

#import "FTWViewController.h"
#import "CHAnimatePresentationView.h"

@interface FTWViewController ()

@property (weak, nonatomic) IBOutlet CHAnimatePresentationView *animationView;

@end

@implementation FTWViewController

- (IBAction)animateTapped:(id)sender {
    [self.animationView bounce];
}

- (IBAction)generateScreensTapped:(id)sender {
    for (NSUInteger i = 0; i < 100; i++) {
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
        [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
        __unused UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}

@end
