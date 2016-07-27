//
// CustomViewsView.h
//  Parallax
//
//  Created by Domenico Vacchiano on 01/04/15.
//  Copyright (c) 2015 LamCube. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_OPTIONS(NSUInteger,CustomViewOptions) {
   CustomViewOptionsIsSwipeableCard = 1 << 0
};


@protocol CustomViewDelegate <NSObject>
@optional
- (void)CustomViewScrolling:(UISwipeGestureRecognizerDirection)scrollDirection yShift:(CGFloat) yShift;
- (void)CustomViewUpperLimitReached;
- (void)CustomViewBottomLimitReached;

@end


@interface CustomView : UIView
@property (nonatomic,assign) id<CustomViewDelegate> delegate;

@property (nonatomic,assign)CGRect startFrame;

-(void)drawView;

@end
