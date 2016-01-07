//
//  XLPromptBox.h
//  XLPromptBox
//  https://github.com/ShelinShelin
//  Created by Shelin on 16/1/6.
//  Copyright © 2016年 GreatGate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLPromptBox : UIView

- (instancetype)initWithImage:(UIImage *)image andText:(NSString *)text;

- (instancetype)initWithText:(NSString *)text;

- (instancetype)initWithCustomView:(UIView *)customView;

- (void)promptBoxHidenWithView:(XLPromptBox *)view speed:(CGFloat)speed;

- (void)presentWithDuration:(CGFloat)duration speed:(CGFloat)speed;

@end
