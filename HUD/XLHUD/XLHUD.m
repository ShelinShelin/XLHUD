//
//  XLHUD.m
//  HUD
//
//  Created by Shelin on 16/7/25.
//  Copyright © 2016年 GreatGate. All rights reserved.
//

#import "XLHUD.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define HUD_BG_COLOR [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.00f]
#define ANIMATION_DURATION 0.3f
#define SHOW_DURATION 0.5f

static CGFloat const kDefaultWidth = 240.0f;
static CGFloat const kDefaultHeight = 80.0f;
static CGFloat const kDefaultRound = 9.0f;
static CGFloat const kDefaultTextFont = 16.0f;
static CGFloat const kDefaultMagin = 20.0f;

#pragma mark - XLHUDView

@interface XLHUDView : UIView {
    BOOL _isCustomHUD;
}

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *customView;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *text;


- (instancetype)initWithImage:(UIImage *)image text:(NSString *)text;

- (instancetype)initWithText:(NSString *)text;

- (instancetype)initWithCustomView:(UIView *)customView;

- (void)hidenHUD;

- (void)presentWithAnimationDuration:(CGFloat)animationDuration
                        showDuration:(CGFloat)showDuration;

@end

@implementation XLHUDView

#pragma mark - init

- (instancetype)initWithImage:(UIImage *)image text:(NSString *)text {
    if (self = [super initWithFrame:[self defaultFrame]]) {
        
        _isCustomHUD = NO;
        
        //cover View
        _coverView = [[UIView alloc] init];
        _coverView.frame = [UIScreen mainScreen].bounds;
        _coverView.backgroundColor = [UIColor clearColor];
        
        //HUD View
        _image = image;
        _text = text;
        self.backgroundColor = HUD_BG_COLOR;
        
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.userInteractionEnabled = YES;
        _imageView.contentMode = UIViewContentModeCenter;
        _imageView.image = image;
        [self addSubview:_imageView];
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.userInteractionEnabled = YES;
        _textLabel.font = [UIFont systemFontOfSize:kDefaultTextFont];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.numberOfLines = 0;
        _textLabel.text = text;
        [self addSubview:_textLabel];
        
        [_coverView addSubview:self];
        [[self getKeyWindow] addSubview:_coverView];
    }
    return self;
}

- (instancetype)initWithText:(NSString *)text {
    return [self initWithImage:nil text:text];
}

- (instancetype)initWithCustomView:(UIView *)customView {
    if (self = [super init]) {
        
        _isCustomHUD = YES;
        
        //cover View
        _coverView = [[UIView alloc] init];
        _coverView.frame = [UIScreen mainScreen].bounds;
        _coverView.backgroundColor = [UIColor clearColor];
        
        _customView = customView;
        [self addSubview:_customView];
        
        [self.coverView addSubview:self];
        [[self getKeyWindow] addSubview:self.coverView];
        self.frame = [self customViewFrame];
    }
    return self;
}

#pragma mark - layoutSubviews

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!_isCustomHUD) {
        CGSize textSize = [self sizeWithText:self.textLabel.text font:self.textLabel.font maxSize:CGSizeMake(kDefaultWidth - 2 * kDefaultMagin, MAXFLOAT)];
        if (self.imageView.image) {
            self.imageView.frame = CGRectMake((self.frame.size.width - self.image.size.width) / 2.0f, kDefaultMagin, self.image.size.width, self.image.size.height);
            self.textLabel.frame = CGRectMake((kDefaultWidth - textSize.width) / 2.0f, CGRectGetMaxY(self.imageView.frame) +  kDefaultMagin, textSize.width, textSize.height);
            
        }else {
            CGFloat height = textSize.height < kDefaultHeight ? kDefaultHeight : textSize.height;
            self.textLabel.frame = CGRectMake((kDefaultWidth - textSize.width) / 2.0f, kDefaultMagin, textSize.width, height);
        }
        CGRect rect = [self defaultFrame];
        rect.size.height = CGRectGetMaxY(self.textLabel.frame) + kDefaultMagin;
        self.frame = rect;
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        layer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                           byRoundingCorners:UIRectCornerAllCorners
                                                 cornerRadii:CGSizeMake(kDefaultRound, kDefaultRound)].CGPath;
        self.layer.mask = layer;
        
    }
}

/*
 *  PromptBox default frame
 */
- (CGRect)defaultFrame {
    
    return CGRectMake((kScreenWidth - kDefaultWidth) / 2.0f, (kScreenHeight - kDefaultHeight) / 2.0f - 30, kDefaultWidth, kDefaultHeight);
}

/**
 * customView default frame
 */
- (CGRect)customViewFrame {
    return CGRectMake((kScreenWidth - self.customView.frame.size.width) / 2.0f, (kScreenHeight - self.customView.frame.size.height) / 2.0f, self.customView.frame.size.width, self.customView.frame.size.height);
}

#pragma mark - show or hiden

- (void)hidenHUD {
    [self.coverView removeFromSuperview];
    [self removeFromSuperview];
}

- (void)presentWithAnimationDuration:(CGFloat)animationDuration
                        showDuration:(CGFloat)showDuration {
    
    self.transform = CGAffineTransformMakeScale(0.0, 0.0);
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0
         usingSpringWithDamping:0.5
          initialSpringVelocity:13.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         
                     } completion:^(BOOL finished) {
                         if (!finished) return;
                         if (!_isCustomHUD) {
                             [self performBlock:^{
                                 [self hidenHUD];
                             } afterDelay:showDuration];
                         }
                     }];
}

#pragma mark - delay block

/**
 *  After delay
 */
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay {
    [self performSelector:@selector(callBlockAfterDelay:) withObject:block afterDelay:delay];
}

/**
 *  After a few seconds to perform
 */
- (void)callBlockAfterDelay:(void (^)(void))block {
    block();
    block = nil;
}

#pragma mark - get window

- (UIWindow *)getKeyWindow {
    return [UIApplication sharedApplication].keyWindow;
}

#pragma mark - calculate text size

- (CGSize)sizeWithText:(NSString *)text
                  font:(UIFont *)font
               maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font
                            };
    return [text boundingRectWithSize:maxSize
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:attrs
                              context:nil].size;
}

@end


#pragma mark - XLHUD

static XLHUDView *_HUDView;

@implementation XLHUD

+ (void)showCustomView:(UIView *)customView {
    XLHUDView *HUDView = [[XLHUDView alloc] initWithCustomView:customView];
    [HUDView presentWithAnimationDuration:ANIMATION_DURATION
                             showDuration:SHOW_DURATION];
    _HUDView = HUDView;
}

+ (void)customHUBHiden {
    [_HUDView hidenHUD];
}

+ (void)showImage:(UIImage *)image text:(NSString *)text {
    XLHUDView *HUDView = [[XLHUDView alloc] initWithImage:image
                                                     text:text];
    [HUDView presentWithAnimationDuration:ANIMATION_DURATION
                             showDuration:SHOW_DURATION];
}

+ (void)showText:(NSString *)text {
    XLHUDView *HUDView = [[XLHUDView alloc] initWithText:text];
    [HUDView presentWithAnimationDuration:ANIMATION_DURATION
                             showDuration:SHOW_DURATION];
}


@end
