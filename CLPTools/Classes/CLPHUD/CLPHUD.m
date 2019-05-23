//
//  CLPHUD.m
//  Pods
//
//  Created by clapn on 16/9/12.
//
//

#import "CLPHUD.h"
#import "CLPToolsInterface.h"
#define IsStrEmptyReturn(_ref) ( (IsStrEmpty(_ref))?@"":_ref)
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))


@interface CLPHUD ()

@property (nonatomic, readwrite) CLPProgressHuDMaskType maskType;
@property (nonatomic, strong, readonly) NSTimer *fadeOutTimer;

@property (nonatomic, strong, readonly) UIWindow *overlayWindow;
@property (nonatomic, strong, readonly) UIView *hudView;
@property (nonatomic, strong, readonly) UILabel *stringLabel;
@property (nonatomic, strong, readonly) UIImageView *imageView;
@property (nonatomic, strong, readonly) UIActivityIndicatorView *spinnerView;

@property (nonatomic, readonly) CGFloat visibleKeyboardHeight;

- (void)showWithStatus:(NSString*)string maskType:(CLPProgressHuDMaskType)hudMaskType networkIndicator:(BOOL)show;
- (void)setStatus:(NSString*)string;
- (void)registerNotifications;
- (void)moveToPoint:(CGPoint)newCenter rotateAngle:(CGFloat)angle;
- (void)positionHUD:(NSNotification*)notification;

- (void)dismiss;
- (void)dismissWithStatus:(NSString*)string stateFlag:(CLPHUDStateFlag)stateFlag;
- (void)dismissWithStatus:(NSString *)string stateFlag:(CLPHUDStateFlag)stateFlag afterDelay:(NSTimeInterval)seconds;
@end


@implementation CLPHUD


static UIImage *HUDErrorIma = nil;
static UIImage *HUDSuccessIma = nil;
static UIImage *HUDInfoIma = nil;


static NSString *HUDErrorImaStr = @"iVBORw0KGgoAAAANSUhEUgAAADgAAAA4CAYAAACohjseAAAAAXNSR0IArs4c6QAAAAlwSFlzAAAWJQAAFiUBSVIk8AAAABxpRE9UAAAAAgAAAAAAAAAcAAAAKAAAABwAAAAcAAACCoRDBkMAAAHWSURBVGgF1FWLsYMwDOsoGaEjMAqjsAEjeISOkBEYgRHeCDypRzhoycfBpdR3PkKwZCkJcLsZxzRNDtkiBemRufAoECQxzliODR2FIXvkiDwaIwjI9X2zENEgPfJT4UHc2GyDggVN70g2Pys8Gt0VEutL0ag7y9VOn65eeQaJZnzPhp2mZ09Rg8vI1T0GId+1v7OdJPpRS6NzEakGUZto9O1HbUR22fTFzYXFrTMJNI/lr0RTtmVzFVzxN3Cldy630NRa/htB8ZBjvODzoWgXIby7oPhSSV3SJFh4NH894kcVzrzS3QP1Lqwax0jO1YYFnw96Nlco0n41HxuC1Q24pMKhrCg2Q3BpF63ZEPAGJF4pyr2RrCbAJQq+qDlSgocnQxPbXQRSSzCtvESH4JUCVUlzgbyA57XEBSxXqH99mrtfwJkBeCTBVWSOLRIcsUf9Ig0VY6wqMe8WgswAHLLDozGnPmHoNz5lYVADpt7oR2bPL+qFoDmKzZELGO1HJvRxBLfhruKqFSroUYOpkPaEtDQotegZpxK8t7uxORNtIPGz0CMXc5MQI0cEzVjPHbQKM5MQJFaiLA1S02GT5CCRVVgbpK5qk8SSwDI+YZD61CaJIdA6/gEAAP//Qe+6agAAAcBJREFU1ZUNEYMwDIWRUgmTgBSk4AAJkTAJlYAEJEwCe9lWoKyUhqZj9C7XUpKX9/FbjWUGVcIBG1TCSlVAVAznrkUJSG3Aw3ClIDUBs+FKQDKgVXhM1eCUIS0DUiagOpwiJDFgkwEogkMf4nAAKfOnBtOh0TCgOVQ6jvcUgy4HPWjRRwp5X9RKlubVHxWDpOqT+y52BJEZ+RTQT4ZE7ZGbMEyWINAFDES3puKdBUQoIiSBjMgET3WTNZwWX6GpOLKALgVb+5tJkH5J0pHxrKHEJpXNSb6Ap1bxu01z6u4qColq6Q2wKzsvQ/WuDT9h8yODNPJTk442IVEt/cjUX4C8ASGbZGVO4sbGifEaITUzq71rc/W+797C4G3Z7aLrm+MJzoBqLwrGttsg1HoTif0FIfs1x+Yx4PhRfVwIkr3GH801LQqkX9Uzr0e99p90DMfNma4TezdJMFtJfw6ZB+egAcmP6z+9k+yldv5UZggaRI84e7AHowIVEoF4eyJhG/KkvgdA/o3YH4JyL9lvQIMaTfnd5OalhoVwreE1SwMm+P3sEAMidwwQYC2TZapUMRtDNAhCWMTesEggBNeoQz0BMsokyWdeu7QAAAAASUVORK5CYII=";

static NSString *HUDSuccessImaStr = @"iVBORw0KGgoAAAANSUhEUgAAADgAAAA4CAYAAACohjseAAAAAXNSR0IArs4c6QAAAAlwSFlzAAAWJQAAFiUBSVIk8AAAABxpRE9UAAAAAgAAAAAAAAAcAAAAKAAAABwAAAAcAAACBo31SmgAAAHSSURBVGgFzFUBtcMgDJyESUDCJCAFJ6uDSUDCJCChEpDwJfTf7T3adQ0tMCjLe3mjIZfcNXRcLpVtmiYFN3ALd/Ajc0iwcGJUZTp1ypEY/AH38G/NowBr9RcLEhru4K3MobCuM4aMKmh6g7P5WebQ6JZBsTwVjYazVAl9hnLmB0g043c2Ck3PDpGDOqCbt42C/Nb+zlay049cdJ6KSDYKmZ1GvbdMhHZa+MfFhZdbJhJoHsue9kRzFUbBNZwxyXTIS/pFBV4DPb+5Z4woeEkiyTX9GkHyCO9lJKt2BHKSko0xzCoO5CChT4zdV4SEhx0ug5C+hADk0expHs2vCyN5dUAwflQBdAfg1ttGlrREQSB2RAM3t2S/rbCrQ0anX5nYG0cuwc0m8NMfsBfQJQBbpmxJfbBE89QhrF8WgEdjbymMte2HFvEReY7JiabmIgA8EkEt0navhUASjU1m80fA8lz7THDN9PtMJLJAsyvcZzb1r3IA9TyeJJ1yLdyRV2KK08sdfUmjGMZEhjaHAeQAeIxLzFCgLUFWwKz/6WZJ68WX/CwFugpkS0rotZTtE4rqksJvGEeBPazFtSDq6CGw1bXwMwJbXQs/IdCDRctrYSPyHwAA//9CJuSGAAACBUlEQVTVVwuVwyAQjIRKQMJJQMJJwEnioBKQUAlIqIRIqITezB2b16QQvml7+96+BbI7O5NA0g73NrMoH71znDIzJAwACn5LAeVeH3ITN3kk8LXlyjV4jJzb5ofmqLfwblYr0ITIcQ3MYiJ1rEbWUau7KfNAVQKFUCwGRNpY7uM66pzn1S1QYDHoI6nYGLjfniW3rIrlyTpyjM/vGRwF2lJEIZWKwCXpMSPvhLwZ3tssBdbcOZMiXXIdHMbeyjyeoUBVAR58i5aIklzfP/bmraC2KlG/fbA0r5bzJl1EopXNa1ecNctN5FM8F5f/FVwRTgtQ4QC1urJvTtl5oYPsmm0qTapFAsAJyAFRLQI5aGxWLBL9zAGiBPL5VxOutG6XbJHoddRnQQTq1dOTCa46yaiMF8Hai8AeK/Fzyp6fnpBBNX9HtpoVvFAEOM/7rbXJTv3Tn4AVDxROO8W5l6IiAXDJBanIm1ZiYhMA8zy1GoUo6cEx/EhxV+mVjCDCrXqD/xcj1/2tuVWNgta36itvjt7yz5qDoXkly8peJktMLOnDRbaJE9EQye36SWeSXLTw6xIByLfgFf5uIwfVRVQIBODTGxVOIU7d1yCQnxH3QqHsVfYZ6KEaTXk22fwocwDWPbg2YYAEz+cZPsNbbQYAsVQTqaOKSQxu4Bbu4ClzSLBw1nQX9QNh99O5S4BwpwAAAABJRU5ErkJggg==";

static NSString *HUDInfoImaStr = @"iVBORw0KGgoAAAANSUhEUgAAAEAAAAA1CAYAAADxhu2sAAAAAXNSR0IArs4c6QAAAAlwSFlzAAAWJQAAFiUBSVIk8AAAABxpRE9UAAAAAgAAAAAAAAAbAAAAKAAAABsAAAAaAAACPm5EFtQAAAIKSURBVGgFzJe/LgRRFMaXDdtsNhoSGpLtSSgpxBOwiXgDCmoKnsCfQijUvAEJT0AhKpEQpVASEqIg1u8kM5GdzJ1zVube2Zt8mZl7zv3O78tO2C2VCljNZrMX7aDnSJuyVwBKMSMJe4CSa78YmsBTST2FfpLpo73JwDhhxxGyB92khI+3rqUnLFXAaYRbi5NmXFcDIoUbReAR9JERPC69czMcjizQJEKdxAkN1+NAWGHGEHjOEDrZMhuGzvMUUlXRQzKd4VnOVD3j+bcnxLYhrKtlyz+hxwmkGkNfrnSGfTk76hHRnzXg3ejCEFJrOaehyx+pJ2egl7RkbdQXPWH6sSXYAHrJCHhPrYFqkeRe9lxLfjT1+6H14ArskSsJ+3eoLzlW9qIal9R1mDzTkc+gz6C0HztxqoYLnAZ5E1xLPKddZztiH8AKkk84a9VcsByS7wxZ65ZixXW+8H3gNrLopaZBauepr2sehdQBq6NPLYAGp52PZtQ1n+B1wM4M8Hm8ATLmNHjArIEALVjCS0+Wj9SsPvTNa15B6oDI//InK7gGZfWh7xE5/6Bqc3KrA7HXBnSeb4CM3c0tyH+MAJhA30JiXdocq0/UJ7PHNU8vdQaX0VUEYr5oMGajv8ZLbsuab+51hq78MdjvNBC7U0vnsuaba53RQ+itBcH4oIEYbZJtr2wMat5p9V8AAAD//2dkvwEAAAH5SURBVN1YTUrDQBRuoZRStChd6lpBDyBewIW4cqsbvUFvIC6kSxVEb9CN3kAX4gFcKgq6VWpVcCOCxO/TiUmbzEya+Qlk4JHJe2++n2kTpq1UcowgCHqIXENHlwv0b1FPh22lDq4VA5GBToQJNrXp8I3qIGgg7k1E6gSYYGPtHaKh48hdB/iuoUDX3wDK28ltULUQwPOITzKYDBUHaybYYi01zul4xqoDsIq4EASml5aMHMATpuBi/bmMI1ceoJuWhBFmXSaCNYs8GzKesfIQNI14tijsBlhToyKYQ7BmazwBKMEzyqu9B8iJLUUxnFvM+WlPiuCcOdvjWGtQ1QA1y4hv26o84lH7ksqjtIaFNcS1R7GuqOihJjUqK2BRx5WiAnA7Mp+peQicRXw4FMoTG5/7lgjOmXM16GUm1WxaEs1nrpQAly+7xNuZOVHDxck4TfOayIF6zQl9BOrrHBAxRrPVhOF4An1NxGPU72Tm4yQoE/6AQjPueWiOYle20mK+yA2gjb0h0+ENCouIL3Y4HkU+ArRGjwuh798rEvyxc4XwMXwdhVVeLlGs/m8CbrZV3Q5qvo7CKulb4affRteLqrOktT58tfkHxFFJDWaxdcgNeM/SWdKePjdgUFJzWWwNuAH7WTpL2tPlBtQRB4jXkppMs/UmPNd/AIBbdr8yXNwsAAAAAElFTkSuQmCC";


+(void ) CLPHUDSuccess :(NSString *)msgs
{
    [CLPHUD showSuccessWithStatus: msgs];
}

+(void ) CLPHUDError :(NSString *)msgs
{
    [CLPHUD showErrorWithStatus:msgs ];
}


/** 感叹号信息状态显示 */
+(void ) CLPHUDInfo :(NSString *)msgs
{
}

+(void ) CLPHUDHidden
{
    [CLPHUD dismiss];
}

+(void ) CLPHUDActivity :(NSString *)msg
{
    [CLPHUD showWithStatus:msg];
}





@synthesize overlayWindow, hudView, maskType, fadeOutTimer, stringLabel, imageView, spinnerView, visibleKeyboardHeight;


- (void)dealloc {
    self.fadeOutTimer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


+ (CLPHUD*)sharedView {
    static dispatch_once_t once;
    static CLPHUD *sharedView;
    dispatch_once(&once, ^ { sharedView = [[CLPHUD alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
    return sharedView;
}


+ (void)setStatus:(NSString *)string {
    [[CLPHUD sharedView] setStatus:IsStrEmptyReturn(string)];
}

#pragma mark - Show Methods

+ (void)show {
    [[CLPHUD sharedView] showWithStatus:nil maskType:CLPProgressHuDMaskTypeNone networkIndicator:NO];
}

+ (void)showWithStatus:(NSString *)status {
    [[CLPHUD sharedView] showWithStatus:IsStrEmptyReturn(status) maskType:CLPProgressHuDMaskTypeNone networkIndicator:NO];
}

+ (void)showWithMaskType:(CLPProgressHuDMaskType)maskType {
    [[CLPHUD sharedView] showWithStatus:nil maskType:maskType networkIndicator:NO];
}

+ (void)showWithStatus:(NSString*)status maskType:(CLPProgressHuDMaskType)maskType {
    [[CLPHUD sharedView] showWithStatus:IsStrEmptyReturn(status) maskType:maskType networkIndicator:NO];
}

+ (void)showSuccessWithStatus:(NSString *)string {
    [CLPHUD showSuccessWithStatus:IsStrEmptyReturn(string) duration:1];
}

+ (void)showSuccessWithStatus:(NSString *)string duration:(NSTimeInterval)duration {
    [CLPHUD show];
    [CLPHUD dismissWithSuccess:IsStrEmptyReturn(string) afterDelay:duration];
}

+ (void)showErrorWithStatus:(NSString *)string {
    [CLPHUD showErrorWithStatus:IsStrEmptyReturn(string) duration:1];
}

+ (void)showErrorWithStatus:(NSString *)string duration:(NSTimeInterval)duration {
    [CLPHUD show];
    [CLPHUD dismissWithError:IsStrEmptyReturn(string) afterDelay:duration];
}


+ (void)showInfoWithStatus:(NSString *)string {
    [CLPHUD showInfoWithStatus:IsStrEmptyReturn(string) duration:1];
}

+ (void)showInfoWithStatus:(NSString *)string duration:(NSTimeInterval)duration {
    [CLPHUD show];
    [CLPHUD dismissWithInfo:IsStrEmptyReturn(string) afterDelay:duration];
}



#pragma mark - Dismiss Methods

+ (void)dismiss {
    [[CLPHUD sharedView] dismiss];
}

+ (void)dismissWithSuccess:(NSString*)successString {
    [[CLPHUD sharedView] dismissWithStatus:IsStrEmptyReturn(successString) stateFlag:CLPHUDSuccessStateFlag];
}

+ (void)dismissWithSuccess:(NSString *)successString afterDelay:(NSTimeInterval)seconds {
    [[CLPHUD sharedView] dismissWithStatus:IsStrEmptyReturn(successString) stateFlag:CLPHUDSuccessStateFlag afterDelay:seconds];
}

+ (void)dismissWithError:(NSString*)errorString {
    [[CLPHUD sharedView] dismissWithStatus:IsStrEmptyReturn(errorString) stateFlag:CLPHUDErrorStateFlag];
}

+ (void)dismissWithError:(NSString *)errorString afterDelay:(NSTimeInterval)seconds {
    [[CLPHUD sharedView] dismissWithStatus:IsStrEmptyReturn(errorString) stateFlag:CLPHUDErrorStateFlag afterDelay:seconds];
}


+ (void)dismissWithInfo:(NSString*)infoString {
    [[CLPHUD sharedView] dismissWithStatus:IsStrEmptyReturn(infoString) stateFlag:CLPHUDInfoStateFlag];
}

+ (void)dismissWithInfo:(NSString *)infoString afterDelay:(NSTimeInterval)seconds {
    [[CLPHUD sharedView] dismissWithStatus:IsStrEmptyReturn(infoString) stateFlag:CLPHUDInfoStateFlag afterDelay:seconds];
}

#pragma mark - Instance Methods

- (id)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        HUDErrorIma =  [[CLPToolsInterface SharedInstance] CLPbase64ToImage:HUDErrorImaStr];
        HUDSuccessIma =  [[CLPToolsInterface SharedInstance] CLPbase64ToImage:HUDSuccessImaStr];
        HUDInfoIma =  [[CLPToolsInterface SharedInstance] CLPbase64ToImage:HUDInfoImaStr];

    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    switch (self.maskType) {
            
        case CLPProgressHuDMaskTypeBlack : {
            [[UIColor colorWithWhite:0 alpha:0.5] set];
            CGContextFillRect(context, self.bounds);
            break;
        }
            
        case CLPProgressHuDMaskTypeGradient : {
            
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

- (void)setStatus:(NSString *)string {
    
    CGFloat hudWidth = 100;
    CGFloat hudHeight = 100;
    CGFloat stringWidth = 0;
    CGFloat stringHeight = 0;
    CGRect labelRect = CGRectZero;
    
    if(string) {
        CGSize stringSize = [string sizeWithFont:self.stringLabel.font constrainedToSize:CGSizeMake(200, 300)];
        stringWidth = stringSize.width;
        stringHeight = stringSize.height;
        hudHeight = 80+stringHeight;
        
        if(stringWidth > hudWidth)
            hudWidth = ceil(stringWidth/2)*2;
        
        if(hudHeight > 100) {
            labelRect = CGRectMake(12, 66, hudWidth, stringHeight);
            hudWidth+=24;
        } else {
            hudWidth+=24;
            labelRect = CGRectMake(0, 66, hudWidth, stringHeight);
        }
    }
    
    self.hudView.bounds = CGRectMake(0, 0, hudWidth, hudHeight);
    
    if(string)
        self.imageView.center = CGPointMake(CGRectGetWidth(self.hudView.bounds)/2, 36);
    else
       	self.imageView.center = CGPointMake(CGRectGetWidth(self.hudView.bounds)/2, CGRectGetHeight(self.hudView.bounds)/2);
    
    self.stringLabel.hidden = NO;
    self.stringLabel.text = string;
    self.stringLabel.frame = labelRect;
    
    if(string)
        self.spinnerView.center = CGPointMake(ceil(CGRectGetWidth(self.hudView.bounds)/2)+0.5, 40.5);
    else
        self.spinnerView.center = CGPointMake(ceil(CGRectGetWidth(self.hudView.bounds)/2)+0.5, ceil(self.hudView.bounds.size.height/2)+0.5);
}

- (void)setFadeOutTimer:(NSTimer *)newTimer {
    
    if(fadeOutTimer)
        [fadeOutTimer invalidate], fadeOutTimer = nil;
    
    if(newTimer)
        fadeOutTimer = newTimer;
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
    double animationDuration;
    
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

#pragma mark - Master show/dismiss methods

- (void)showWithStatus:(NSString*)string maskType:(CLPProgressHuDMaskType)hudMaskType networkIndicator:(BOOL)show {
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!self.superview)
            [self.overlayWindow addSubview:self];
        
        self.fadeOutTimer = nil;
        self.imageView.hidden = YES;
        self.maskType = hudMaskType;
        
        [self setStatus:IsStrEmptyReturn(string)];
        [self.spinnerView startAnimating];
        
        if(self.maskType != CLPProgressHuDMaskTypeNone ) {
            self.overlayWindow.userInteractionEnabled = YES;
        } else {
            self.overlayWindow.userInteractionEnabled = NO;
        }
        
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


- (void)dismissWithStatus:(NSString*)string stateFlag:(CLPHUDStateFlag)stateFlag {
    [self dismissWithStatus:IsStrEmptyReturn(string) stateFlag:stateFlag afterDelay:0.9];
}


- (void)dismissWithStatus:(NSString *)string stateFlag:(CLPHUDStateFlag)stateFlag afterDelay:(NSTimeInterval)seconds {
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.alpha != 1)
            return;
        //        NSString * bundlePathMid = [[ NSBundle mainBundle] pathForResource:@"MiddlewareResource" ofType :@"bundle"];
//        NSLog(@"%@",   [[CLPToolsInterface SharedInstance] CLPbase64ToImage:HUDErrorImaStr]);
//        NSLog(@"%@",   [UIImage imageNamed:@"error"]);
//
//        
//        NSLog(@"%@",    [UIImage imageNamed:@"error.png" inBundle:[NSBundle bundleForClass:self.class]
//            compatibleWithTraitCollection:nil]);
//        NSLog(@"%@",    [UIImage imageNamed:@"error" inBundle:[NSBundle bundleForClass:self.class]
//              compatibleWithTraitCollection:nil]);
        
        switch (stateFlag) {
            case CLPHUDErrorStateFlag:
            {
                self.imageView.image = HUDErrorIma;
             }
                break;
            case CLPHUDSuccessStateFlag:
            {
                self.imageView.image =HUDSuccessIma;
            }
                break;
            case CLPHUDInfoStateFlag:
            {
                self.imageView.image = HUDInfoIma;
            }
                break;
                
            default:
                break;
        }
      
  /*
        
        if(error)
        {
            //            NSString *imgPath= [bundlePathMid stringByAppendingPathComponent :@"/Contents/Resources/error.tiff"];
            //            self.imageView.image =[UIImage imageWithContentsOfFile:imgPath];
            
            //            self.imageView.image= [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"error" ofType:@"tiff"]];
            
           self.imageView.image = [UIImage imageNamed:@"error.tiff" inBundle:[NSBundle bundleForClass:self.class]
  compatibleWithTraitCollection:nil];
            
            //            self.imageView.image = [UIImage imageNamed:@"MiddlewareResource.bundle/Contents/Resources/error.tiff"];
        }
        else
        {
            //            NSString *imgPath= [bundlePathMid stringByAppendingPathComponent :@"/Contents/Resources/success.tiff"];
            //            self.imageView.image =[UIImage imageWithContentsOfFile:imgPath];
            //            self.imageView.image= [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"success" ofType:@"tiff"]];
            
            //            self.imageView.image= [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"success" ofType:@"tiff"]];
            
           self.imageView.image = [UIImage imageNamed:@"success.tiff" inBundle:[NSBundle bundleForClass:self.class]
  compatibleWithTraitCollection:nil];

//            self.imageView.image = [UIImage imageNamed:@"MiddlewareResource.bundle/Contents/Resources/success.tiff"];
            
        }
        
        
        */
        self.imageView.hidden = NO;
        [self setStatus:IsStrEmptyReturn(string)];
        [self.spinnerView stopAnimating];
        
        self.fadeOutTimer = [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
    });
}

- (void)dismiss {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.15
                              delay:0
                            options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             self.hudView.transform = CGAffineTransformScale(self.hudView.transform, 0.8, 0.8);
                             self.alpha = 0;
                         }
                         completion:^(BOOL finished){
                             if(self.alpha == 0) {
                                 [[NSNotificationCenter defaultCenter] removeObserver:self];
                                 [hudView removeFromSuperview];
                                 hudView = nil;
                                 
                                 // Make sure to remove the overlay window from the list of windows
                                 // before trying to find the key window in that same list
                                 NSMutableArray *windows = [[NSMutableArray alloc] initWithArray:[UIApplication sharedApplication].windows];
                                 [windows removeObject:overlayWindow];
                                 overlayWindow = nil;
                                 
                                 [windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIWindow *window, NSUInteger idx, BOOL *stop) {
                                     if([window isKindOfClass:[UIWindow class]] && window.windowLevel == UIWindowLevelNormal) {
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
    return ([CLPHUD sharedView].alpha == 1);
}


#pragma mark - Getters

- (UIWindow *)overlayWindow {
    if(!overlayWindow) {
        overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayWindow.backgroundColor = [UIColor clearColor];
        overlayWindow.userInteractionEnabled = NO;
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
        stringLabel.textAlignment = UITextAlignmentCenter;
        stringLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        stringLabel.font = [UIFont boldSystemFontOfSize:16];
        stringLabel.shadowColor = [UIColor blackColor];
        stringLabel.shadowOffset = CGSizeMake(0, -1);
        stringLabel.numberOfLines = 0;
    }
    
    if(!stringLabel.superview)
        [self.hudView addSubview:stringLabel];
    
    return stringLabel;
}

- (UIImageView *)imageView {
    if (imageView == nil)
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    
    if(!imageView.superview)
        [self.hudView addSubview:imageView];
    
    return imageView;
}

- (UIActivityIndicatorView *)spinnerView {
    if (spinnerView == nil) {
        spinnerView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinnerView.hidesWhenStopped = YES;
        spinnerView.bounds = CGRectMake(0, 0, 37, 37);
    }
    
    if(!spinnerView.superview)
        [self.hudView addSubview:spinnerView];
    
    return spinnerView;
}

- (CGFloat)visibleKeyboardHeight {
    
    UIWindow *keyboardWindow = nil;
    for (UIWindow *testWindow in [[UIApplication sharedApplication] windows]) {
        if(![[testWindow class] isEqual:[UIWindow class]]) {
            keyboardWindow = testWindow;
            break;
        }
    }
    
    // Locate UIKeyboard.
    UIView *foundKeyboard = nil;
    for (__strong UIView *possibleKeyboard in [keyboardWindow subviews]) {
        
        // iOS 4 sticks the UIKeyboard inside a UIPeripheralHostView.
        if ([[possibleKeyboard description] hasPrefix:@"<UIPeripheralHostView"]) {
            possibleKeyboard = [[possibleKeyboard subviews] objectAtIndex:0];
        }
        
        if ([[possibleKeyboard description] hasPrefix:@"<UIKeyboard"]) {
            foundKeyboard = possibleKeyboard;
            break;
        }
    }
    
    if(foundKeyboard && foundKeyboard.bounds.size.height > 100)
        return foundKeyboard.bounds.size.height;
    
    return 0;
}




@end

