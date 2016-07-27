//
// CustomViewsView.h
//
//

#import <UIKit/UIKit.h>


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
