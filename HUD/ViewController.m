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

- (IBAction)btnAction_1:(id)sender {
    [XLHUD showImage:[UIImage imageNamed:@"Checkmark"] text:@"Success"];
}

- (IBAction)btnAction_2:(id)sender {
    [XLHUD showText:@"Success"];
}

- (IBAction)btnAction_3:(id)sender {
    [XLHUD showCustomView:[[CustomView alloc] init]];
}


@end
