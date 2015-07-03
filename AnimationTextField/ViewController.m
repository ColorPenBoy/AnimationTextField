//
//  ViewController.m
//  AnimationTextField
//
//  Created by colorPen on 15/7/3.
//  Copyright (c) 2015年 colorPen. All rights reserved.
//

#import "ViewController.h"
#import "AnimationTextField.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat TextX = 20;
    CGFloat TextY = 40;
    CGFloat TextW = self.view.frame.size.width - 40;
    CGFloat TextH = 60;
    NSArray *placeHolderArr = @[@"用户名",@"密码",@"就是这样",@"动画效果",@"我还有一点",@"继续加吧"];
    NSArray *textColorArr = @[[UIColor redColor],[UIColor purpleColor],[UIColor brownColor],[UIColor lightGrayColor],[UIColor greenColor],[UIColor yellowColor]];
    NSArray *animArr = @[@(AnimationTypeShake),
                         @(AnimationTypeBound),
                         @(AnimationTypeUp),
                         @(AnimationTypeShake),
                         @(AnimationTypeBound),
                         @(AnimationTypeUp)];
    
    for (int i = 0; i < 6; i++)
    {
        CGRect rect = CGRectMake(TextX, TextY + i*(TextH+TextX), TextW ,TextH);
        AnimationTextField *customField = [[AnimationTextField alloc]initWithFrame:rect];
        customField.placeholderFont = [UIFont systemFontOfSize:15];
        customField.placeStr = placeHolderArr[i];
        customField.placeholderColor = [self getRandomColor];
        customField.textColor = textColorArr[i];
        customField.animationType_tf = (AnimationType)[animArr[i] integerValue];
        customField.tag = i + 10;
        [self.view addSubview:customField];
    }
}

- (UIColor *)getRandomColor
{
    CGFloat r = (arc4random()%255)/255.0;
    CGFloat g = (arc4random()%255)/255.0;
    CGFloat b = (arc4random()%255)/255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
