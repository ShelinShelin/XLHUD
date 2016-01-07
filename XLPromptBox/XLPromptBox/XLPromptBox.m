//
//  XLPromptBox.m
//  XLPromptBox
//  https://github.com/ShelinShelin
//  Created by Shelin on 16/1/6.
//  Copyright © 2016年 GreatGate. All rights reserved.
//

#import "XLPromptBox.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kBackgroundColor [UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.00f]

static CGFloat const kDefaultWidth = 180.0f;
static CGFloat const kDefaultHeight = 80.0f;
static CGFloat const kDefaultRound = 17.0f;
static CGFloat const kDefaultTextFont = 16.0f;
static CGFloat const kDefaultMagin = 20.0f;

@interface XLPromptBox ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *textLabel;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *customView;

@end

@implementation XLPromptBox

#pragma mark - view frame

/**
 *  PromptBox default frame
 */
- (CGRect)defaultFrame {
    return CGRectMake((kScreenWidth - kDefaultWidth) / 2.0f, (kScreenHeight - kDefaultHeight) / 2.0f - 50.0f, kDefaultWidth, kDefaultHeight);
}

/**
 * customView default frame
 */
- (CGRect)customViewFrame {
    return CGRectMake((kScreenWidth - self.customView.frame.size.width) / 2.0f, (kScreenHeight - self.customView.frame.size.height) / 2.0f, self.customView.frame.size.width, self.customView.frame.size.height);
}

#pragma mark - methods

- (instancetype)initWithImage:(UIImage *)image andText:(NSString *)text {
    
    if (self = [super initWithFrame:[self defaultFrame]]) {
        self.image = image;
        self.text = text;
        self.alpha = 0.0f;
        self.backgroundColor = kBackgroundColor;
        self.layer.cornerRadius = kDefaultRound;
        self.coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.coverView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.0];
        [self.coverView addSubview:self];

        [[self getCurrentViewController].view addSubview:self.coverView];
    }
    
    return self;
}

- (instancetype)initWithText:(NSString *)text {
    return [self initWithImage:nil andText:text];
}

- (instancetype)initWithCustomView:(UIView *)customView {
    if ([super init]) {
        self.alpha = 0.0f;
        self.coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.coverView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
        self.customView = customView;
        [self addSubview:self.customView];
        [self.coverView addSubview:self];
        [[self getCurrentViewController].view addSubview:self.coverView];
        self.frame = [self customViewFrame];
    }
    return self;
}

#pragma - mark show and hiden animation

/**
 *  promptBox show
 */
- (void)presentWithDuration:(CGFloat)duration speed:(CGFloat)speed {
    
    [UIView animateWithDuration:speed animations:^{
        self.alpha = 1.0f;
        self.coverView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
        
    } completion:^(BOOL finished) {
        if (finished) {
            if (!self.customView) {
                [self performBlock:^{
                    [self promptBoxHidenWithView:self speed:speed];
                } afterDelay:duration];
            }
        }
    }];
}

/**
 *  promptBox hiden
 */
- (void)promptBoxHidenWithView:(XLPromptBox  *)view speed:(CGFloat)speed {
    
    [UIView animateWithDuration:speed animations:^{

        view.coverView.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [view.coverView removeFromSuperview];
        }
    }];
}

#pragma mark - Getter

- (UIImageView *)imageView {
    if (!_imageView){
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.userInteractionEnabled = YES;
        _imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_imageView];
        if (self.image != nil) {
            _imageView.image = self.image;
        }
    }
    return _imageView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
    
        _textLabel = [[UILabel alloc] init];
        _textLabel.userInteractionEnabled = YES;
        _textLabel.font = [UIFont systemFontOfSize:kDefaultTextFont];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textAlignment = NSTextAlignmentLeft;
        _textLabel.numberOfLines = 0;
        [self addSubview:_textLabel];
        if (self.text != nil) {
            _textLabel.text = self.text;
        }
    }
    return _textLabel;
}

#pragma mark - layout subviews

- (void)layoutSubviews {
    
    if (!self.customView) {
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
    }
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
}

#pragma mark - calculate text size and get current ViewController

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{
                            NSFontAttributeName : font
                            };
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


/**
 *  get current view controller
 */
- (UIViewController *)getCurrentViewController
{
    UIViewController *currentViewController = nil;
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    if (window.windowLevel != UIWindowLevelNormal) {
        
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows) {
            
            if (tempWindow.windowLevel == UIWindowLevelNormal) {
                window = tempWindow;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        currentViewController = nextResponder;
    }else {
        currentViewController = window.rootViewController;
    }
    return currentViewController;
}



@end
