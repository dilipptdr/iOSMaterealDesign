//
//  L3SDKCardsView.m
//  Parallax
//
//  Created by Domenico Vacchiano on 01/04/15.
//  Copyright (c) 2015 LamCube. All rights reserved.
//

#import "CustomView.h"
#define CARD_X_MARGIN   20
#define CARD_Y_MARGIN   10



@interface CustomView ()
    @property (nonatomic,assign) UISwipeGestureRecognizerDirection gestureDirection;
    @property (nonatomic,assign)CGPoint gestureStartPoint;
    @property (nonatomic,assign)UIView*gestureView;
    @property (nonatomic,strong)NSMutableArray*cardsOptions;
    @property (nonatomic,assign)CGRect superviewFrame;
@end


@implementation CustomView

@synthesize delegate;
@synthesize startFrame;

#pragma mark - Init


- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    [self drawView];
    
}


-(id)initWithFrame:(CGRect)frame{
    
    
    self=[super initWithFrame:frame];
    if (self) {
        [self drawRect:frame];
    }
    return self;
    
}
- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    if(self){
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
}


#pragma mark - Public Methods




-(void)drawView{
    self.superviewFrame=self.superview.frame;
    self.startFrame=self.frame;
    
    [self setNeedsDisplay];
}




#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //NSLog(@"touchesBegan");
    
    
    UITouch *touch = [touches anyObject];
    //set start touch point
    self.gestureStartPoint = [touch locationInView:self];
    //get view from touch
    self.gestureView = [self hitTest:self.gestureStartPoint withEvent:event];

}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
   
    UITouch *touch = [touches anyObject];
    CGPoint gestureEndPoint = [touch locationInView:self];
    //gets gesture direction
    self.gestureDirection=[self getGestureDirectionWithTouch:touch];
    BOOL canScroll=[self canScroll:self.gestureDirection];

    CGFloat shiftY=(gestureEndPoint.y - self.gestureStartPoint.y);
    
    //send event
    if (canScroll) {
        if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(CustomViewScrolling: yShift:)]) {
            [self.delegate CustomViewScrolling:self.gestureDirection yShift:shiftY];
        }
    }
   

    if ((self.gestureDirection==UISwipeGestureRecognizerDirectionUp |self.gestureDirection==UISwipeGestureRecognizerDirectionDown) && canScroll) {
        
        //scroll containter view
        self.frame = CGRectOffset(self.frame,(0),shiftY);

        
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //NSLog(@"touchesEnded");

    if (![self.gestureView isEqual:self]) {
        
        //we are swiping a card
        float x=self.gestureView.frame.origin.x;
        if (fabs(x)>self.frame.size.width/2){

            //card will be deleted when x is greater than half width view
        
        }else{
            //card will be positioned at the orginila position
           
            self.gestureView.alpha=1.0;
        }
    }

    
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    //NSLog(@"touchesCancelled");
}

#pragma mark - Touch Utility
-(UISwipeGestureRecognizerDirection)getGestureDirectionWithTouch:(UITouch*)touch {
    
    CGPoint gestureEndPoint = [touch locationInView:self];
    int dx = fabs(self.gestureStartPoint.x - gestureEndPoint.x);
    int dy = -1 * (gestureEndPoint.y - self.gestureStartPoint.y);
    
    if(dx > 20) {
        // left/right
        return UISwipeGestureRecognizerDirectionRight;
    }
    
    if(dy < 0) {
        // down
        return UISwipeGestureRecognizerDirectionDown;
    }else if(dy > 0) {
        // up
        return UISwipeGestureRecognizerDirectionUp;
    }
    
    return -1;
}
-(BOOL)canScroll:(UISwipeGestureRecognizerDirection)scrollDirection{
    
 
    if(scrollDirection==UISwipeGestureRecognizerDirectionUp && self.frame.origin.y<=20) {
        //UP scrolling
        
//        if (fabs(self.frame.origin.y)>=fabs(self.frame.size.height-self.superviewFrame.size.height)) {
        
            if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(CustomViewUpperLimitReached)]) {
                [self.delegate CustomViewUpperLimitReached];
            }
            return NO;
//        }
        
    }else if(scrollDirection==UISwipeGestureRecognizerDirectionDown  && self.frame.origin.y>0) {
        //DOWN
        if (fabs(self.frame.origin.y)>=self.startFrame.origin.y ) {
            //scroll will stop when first view is on the initial frame y
            if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(CustomViewBottomLimitReached)]) {
                [self.delegate CustomViewBottomLimitReached];
            }
            return NO;
        }
    }
    
    return YES;
    
}



@end
