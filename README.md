# XLPromptBox
####A easy way to show a prompt box with Text and image, or custom view 一个用法简单的弹框，可弹出自定义的控件，只需一行代码


#####show a prompt box with Text and image,default is does not take the initiative in disappear. 弹出图片和文字，默认1秒后消失
```
 - (IBAction)defaultPrompt_1:(id)sender {
    [XLPromptController showPromptBoxWithImage:[UIImage imageNamed:@"Checkmark"] text:@"This is a prompt box with text and image"];
}
```
##### show a prompt box with Text,default is does not take the initiative in disappear. 弹出纯文本，默认1秒后消失
 ```
 - (IBAction)defaultPrompt_2:(id)sender {
    [XLPromptController showPromptBoxWithText:@"This is a prompt box with text"];
}
 ```
#####show a prompt box with custom view,default is does not take the initiative in disappear. 显示自定义的视图，需要主动调用方法消失
 ```
 - (IBAction)customPrompt:(id)sender {
    CustomView *customView = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:nil options:nil].lastObject;
    [XLPromptController showPromptBoxWithCustomView:customView];
}
 ```
 ```
- (IBAction)hiden:(id)sender {
    [XLPromptController promptBoxHiden];
}
 ```
![](https://github.com/ShelinShelin/XLPromptBox/blob/master/Untitled_1.gif)
![](https://github.com/ShelinShelin/XLPromptBox/blob/master/Untitled_2.gif)
![](https://github.com/ShelinShelin/XLPromptBox/blob/master/Untitled_3.gif)
