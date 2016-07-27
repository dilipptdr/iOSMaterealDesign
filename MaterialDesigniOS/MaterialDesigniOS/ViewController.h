//
//  ViewController.h
//  Spuul
//
//  Created by Dilip Patidar on 26/07/16.
//  Copyright © 2016 Dilip Patidar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"

@interface ViewController : UIViewController<CustomViewDelegate>


@property (weak, nonatomic) IBOutlet CustomView *lowerView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

