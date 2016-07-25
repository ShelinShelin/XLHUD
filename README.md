
####XLHUD

![gif](https://github.com/ShelinShelin/XLHUD/blob/master/result.gif)

####usage

```
- (IBAction)btnAction_1:(id)sender {
    [XLHUD showImage:[UIImage imageNamed:@"Checkmark"] text:@"Success"];
}

- (IBAction)btnAction_2:(id)sender {
    [XLHUD showText:@"Success"];
}

- (IBAction)btnAction_3:(id)sender {
    [XLHUD showCustomView:[[CustomView alloc] init]];
}

```
