//
//  SVProgressHUD.m
//
//  Created by Sam Vermette on 27.03.11.
//  Copyright 2011 Sam Vermette. All rights reserved.
//
//  https://github.com/samvermette/SVProgressHUD
//
// Portions of code by Marcel Müller
// Portions of code by Barrett Jacobsen


#import "SVProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
//#import "URLConnection.h"
@class SVProgressBarView;

#ifdef SVPROGRESSHUD_DISABLE_NETWORK_INDICATOR
#define SVProgressHUDShowNetworkIndicator 0
#else
#define SVProgressHUDShowNetworkIndicator 1
#endif

@interface SVProgressHUD ()

@property (nonatomic, readwrite) SVProgressHUDMaskType maskType;
@property (nonatomic, readwrite) BOOL showNetworkIndicator;
@property (nonatomic, retain) NSTimer *fadeOutTimer;

@property (nonatomic, readonly) UIWindow *overlayWindow;
@property (nonatomic, readonly) UIView *hudView;
@property (nonatomic, readonly) UILabel *stringLabel;
@property (nonatomic, readonly) UIImageView *imageView;
@property (nonatomic, readonly) UIActivityIndicatorView *spinnerView;
@property (nonatomic, assign) UIWindow *previousKeyWindow;
@property (nonatomic, readonly) CGFloat visibleKeyboardHeight;

@property (nonatomic, readonly) SVProgressBarView *progressBarView;

@property (nonatomic, assign) BOOL hideOnTouch;

@property (nonatomic, retain) UILabel *subtitleLabel;
@property (nonatomic, assign) BOOL isDismissed;
@property (nonatomic, assign) BOOL isDownloadingVideo;

- (void)showWithStatus:(NSString*)string maskType:(SVProgressHUDMaskType)hudMaskType indicatorType:(SVProgressHUDIndicatorType)indicatorType networkIndicator:(BOOL)show;

- (void)showWithStatus:(NSString*)string subtitle:(NSString*)subtitle maskType:(SVProgressHUDMaskType) hudMaskType indicatorType:(SVProgressHUDIndicatorType)indicatorType networkIndicator:(BOOL)show;


- (void)setStatus:(NSString*)string;
- (void)setStatus:(NSString *)string subtitle:(NSString*)subtitle;

- (void)registerNotifications;
- (void)moveToPoint:(CGPoint)newCenter rotateAngle:(CGFloat)angle;
- (void)positionHUD:(NSNotification*)notification;

- (void)setProgress:(CGFloat)progress;
- (CGFloat)progress;

- (void)dismiss;
- (void)dismissWithStatus:(NSString*)string error:(BOOL)error;
- (void)dismissWithStatus:(NSString*)string maskType:(SVProgressHUDMaskType)_maskType error:(BOOL)error;
- (void)dismissWithStatus:(NSString*)string error:(BOOL)error afterDelay:(NSTimeInterval)seconds;
- (UILabel *)subtitleLabel;
@end

#pragma mark - SVProgressBarView Interface

@interface SVProgressBarView : UIView {
	CGFloat progress;
}
@property (nonatomic, assign) CGFloat progress;
@end


#pragma mark - SVProgressHud Implementation



@implementation SVProgressHUD

@synthesize hudView, maskType, showNetworkIndicator, fadeOutTimer, stringLabel, imageView, spinnerView, progressBarView, previousKeyWindow, visibleKeyboardHeight, overlayWindow, hideOnTouch, subtitleLabel, isDismissed, isDownloadingVideo;
;

static SVProgressHUD *sharedView = nil;

+ (SVProgressHUD*)sharedView {
	
	if(sharedView == nil)
		sharedView = [[SVProgressHUD alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	return sharedView;
}


+ (void)setStatus:(NSString *)string {
	[[SVProgressHUD sharedView] setStatus:string];
}

+ (void)setHideOnTouch:(BOOL)hideOnTouch {
	[SVProgressHUD sharedView].hideOnTouch = hideOnTouch;
}

+ (BOOL)hideOnTouch {
	return [SVProgressHUD sharedView].hideOnTouch;
}

#pragma mark - Show Methods

+ (void)show {
	[SVProgressHUD showWithStatus:nil networkIndicator:SVProgressHUDShowNetworkIndicator];
}

+ (void)showWithStatus:(NSString *)status {
    [SVProgressHUD showWithStatus:status networkIndicator:SVProgressHUDShowNetworkIndicator];
}

+ (void)showWithMaskType:(SVProgressHUDMaskType)maskType {
    [SVProgressHUD showWithStatus:nil maskType:maskType networkIndicator:SVProgressHUDShowNetworkIndicator];
}

+ (void)showWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType {
    [SVProgressHUD showWithStatus:status maskType:maskType networkIndicator:SVProgressHUDShowNetworkIndicator];
}

+ (void)showWithStatus:(NSString *)status networkIndicator:(BOOL)show {
    [SVProgressHUD showWithStatus:status maskType:SVProgressHUDMaskTypeNone networkIndicator:show];
}

+ (void)showWithMaskType:(SVProgressHUDMaskType)maskType networkIndicator:(BOOL)show {
    [SVProgressHUD showWithStatus:nil maskType:maskType networkIndicator:show];
}

+ (void)showWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType networkIndicator:(BOOL)show {
    [SVProgressHUD showWithStatus:status maskType:maskType indicatorType:SVProgressHUDIndicatorTypeSpinner networkIndicator:show];
}

+ (void)showWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType indicatorType:(SVProgressHUDIndicatorType)indicatorType networkIndicator:(BOOL)show {
    [[SVProgressHUD sharedView] showWithStatus:status subtitle:@"" maskType:maskType indicatorType:indicatorType networkIndicator:show];
}

+ (void)showSuccessWithStatus:(NSString *)string {
    [SVProgressHUD show];
    [SVProgressHUD dismissWithSuccess:string afterDelay:1];
}
+ (void)showSuccessWithStatus:(NSString*)string afterDelay:(NSTimeInterval)seconds{
    [SVProgressHUD show];
    [SVProgressHUD dismissWithSuccess:string afterDelay:seconds];
}

#pragma mark - Progress
+ (void)setProgress:(CGFloat)progress {
    [SVProgressHUD sharedView].progress = progress;
}

+ (CGFloat)progress {
    return [SVProgressHUD sharedView].progress;
}

#pragma mark - Deprecated show methods

+ (void)showInView:(UIView*)view {
    [SVProgressHUD showWithStatus:nil maskType:SVProgressHUDMaskTypeNone networkIndicator:SVProgressHUDShowNetworkIndicator];
}

+ (void)showInView:(UIView*)view status:(NSString*)string {
    [SVProgressHUD showWithStatus:string maskType:SVProgressHUDMaskTypeNone networkIndicator:SVProgressHUDShowNetworkIndicator];
}

+ (void)showInView:(UIView*)view status:(NSString*)string networkIndicator:(BOOL)show {
    [SVProgressHUD showWithStatus:string maskType:SVProgressHUDMaskTypeNone networkIndicator:show];
}

+ (void)showInView:(UIView*)view status:(NSString*)string networkIndicator:(BOOL)show posY:(CGFloat)posY {
    [SVProgressHUD showWithStatus:string maskType:SVProgressHUDMaskTypeNone networkIndicator:show];
}

+ (void)showInView:(UIView*)view status:(NSString*)string networkIndicator:(BOOL)show posY:(CGFloat)posY maskType:(SVProgressHUDMaskType)hudMaskType {
    [SVProgressHUD showWithStatus:string maskType:hudMaskType networkIndicator:show];
}

#pragma mark - Dismiss Methods

+ (void)dismiss {
	[[SVProgressHUD sharedView] dismiss];
}

+ (void)dismissWithSuccess:(NSString*)successString {
	[[SVProgressHUD sharedView] dismissWithStatus:successString error:NO];
}

+ (void)dismissWithSuccess:(NSString *)successString afterDelay:(NSTimeInterval)seconds {
    [[SVProgressHUD sharedView] dismissWithStatus:successString maskType:SVProgressHUDMaskTypeGradient error:NO afterDelay:seconds];
}

+ (void)dismissWithError:(NSString*)errorString {
	[[SVProgressHUD sharedView] dismissWithStatus:errorString error:YES];
}

+ (void)dismissWithError:(NSString *)errorString afterDelay:(NSTimeInterval)seconds {
    [[SVProgressHUD sharedView] dismissWithStatus:errorString maskType:SVProgressHUDMaskTypeNone error:YES afterDelay:seconds];
}
+ (void)dismissWithError:(NSString *)errorString maskType:(SVProgressHUDMaskType)_maskType afterDelay:(NSTimeInterval)seconds {
    [[SVProgressHUD sharedView] dismissWithStatus:errorString maskType:_maskType error:YES afterDelay:seconds];
}
+ (void)showWithStatus:(NSString*)string subtitle:(NSString*)subtitle maskType:(SVProgressHUDMaskType)hudMaskType indicatorType:(SVProgressHUDIndicatorType)indicatorType {
    [[SVProgressHUD sharedView] showWithStatus:string subtitle:subtitle maskType:hudMaskType indicatorType:indicatorType networkIndicator:SVProgressHUDShowNetworkIndicator];
    
}
+ (void)showWithStatus:(NSString*)string subtitle:(NSString*)subtitle maskType:(SVProgressHUDMaskType)hudMaskType indicatorType:(SVProgressHUDIndicatorType)indicatorType networkIndicator:(BOOL)show{
    
    
    
    [[SVProgressHUD sharedView] showWithStatus:string subtitle:subtitle maskType:hudMaskType indicatorType:indicatorType networkIndicator:show];
}
+ (void)setIsDownloadingVideo:(BOOL)_status{
    [[SVProgressHUD sharedView] setIsDownloadingVideo:_status];
}


#pragma mark - Instance Methods

- (id)initWithFrame:(CGRect)frame {
	
    if ((self = [super initWithFrame:frame])) {
        [self.overlayWindow addSubview:self];
		self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
		self.alpha = 0;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        hideOnTouch = YES;
        
    }
	
    return self;
}

- (UILabel *)subtitleLabel {
    if (subtitleLabel == nil) {
        subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        subtitleLabel.textColor = [UIColor whiteColor];
        subtitleLabel.backgroundColor = [UIColor clearColor];
        subtitleLabel.adjustsFontSizeToFitWidth = YES;
        subtitleLabel.textAlignment = NSTextAlignmentCenter;
        subtitleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        subtitleLabel.font = [UIFont systemFontOfSize:14];
        subtitleLabel.shadowColor = [UIColor blackColor];
        subtitleLabel.shadowOffset = CGSizeMake(0, -1);
        subtitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        subtitleLabel.numberOfLines = 0;
        [self addSubview:subtitleLabel];
    }
    return subtitleLabel;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    switch (self.maskType) {
            
        case SVProgressHUDMaskTypeBlack: {
            [[UIColor colorWithWhite:0 alpha:0.5] set];
            CGContextFillRect(context, self.bounds);
            break;
        }
            
        case SVProgressHUDMaskTypeGradient: {
            
            size_t locationsCount = 2;
            CGFloat locations[2] = {0.0f, 1.0f};
            CGFloat colors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.75f};
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, locationsCount);
            CGColorSpaceRelease(colorSpace);
            
            CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
            float radius = MIN(self.bounds.size.width , self.bounds.size.height) ;
            CGContextDrawRadialGradient (context, gradient, center, 0, center, radius, kCGGradientDrawsAfterEndLocation);
            CGGradientRelease(gradient);
            
            break;
        }
    }
}

- (void)setProgress:(CGFloat)progress {
    self.progressBarView.progress = progress;
}

- (CGFloat)progress {
    return self.progressBarView.progress;
}
//- (void)setStatus:(NSString *)string subtitle:(NSString*)subtitle {
//
//    CGFloat hudHMargin  = 14.0;
//    CGFloat hudVMargin  = 22.0;
//    CGFloat innerVSpace = 14.0;
//
//    CGFloat hudMinWidth  = 100.0;
//    CGFloat hudMaxWidth  = CGRectGetWidth([[UIScreen mainScreen] applicationFrame]) - 2*hudHMargin;
//
//    CGFloat hudMinHeight  = 100.0;
//    CGFloat hudMaxHeight = CGRectGetHeight([[UIScreen mainScreen] applicationFrame]) - 2*hudVMargin;
//
//	CGFloat stringWidth   = [string sizeWithFont:self.stringLabel.font].width;
//    CGFloat subtitleWidth = [subtitle sizeWithFont:self.subtitleLabel.font].width;
//
//    CGFloat hudWidth   = MAX(stringWidth, subtitleWidth) + 2*hudHMargin;
//    hudWidth = MIN(MAX(hudWidth, hudMinWidth), hudMaxWidth);
//
//    CGFloat labelWidth = hudWidth - 2*hudHMargin;
//
//    CGFloat stringHeight   = [string sizeWithFont:self.stringLabel.font
//                                constrainedToSize:CGSizeMake(labelWidth, CGFLOAT_MAX)
//                                    lineBreakMode:self.stringLabel.lineBreakMode].height;
//
//    CGFloat subtitleHeight = [subtitle sizeWithFont:self.subtitleLabel.font
//                                  constrainedToSize:CGSizeMake(labelWidth, CGFLOAT_MAX)
//                                      lineBreakMode:self.subtitleLabel.lineBreakMode].height;
//
//    CGFloat hudHeight = CGRectGetHeight(self.imageView.frame) + stringHeight + innerVSpace + 2*hudVMargin;
//    if (subtitle) {
//        hudHeight += (subtitleHeight + innerVSpace);
//    }
//    hudHeight = MIN(MAX(hudHeight, hudMinHeight), hudMaxHeight);
//
//    CGFloat labelMaxHeight = hudHeight - (CGRectGetHeight(self.imageView.frame) + innerVSpace + 2*hudVMargin);
//    CGFloat stringLabelHeight = MIN(stringHeight, labelMaxHeight);
//
//    labelMaxHeight -= stringLabelHeight;
//    CGFloat subtitleLabelHeight = MIN(subtitleHeight, labelMaxHeight);
//
//
//	self.bounds = CGRectMake(0.0, 0.0, hudWidth, hudHeight);
//
//	self.imageView.center = CGPointMake(CGRectGetWidth(self.bounds)/2, hudVMargin + CGRectGetHeight(self.imageView.frame)/2);
//
//	self.stringLabel.hidden = NO;
//	self.stringLabel.text = string;
//	self.stringLabel.frame = CGRectMake(0.0,
//                                        CGRectGetMaxY(self.imageView.frame)+innerVSpace,
//                                        CGRectGetWidth(self.bounds),
//                                        stringLabelHeight);
//
//    if (subtitle) {
//        self.subtitleLabel.hidden = NO;
//        self.subtitleLabel.text = subtitle;
//        self.subtitleLabel.frame = CGRectMake(0.0,
//                                              CGRectGetMaxY(self.stringLabel.frame)+innerVSpace,
//                                              CGRectGetWidth(self.bounds),
//                                              subtitleLabelHeight);
//    } else {
//        self.subtitleLabel.hidden = YES;
//    }
//
//	if(string)
//		self.spinnerView.center = CGPointMake(ceil(CGRectGetWidth(self.bounds)/2)+0.5, 40.5);
//	else
//		self.spinnerView.center = CGPointMake(ceil(CGRectGetWidth(self.bounds)/2)+0.5, ceil(self.bounds.size.height/2)+0.5);
//}
//

- (void)setStatus:(NSString *)string{
    CGFloat hudWidth = 100;
    CGFloat hudHeight = 100;
    CGFloat stringWidth = 0;
    CGFloat stringHeight = 0;
    CGRect labelRect = CGRectZero;
    
    if(string) {
        CGSize stringSize = [string sizeWithAttributes:
                       @{NSFontAttributeName:
                             self.stringLabel.font}];
        //CGSize stringSize = [string sizeWithFont:self.stringLabel.font constrainedToSize:CGSizeMake(200, 300)];
        stringWidth = stringSize.width;
        stringHeight = stringSize.height;
        hudHeight = 80+stringHeight;
        
        if(stringWidth > hudWidth)
            hudWidth = ceil(stringWidth/2)*2;
        
        if(hudHeight > hudHeight) {
            labelRect = CGRectMake(12, 66, hudWidth, stringHeight);
            hudWidth+=24;
        } else {
            hudWidth+=24;
            labelRect = CGRectMake(0, 66, hudWidth, stringHeight);
        }
    }
    
    self.hudView.bounds = CGRectMake(0, 0, hudWidth, hudHeight);
    
    self.imageView.center = CGPointMake(CGRectGetWidth(self.hudView.bounds)/2, 36);
    
    self.stringLabel.hidden = NO;
    self.stringLabel.text = string;
    self.stringLabel.frame = labelRect;
    
    if(string)
        self.spinnerView.center = CGPointMake(ceil(CGRectGetWidth(self.hudView.bounds)/2)+0.5, 40.5);
    else
        self.spinnerView.center = CGPointMake(ceil(CGRectGetWidth(self.hudView.bounds)/2)+0.5, ceil(self.hudView.bounds.size.height/2)+0.5);
    
    //[self setStatus:string subtitle:nil];
}

- (void)setStatus:(NSString *)string subtitle:(NSString*)subtitle{
    CGFloat hudHMargin  = 14.0;
    //CGFloat hudVMargin  = 22.0;
    //CGFloat innerVSpace = 14.0;
    
    CGFloat hudWidth = 100;
    CGFloat hudHeight = 100;
    
    CGFloat stringWidth = 0;
    CGFloat stringHeight = 0;
    
    CGFloat subtitleWidth = 0;
    CGFloat subtitleHeight = 0;
    
    CGFloat hudMinWidth  = 100.0;
    CGFloat hudMaxWidth  = CGRectGetWidth([[UIScreen mainScreen] applicationFrame]) - 2*hudHMargin;
    
    CGRect labelRect = CGRectZero;
    
    if(string) {
       // CGSize stringSize = [string sizeWithFont:self.stringLabel.font constrainedToSize:CGSizeMake(200, 100)];
        CGSize stringSize = [string sizeWithAttributes:
                             @{NSFontAttributeName:
                                   self.stringLabel.font}];
        //CGSize subtitleSize = [subtitle sizeWithFont:self.subtitleLabel.font constrainedToSize:CGSizeMake(200, 300)];
        CGSize subtitleSize = [subtitle sizeWithAttributes:
                             @{NSFontAttributeName:
                                   self.subtitleLabel.font}];
        stringWidth = stringSize.width;
        stringHeight = stringSize.height;
        
        if(subtitle){
            subtitleWidth = subtitleSize.width;
            subtitleHeight = subtitleSize.height;
        }
        
        hudHeight = 80+stringHeight;
        
        if(subtitle){
            hudHeight += subtitleHeight;
        }
        
        
        hudWidth   = MAX(stringWidth, subtitleWidth) + 2*hudHMargin;
        hudWidth = MIN(MAX(hudWidth, hudMinWidth), hudMaxWidth);
        
        
        //        if(stringWidth+subtitleWidth > hudWidth)
        //            hudWidth = ceil((stringWidth+subtitleWidth)/2)*2;
        //
        if(self.progressBarView.hidden == NO){
            if(hudHeight > 100) {
                labelRect = CGRectMake(12, 10, hudWidth, stringHeight);
                hudWidth+=24;
            } else {
                hudWidth+=24;
                labelRect = CGRectMake(0, 10, hudWidth, stringHeight);
            }
            
        }
        else {
            
            if(hudHeight > 100) {
                labelRect = CGRectMake(12, 10, hudWidth, stringHeight+subtitleHeight);
                hudWidth+=24;
            } else {
                hudWidth+=24;
                labelRect = CGRectMake(0, 10, hudWidth, stringHeight+subtitleHeight);
            }
        }
        
        
    }
	
	self.hudView.bounds = CGRectMake(0, 0, hudWidth, hudHeight);
	
    self.progressBarView.bounds = CGRectMake(0, 0, ceil(self.hudView.bounds.size.width - 20), 20);
    
	self.imageView.center = CGPointMake(CGRectGetWidth(self.hudView.bounds)/2, 36);
	
	self.stringLabel.hidden = NO;
	self.stringLabel.text = string;
	self.stringLabel.frame = labelRect;
	
    
    if (subtitle) {
        self.subtitleLabel.hidden = NO;
        self.subtitleLabel.text = subtitle;
        
        self.subtitleLabel.frame = CGRectMake(0.0,
                                              self.hudView.frame.origin.y+stringLabel.frame.size.height+ self.progressBarView.frame.size.height + 25,
                                              CGRectGetWidth(self.bounds),
                                              subtitleHeight);
    } else {
        self.subtitleLabel.hidden = YES;
    }
	NSLog(@"subtitle: %@, x: %f, y: %f", subtitle, subtitleLabel.frame.origin.x, subtitleLabel.frame.origin.y);
    
    
	if(string) {
		self.spinnerView.center = CGPointMake(ceil(CGRectGetWidth(self.hudView.bounds)/2)+0.5, stringHeight + 40.5);
        self.progressBarView.center = CGPointMake(ceil(CGRectGetWidth(self.hudView.bounds)/2), 60);
    }
	else {
		self.spinnerView.center = CGPointMake(ceil(CGRectGetWidth(self.hudView.bounds)/2)+0.5, ceil(self.hudView.bounds.size.height/2)+0.5);
		self.progressBarView.center = CGPointMake(ceil(CGRectGetWidth(self.hudView.bounds)/2), ceil(self.hudView.bounds.size.height/2));
    }
}


- (void)showWithStatus:(NSString*)string subtitle:(NSString*)subtitle maskType:(SVProgressHUDMaskType) hudMaskType indicatorType:(SVProgressHUDIndicatorType)indicatorType networkIndicator:(BOOL)show{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.isDismissed = NO;
        if(!self.superview)
            [self.overlayWindow addSubview:self];
        
        self.fadeOutTimer = nil;
        [self setShowNetworkIndicator:show];
        if(self.showNetworkIndicator)
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        self.imageView.hidden = YES;
        self.maskType = hudMaskType;
        
        //        [self setStatus:string];
        [self setStatus:string subtitle:subtitle];
        
        if (indicatorType == SVProgressHUDIndicatorTypeSpinner) {
            self.progressBarView.hidden = YES;
            self.spinnerView.hidden = NO;
            [self.spinnerView startAnimating];
        }
        else if (indicatorType == SVProgressHUDIndicatorTypeProgressBar) {
            self.spinnerView.hidden = YES;
            self.progressBarView.hidden = NO;
            NSLog(@"##############\n##############\n##############\nprogress bar done");
        }
        
        //        if(self.maskType != SVProgressHUDMaskTypeNone)
        //            self.userInteractionEnabled = NO;
        //        else
        //            self.userInteractionEnabled = YES
        //            ;
        
        [self.overlayWindow makeKeyAndVisible];
        [self positionHUD:nil];
        
        if(self.alpha != 1) {
            [self registerNotifications];
            self.hudView.transform = CGAffineTransformScale(self.hudView.transform, 1.3, 1.3);
            
            [UIView animateWithDuration:0.15
                                  delay:0
                                options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                                 self.hudView.transform = CGAffineTransformScale(self.hudView.transform, 1/1.3, 1/1.3);
                                 self.alpha = 1;
                             }
                             completion:NULL];
        }
        
        [self setNeedsDisplay];
    });
    
}


- (void)showWithStatus:(NSString*)string maskType:(SVProgressHUDMaskType)hudMaskType indicatorType:(SVProgressHUDIndicatorType)indicatorType networkIndicator:(BOOL)show {
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!self.superview)
            [self.overlayWindow addSubview:self];
        
        self.fadeOutTimer = nil;
        [self setShowNetworkIndicator:show];
        if(self.showNetworkIndicator)
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        self.imageView.hidden = YES;
        self.maskType = hudMaskType;
        
        [self setStatus:string];
        
        if (indicatorType == SVProgressHUDIndicatorTypeSpinner) {
            self.progressBarView.hidden = YES;
            self.spinnerView.hidden = NO;
            [self.spinnerView startAnimating];
        }
        else if (indicatorType == SVProgressHUDIndicatorTypeProgressBar) {
            self.spinnerView.hidden = YES;
            self.progressBarView.hidden = NO;
        }
        
        //        if(self.maskType != SVProgressHUDMaskTypeNone)
        //            self.userInteractionEnabled = NO;
        //        else
        //            self.userInteractionEnabled = YES
        //            ;
        
        [self.overlayWindow makeKeyAndVisible];
        [self positionHUD:nil];
        
        if(self.alpha != 1) {
            [self registerNotifications];
            self.hudView.transform = CGAffineTransformScale(self.hudView.transform, 1.3, 1.3);
            
            [UIView animateWithDuration:0.15
                                  delay:0
                                options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                                 self.hudView.transform = CGAffineTransformScale(self.hudView.transform, 1/1.3, 1/1.3);
                                 self.alpha = 1;
                             }
                             completion:NULL];
        }
        
        [self setNeedsDisplay];
    });
    
}

- (void)setFadeOutTimer:(NSTimer *)newTimer
{
    
    if(fadeOutTimer)
        [fadeOutTimer invalidate], fadeOutTimer = nil;
    
    if(newTimer)
        fadeOutTimer = newTimer ;
}


- (void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(positionHUD:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(positionHUD:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(positionHUD:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(positionHUD:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(positionHUD:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}


- (void)positionHUD:(NSNotification*)notification {
    
    CGFloat keyboardHeight;
    double animationDuration = 0.0;
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if(notification) {
        NSDictionary* keyboardInfo = [notification userInfo];
        CGRect keyboardFrame = [[keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        animationDuration = [[keyboardInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        if(notification.name == UIKeyboardWillShowNotification || notification.name == UIKeyboardDidShowNotification) {
            if(UIInterfaceOrientationIsPortrait(orientation))
                keyboardHeight = keyboardFrame.size.height;
            else
                keyboardHeight = keyboardFrame.size.width;
        } else
            keyboardHeight = 0;
    } else {
        keyboardHeight = self.visibleKeyboardHeight;
    }
    
    CGRect orientationFrame = [UIScreen mainScreen].bounds;
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    
    if(UIInterfaceOrientationIsLandscape(orientation)) {
        float temp = orientationFrame.size.width;
        orientationFrame.size.width = orientationFrame.size.height;
        orientationFrame.size.height = temp;
        
        temp = statusBarFrame.size.width;
        statusBarFrame.size.width = statusBarFrame.size.height;
        statusBarFrame.size.height = temp;
    }
    
    CGFloat activeHeight = orientationFrame.size.height;
    
    if(keyboardHeight > 0)
        activeHeight += statusBarFrame.size.height*2;
    
    activeHeight -= keyboardHeight;
    CGFloat posY = floor(activeHeight*0.45);
    CGFloat posX = orientationFrame.size.width/2;
    
    CGPoint newCenter;
    CGFloat rotateAngle;
    
    switch (orientation) {
        case UIInterfaceOrientationPortraitUpsideDown:
            rotateAngle = M_PI;
            newCenter = CGPointMake(posX, orientationFrame.size.height-posY);
            break;
        case UIInterfaceOrientationLandscapeLeft:
            rotateAngle = -M_PI/2.0f;
            newCenter = CGPointMake(posY, posX);
            break;
        case UIInterfaceOrientationLandscapeRight:
            rotateAngle = M_PI/2.0f;
            newCenter = CGPointMake(orientationFrame.size.height-posY, posX);
            break;
        default: // as UIInterfaceOrientationPortrait
            rotateAngle = 0.0;
            newCenter = CGPointMake(posX, posY);
            break;
    }
    
    if(notification) {
        [UIView animateWithDuration:animationDuration
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             [self moveToPoint:newCenter rotateAngle:rotateAngle];
                         } completion:NULL];
    }
    
    else {
        [self moveToPoint:newCenter rotateAngle:rotateAngle];
    }
    
}

- (void)moveToPoint:(CGPoint)newCenter rotateAngle:(CGFloat)angle {
    self.hudView.transform = CGAffineTransformMakeRotation(angle);
    self.hudView.center = newCenter;
}

#pragma mark - Touch handlers

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
	// if there is a mask, block propagation of all events
    //	if (self.maskType != SVProgressHUDMaskTypeNone) {
    //		return YES;
    //	}
	
	if (CGRectContainsPoint(self.hudView.frame, point)) {
        if(self.isDownloadingVideo && (!self.isDismissed || self.progress!=(CGFloat)1)){
            NSLog(@"progress when cancelled was at: %f", self.progress);
            //[URLConnection cancel];
            
            [[SVProgressHUD sharedView] dismissWithStatus:@"Video download\nCancelled" maskType:SVProgressHUDMaskTypeGradient error:YES afterDelay:1];
            
		}
        return YES;
	}
	
	return NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"TOUCHED ME");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"TOUCHED ME");
    
	if (self.hideOnTouch) {
		// hide the HUD when any touch has ended
		//self.fadeOutTimer = nil;
		//[self dismiss];
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
}



//- (void)showWithStatus:(NSString*)string maskType:(SVProgressHUDMaskType)hudMaskType networkIndicator:(BOOL)show {
//
//	self.fadeOutTimer = nil;
//
//    if(show)
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    else if(!show && self.showNetworkIndicator)
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//
//    self.showNetworkIndicator = show;
//
//    if(self.showNetworkIndicator)
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//
//	self.imageView.hidden = YES;
//    self.maskType = hudMaskType;
//
//	[self setStatus:string];
//	[self.spinnerView startAnimating];
//
//    if(self.maskType != SVProgressHUDMaskTypeNone)
//        self.userInteractionEnabled = NO;
//    else
//        self.userInteractionEnabled = YES;
//
//    [self.overlayWindow makeKeyAndVisible];
//    [self positionHUD:nil];
//
//	if(self.alpha != 1) {
//        [self registerNotifications];
//		self.hudView.transform = CGAffineTransformScale(self.hudView.transform, 1.3, 1.3);
//
//		[UIView animateWithDuration:0.15
//							  delay:0
//							options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
//						 animations:^{
//							 self.hudView.transform = CGAffineTransformScale(self.hudView.transform, 1/1.3, 1/1.3);
//                             self.alpha = 1;
//						 }
//						 completion:NULL];
//	}
//
//    [self setNeedsDisplay];
//}

- (void)dismissWithStatus:(NSString*)string error:(BOOL)error afterDelay:(NSTimeInterval)seconds
{
    
}

- (void)dismissWithStatus:(NSString*)string error:(BOOL)error {
	[self dismissWithStatus:string maskType:SVProgressHUDMaskTypeNone error:error afterDelay:0.9];
}


- (void)dismissWithStatus:(NSString*)string maskType:(SVProgressHUDMaskType)_maskType error:(BOOL)error {
    [self dismissWithStatus:string maskType:_maskType error:error afterDelay:0.9];
}


- (void)dismissWithStatus:(NSString *)string maskType:(SVProgressHUDMaskType)_maskType error:(BOOL)error afterDelay:(NSTimeInterval)seconds {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.isDismissed = YES;
        if(self.alpha != 1)
            return;
        
        if(self.showNetworkIndicator)
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if(error)
            self.imageView.image = [UIImage imageNamed:@"SVProgressHUD.bundle/error.png"];
        else
            self.imageView.image = [UIImage imageNamed:@"SVProgressHUD.bundle/success.png"];
        
        self.imageView.hidden = NO;
        
        [self setStatus:string];
        
        [self.spinnerView stopAnimating];
        
        self.progressBarView.hidden = YES;
        
        self.maskType = _maskType;
        
        
        //        if(self.maskType != SVProgressHUDMaskTypeNone)
        //            self.userInteractionEnabled = NO;
        //        else
        //            self.userInteractionEnabled = YES
        //            ;
        
        
        self.fadeOutTimer = [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
    });
}

- (void)dismiss {
	dispatch_async(dispatch_get_main_queue(), ^{
        if(self.showNetworkIndicator)
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        [UIView animateWithDuration:0.15
                              delay:0
                            options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             sharedView.hudView.transform = CGAffineTransformScale(sharedView.hudView.transform, 0.8, 0.8);
                             sharedView.alpha = 0;
                         }
                         completion:^(BOOL finished){
                             if(sharedView.alpha == 0) {
                                 [[NSNotificationCenter defaultCenter] removeObserver:sharedView];
                                 overlayWindow = nil;
                                 sharedView = nil;
                                 
                                 // find the frontmost window that is an actual UIWindow and make it keyVisible
                                 [[UIApplication sharedApplication].windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id window, NSUInteger idx, BOOL *stop) {
                                     if([window isMemberOfClass:[UIWindow class]]) {
                                         [window makeKeyWindow];
                                         *stop = YES;
                                     }
                                 }];
                                 
                                 // uncomment to make sure UIWindow is gone from app.windows
                                 //NSLog(@"%@", [UIApplication sharedApplication].windows);
                                 //NSLog(@"keyWindow = %@", [UIApplication sharedApplication].keyWindow);
                             }
                         }];
    });
    
}

#pragma mark - Utilities

+ (BOOL)isVisible {
    return ([SVProgressHUD sharedView].alpha == 1);
}

#pragma mark - Getters

- (UIWindow *)overlayWindow {
    if(!overlayWindow) {
        overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayWindow.backgroundColor = [UIColor clearColor];
        overlayWindow.userInteractionEnabled = YES;
    }
    return overlayWindow;
}

- (UIView *)hudView {
    if(!hudView) {
        hudView = [[UIView alloc] initWithFrame:CGRectZero];
        hudView.layer.cornerRadius = 10;
		hudView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        hudView.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin |
                                    UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin);
        
        [self addSubview:hudView];
    }
    return hudView;
}

- (UILabel *)stringLabel {
    if (stringLabel == nil) {
        stringLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		stringLabel.textColor = [UIColor whiteColor];
		stringLabel.backgroundColor = [UIColor clearColor];
		stringLabel.adjustsFontSizeToFitWidth = YES;
		stringLabel.textAlignment = NSTextAlignmentCenter;
		stringLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		stringLabel.font = [UIFont boldSystemFontOfSize:16];
		stringLabel.shadowColor = [UIColor blackColor];
		stringLabel.shadowOffset = CGSizeMake(0, -1);
        stringLabel.numberOfLines = 0;
		[self.hudView addSubview:stringLabel];
    }
    return stringLabel;
}

- (UIImageView *)imageView {
    if (imageView == nil) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
		[self.hudView addSubview:imageView];
    }
    return imageView;
}

- (UIActivityIndicatorView *)spinnerView {
    if (spinnerView == nil) {
        spinnerView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		spinnerView.hidesWhenStopped = YES;
		spinnerView.bounds = CGRectMake(0, 0, 37, 37);
		[self.hudView addSubview:spinnerView];
    }
    return spinnerView;
}

- (SVProgressBarView *)progressBarView {
    
    if (progressBarView == nil) {
        progressBarView = [[SVProgressBarView alloc] init];
		[self.hudView addSubview:progressBarView];
    }
    
    return progressBarView;
}

- (CGFloat)visibleKeyboardHeight {
    
    //NSAutoreleasePool *autoreleasePool = [[NSAutoreleasePool alloc] init];
    
    UIWindow *keyboardWindow = nil;
    for (UIWindow *testWindow in [[UIApplication sharedApplication] windows]) {
        if(![[testWindow class] isEqual:[UIWindow class]]) {
            keyboardWindow = testWindow;
            break;
        }
    }
    
    // Locate UIKeyboard.
    UIView *foundKeyboard = nil;
    /*for (UIView *possibleKeyboard in [keyboardWindow subviews])
    {
        
        // iOS 4 sticks the UIKeyboard inside a UIPeripheralHostView.
        if ([[possibleKeyboard description] hasPrefix:@"<UIPeripheralHostView"])
        {
            possibleKeyboard = [[possibleKeyboard subviews] objectAtIndex:0];
        }
        
        if ([[possibleKeyboard description] hasPrefix:@"<UIKeyboard"])
        {
            foundKeyboard = possibleKeyboard;
            break;
        }
    }*/
    
    
    if(foundKeyboard && foundKeyboard.bounds.size.height > 100)
        return foundKeyboard.bounds.size.height;
    
    return 0;
}

@end

#pragma mark - SVProgressBarView Implementation

@implementation SVProgressBarView
@dynamic progress;

- (id)init {
    self = [super init];
    
    if (self) {
        self.progress = 0.0f;
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setProgress:(CGFloat)newProgress {
    progress = newProgress;
    [self setNeedsDisplay];
}

- (CGFloat)progress {
    return progress;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // draw the "container"
    CGRect rrect = CGRectInset(self.bounds, 2, 2);
    CGFloat radius = 8;
    CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
    CGContextMoveToPoint(ctx, minx, midy);
    CGContextAddArcToPoint(ctx, minx, miny, midx, miny, radius);
    CGContextAddArcToPoint(ctx, maxx, miny, maxx, midy, radius);
    CGContextAddArcToPoint(ctx, maxx, maxy, midx, maxy, radius);
    CGContextAddArcToPoint(ctx, minx, maxy, minx, midy, radius);
    CGContextClosePath(ctx);
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    CGContextSetLineWidth(ctx, 2);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    // draw the actual bar
    radius = 5;
    rrect = CGRectInset(rrect, 3, 3);
    rrect.size.width = rrect.size.width * (progress == 0.0 || progress >= 0.055 ? progress : 0.055); // progress bar looks funny for values > 0 but less than 0.055
    minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
    miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
    CGContextMoveToPoint(ctx, minx, midy);
    CGContextAddArcToPoint(ctx, minx, miny, midx, miny, radius);
    CGContextAddArcToPoint(ctx, maxx, miny, maxx, midy, radius);
    CGContextAddArcToPoint(ctx, maxx, maxy, midx, maxy, radius);
    CGContextAddArcToPoint(ctx, minx, maxy, minx, midy, radius);
    CGContextClosePath(ctx);
    CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);
    CGContextDrawPath(ctx, kCGPathFill);
}


@end

