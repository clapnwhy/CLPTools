//
//  CLPBadge.h
//  Pods
//
//  Created by 曹郎鹏 on 16/8/31.
//
//

#import <UIKit/UIKit.h>

@interface CLPBadge : UIView
@property (strong, nonatomic) NSString *badgeText;
@property (strong, nonatomic) UIColor *badgeTextColor;
@property (strong, nonatomic) UIColor *badgeInsetColor;
@property (strong, nonatomic) UIColor *badgeFrameColor;

@property (assign, nonatomic) BOOL badgeFrame;
@property (assign, nonatomic) BOOL badgeShining;
@property (assign, nonatomic) BOOL badgeShadow;

@property (assign, nonatomic) CGFloat badgeCornerRoundness;
@property (assign, nonatomic) CGFloat badgeScaleFactor;

+ (CLPBadge *)customBadgeWithString:(NSString *)badgeString;

+ (CLPBadge *)customBadgeWithString:(NSString *)badgeString
                         withStringColor:(UIColor*)stringColor
                          withInsetColor:(UIColor*)insetColor
                          withBadgeFrame:(BOOL)badgeFrameYesNo
                     withBadgeFrameColor:(UIColor*)frameColor
                               withScale:(CGFloat)scale
                             withShining:(BOOL)shining
                              withShadow:(BOOL)shadow;

// Use to change the badge text after the first rendering
- (void)autoBadgeSizeWithString:(NSString *)badgeString;


@end
