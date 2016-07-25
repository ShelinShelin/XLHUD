//
//  XLHUD.h
//  HUD
//
//  Created by Shelin on 16/7/25.
//  Copyright © 2016年 GreatGate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XLHUD : NSObject

/**
 *  default is does not take the initiative in disappear
 */
+ (void)showCustomView:(UIView *)customView;

+ (void)customHUBHiden;

/**
 *  default is will disappear after a few seconds
 */
+ (void)showImage:(UIImage *)image text:(NSString *)text;

/**
 *  default is will disappear after a few seconds
 */
+ (void)showText:(NSString *)text;


@end
