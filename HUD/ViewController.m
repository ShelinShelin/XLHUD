//
//  ViewController.m
//  HUD
//
//  Created by Shelin on 16/7/25.
//  Copyright © 2016年 GreatGate. All rights reserved.
//

#import "ViewController.h"
#import "XLHUD.h"
#import "CustomView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [RBHUD showText:@"Success"];
    
//    [RBHUD showCustomView:[[CustomView alloc] init]];
    
    [XLHUD showImage:[UIImage imageNamed:@"Checkmark"] text:@"Success"];
}
@end
