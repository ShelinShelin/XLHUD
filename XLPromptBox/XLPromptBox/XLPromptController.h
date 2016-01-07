//
//  XLPromptController.h
//  XLPromptBox
//  https://github.com/ShelinShelin
//  Created by Shelin on 16/1/7.
//  Copyright © 2016年 GreatGate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XLPromptBox.h"

static CGFloat const kDefaultShowDuration = 1.0f;
static CGFloat const kDefaultAnimationSpeed = 0.5f;

typedef BOOL (^IsCoverHiden)(void);

@interface XLPromptController : NSObject

+ (void)showPromptBoxWithCustomView:(UIView *)customView;      //  default is does not take the initiative in disappear

+ (void)promptBoxHiden;

+ (void)showPromptBoxWithImage:(UIImage *)image text:(NSString *)text;      // default is will disappear after a few seconds

+ (void)showPromptBoxWithText:(NSString *)text;      // default is will disappear after a few seconds

@end
