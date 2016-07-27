//
//  ViewController.m
//  
//
//  Created by Dilip Patidar on 26/07/16.
//  Copyright © 2016 Dilip Patidar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{

    BOOL bootomReached;
}

@property(nonatomic) CGRect startImgFrame;

@end

@implementation ViewController

@synthesize startImgFrame;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.lowerView setDelegate:self];
    startImgFrame=[self.imageView frame];
    
    self.textView.textContainerInset = UIEdgeInsetsMake(20, 20, 20, 20);
    bootomReached=NO;
    
}


#pragma mark - Callback when user drags the TextView
-(void)CustomViewScrolling:(UISwipeGestureRecognizerDirection)scrollDirection yShift:(CGFloat)yShift{
    
    bootomReached=NO;
  if(self.imageView.hidden && scrollDirection==UISwipeGestureRecognizerDirectionDown){
        self.imageView.hidden=NO;
        self.imageView.alpha = 1.0f;
//      [self.textView setUserInteractionEnabled:NO];
   }
  
    
    switch (scrollDirection) {
        case UISwipeGestureRecognizerDirectionUp:
        {
            
            [UIView animateWithDuration:0.4
                                  delay:0.0
                                options:UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                                 
                                 CGRect rect=self.imageView.frame;
                                 rect.origin=CGPointMake(rect.origin.x, rect.origin.y+(yShift));
                                 
                                 [self.imageView setFrame:rect];
                                 CGFloat yval=self.lowerView.frame.origin.y;
                                 if(yval<100.0)
                                     [self.imageView setAlpha:(yval/100.0)];
                                 
                                 
                             }
                             completion:^(BOOL finished){
                                 
                             }];
            
            
        }
        break;
        case UISwipeGestureRecognizerDirectionDown:
        {
            [UIView animateWithDuration:0.4
                                  delay:0.0
                                options:UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                                 
                                 CGRect rect=self.imageView.frame;
                                 
                                 if(self.startImgFrame.origin.y>rect.origin.y+(yShift))
                                 {
                                     rect.origin=CGPointMake(rect.origin.x, rect.origin.y+(yShift));
                                     
                                     [self.imageView setFrame:rect];
                                 }
                                 
                                 CGFloat yval=self.lowerView.frame.origin.y;
                                 if(yval<100.0)
                                     [self.imageView setAlpha:(yval/100.0)];
                             }
                             completion:^(BOOL finished){
                                 
                             }];
            
        }
        break;
        default:
            break;
    }
    

}


#pragma mark - Callback when the scroll reaches the upper bound
-(void)CustomViewUpperLimitReached{
    
    
    if(self.imageView.hidden ==NO){
   
//        [self.textView setUserInteractionEnabled:YES];
        
        NSLog(@"reached top");
//        self.imageView.alpha = 1.0f;
        // Then fades it away after 2 seconds (the cross-fade animation will take 0.5s)
        [UIView animateWithDuration:0.1 delay:0.0 options:0 animations:^{
            // Animate the alpha value of your imageView from 1.0 to 0.0 here
            self.imageView.alpha = 0.2f;
        } completion:^(BOOL finished) {
            // Once the animation is completed and the alpha has gone to 0.0, hide the view for good
        self.imageView.hidden = YES;
        }];
    
    }
    
}

#pragma mark - Callback when the scroll reaches the lower bound
-(void)CustomViewBottomLimitReached{

    if(bootomReached==NO){
    
        [UIView animateWithDuration:0.6
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.imageView.transform=CGAffineTransformMakeScale(1.2, 1.2);
                         }
                         completion:^(BOOL finished){
                             if (finished) {
                                 bootomReached=NO;
                                 
                                 self.imageView.transform=CGAffineTransformMakeScale(1.0, 1.0);
//                                 self.imageView.transform=CGAffineTransformIdentity;
                             }
                             
                         }];
    }
    
   bootomReached=YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
