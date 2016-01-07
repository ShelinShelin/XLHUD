//
//  XLPromptController.m
//  XLPromptBox
//  https://github.com/ShelinShelin
//  Created by Shelin on 16/1/7.
//  Copyright © 2016年 GreatGate. All rights reserved.
//

#import "XLPromptController.h"

static XLPromptBox *_promptBox;

@interface XLPromptController ()

@end

@implementation XLPromptController

+ (void)showPromptBoxWithImage:(UIImage *)image text:(NSString *)text {
    
    XLPromptBox *promptBox = [[XLPromptBox alloc]initWithImage:image andText:text];
    [promptBox presentWithDuration:kDefaultShowDuration speed:kDefaultAnimationSpeed];
}

+ (void)showPromptBoxWithText:(NSString *)text {
    
    XLPromptBox *promptBox = [[XLPromptBox alloc] initWithImage:nil andText:text];
    [promptBox presentWithDuration:kDefaultShowDuration speed:kDefaultAnimationSpeed];
}

+ (void)showPromptBoxWithCustomView:(UIView *)customView {
    
    XLPromptBox *promptBox = [[XLPromptBox alloc] initWithCustomView:customView];
    [promptBox presentWithDuration:kDefaultShowDuration speed:kDefaultAnimationSpeed];
    _promptBox = promptBox;
}

+ (void)promptBoxHiden {
    
    [_promptBox promptBoxHidenWithView:_promptBox speed:kDefaultAnimationSpeed];
}



@end
