//
//  XLPromptController.h
//  XLPromptBox
//
//  Created by Shelin on 16/1/7.
//  Copyright © 2016年 GreatGate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XLPromptBox.h"

static CGFloat const kDefaultShowDuration = 1.0f;
static CGFloat const kDefaultAnimationSpeed = 0.5f;

@interface XLPromptController : NSObject

+ (void)showPromptBoxWithCustomView:(UIView *)customView;

+ (void)promptBoxHiden;

+ (void)showPromptBoxWithImage:(UIImage *)image text:(NSString *)text;

+ (void)showPromptBoxWithText:(NSString *)text;

+ (void)setCoverHiden:(BOOL)hiden;

@end
