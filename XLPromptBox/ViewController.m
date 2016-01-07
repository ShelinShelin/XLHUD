//
//  ViewController.m
//  XLPromptBox
//
//  Created by Shelin on 16/1/6.
//  Copyright © 2016年 GreatGate. All rights reserved.
//

#import "ViewController.h"
#import "XLPromptController.h"
#import "CustomView.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)defaultPrompt_1:(id)sender {
    [XLPromptController showPromptBoxWithImage:[UIImage imageNamed:@"Checkmark"] text:@"This is a prompt box with text and image"];
}

- (IBAction)defaultPrompt_2:(id)sender {
    [XLPromptController showPromptBoxWithText:@"This is a prompt box with text"];
}

- (IBAction)customPrompt:(id)sender {
    CustomView *customView = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:nil options:nil].lastObject;
    
//    [XLShowPrompt setCoverHiden:YES];
    [XLPromptController showPromptBoxWithCustomView:customView];
}

- (IBAction)hiden:(id)sender {
    [XLPromptController promptBoxHiden];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

@end
