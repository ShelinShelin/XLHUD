//
//  CustomView.m
//  XLPromptBox
//
//  Created by Shelin on 16/1/6.
//  Copyright © 2016年 GreatGate. All rights reserved.
//

#import "CustomView.h"
#import "XLHUD.h"

@implementation CustomView

- (instancetype)init {
    if ([super init]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:nil options:nil].lastObject;
    }
    return self;
}

- (IBAction)okAction:(id)sender {
    [XLHUD customHUBHiden];
}

@end
