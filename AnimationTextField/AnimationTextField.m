//
//  AnimationTextField.m
//  AnimationTextField
//
//  Created by colorPen on 15/7/3.
//  Copyright (c) 2015年 colorPen. All rights reserved.
//

#import "AnimationTextField.h"

#define KDefaultColor [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1]
#define angle2radian(angle) ((angle) / 180.0 * M_PI)
#define KLabelX 5
#define KLabelH 20

@interface AnimationTextField()

@property (assign,nonatomic) BOOL isNull;

@property (assign,nonatomic) CGFloat labelH;

@property (assign,nonatomic) CGFloat textFiledH;

@property (strong,nonatomic) UILabel *placerLabel;

@property (strong,nonatomic) UITextField *textFiled;

@end

@implementation AnimationTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = YES;
        //默认动画
        self.animationType = AnimationTypeUp;
        self.isNull = YES;//默认为空
        self.labelH = KLabelH;
        self.textFiledH = self.frame.size.height - self.labelH;

        /**
         *  占位符
         */
        CGRect rect_Placer = CGRectMake(KLabelX ,self.labelH ,self.frame.size.width ,self.textFiledH);
        self.placerLabel = [[UILabel alloc]initWithFrame:rect_Placer];
        self.placeholderColor = KDefaultColor;
        [self addSubview:self.placerLabel];
        /**
         *  输入框
         */
        CGRect rect_tf = CGRectMake(0 ,self.labelH ,self.frame.size.width ,self.textFiledH );
        self.textFiled = [[UITextField alloc]initWithFrame:rect_tf];
        self.textFiled.backgroundColor = [UIColor clearColor];
        [self.textFiled addTarget:self
                           action:@selector(valueChange:)
                 forControlEvents:UIControlEventEditingChanged];
        self.textFiled.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:self.textFiled];

        

    }
    return self;
}
#pragma mark -监测textField的输入
- (void)valueChange:(UITextField*)textField
{
    switch (self.animationType_tf)
    {
        case AnimationTypeBound: [self animationBound]; break;
        case AnimationTypeShake: [self animationShake]; break;
        case AnimationTypeUp:    [self animationUp];    break;
    }
    //取出当前输入的文字
    _textInput = textField.text;
}

#pragma mark - 占位符颜色
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    _placerLabel.textColor = _placeholderColor;
}

#pragma mark - 对齐方式
-(void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textAlignment = textAlignment;
    _placerLabel.textAlignment = _textAlignment;
    _textFiled.textAlignment = _textAlignment;
}
#pragma mark - 占位符
-(void)setPlaceStr:(NSString *)placeStr
{
    _placeStr = placeStr;
    _placerLabel.text = _placeStr;
}
#pragma mark - 字体
-(void)setPlacerholderFont:(UIFont *)placeholderFont
{
    _placeholderFont = placeholderFont;
    _placerLabel.font = _placeholderFont;
    _textFiled.font = _placeholderFont;
}
#pragma mark - 输入框文字颜色
-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _textFiled.textColor = _textColor;
}
#pragma mark - 动画效果
-(void)setAnimationType:(AnimationType)animationType
{
    _animationType_tf = animationType;
}

#pragma mark -向上的动画
-(void)animationUp
{
    CGRect labelRect = self.textFiled.frame ;
    labelRect.origin.x = KLabelX;
    if (self.isNull)
    {
        self.isNull = NO;
        labelRect.origin.y = self.textFiled.frame.origin.y - self.textFiled.frame.size.height;
        //开始描写动画效果
        [UIView animateWithDuration:0.3  animations:^{
            self.placerLabel.frame = labelRect;
        }];
    }
    else if (!self.textFiled.text.length)
    {
        self.isNull = YES;
        labelRect.origin.y = self.textFiled.frame.origin.y;
        [UIView animateWithDuration:0.3  animations:^{
            self.placerLabel.frame = labelRect;
        }];
    }
}
#pragma mark -抖动的动画
-(void)animationShake
{
    CGRect labelRect = self.textFiled.frame ;
    labelRect.origin.x = KLabelX;
    if (self.isNull)
    {
        self.isNull = NO;
        labelRect.origin.y = self.textFiled.frame.origin.y - self.textFiled.frame.size.height;
        //开始描写动画效果
        [UIView animateWithDuration:0.3  animations:^{
            self.placerLabel.frame = labelRect;
            CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
            rotation.keyPath = @"transform.rotation";
            rotation.values = @[@(angle2radian(-5)),@(angle2radian(5)),@(angle2radian(-5))];
            [self.placerLabel.layer addAnimation:rotation forKey:nil];
        }];
    }
    else if (!self.textFiled.text.length)
    {
        self.isNull = YES;
        labelRect.origin.y = self.textFiled.frame.origin.y;
        [UIView animateWithDuration:0.3  animations:^{
            self.placerLabel.frame = labelRect;
            CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
            rotation.keyPath = @"transform.rotation";
            rotation.values = @[@(angle2radian(5)),@(angle2radian(-5)),@(angle2radian(5))];
            [self.placerLabel.layer addAnimation:rotation forKey:nil];
        }];
    }
}

#pragma mark -弹簧的动画
-(void)animationBound
{
    CGRect labelRect = self.textFiled.frame ;
    labelRect.origin.x = KLabelX;
    if (self.isNull)
    {
        self.isNull = NO;
        labelRect.origin.y = self.textFiled.frame.origin.y - self.textFiled.frame.size.height;
        //开始描写动画效果
        [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.placerLabel.frame = labelRect;
        } completion:nil];
    }
    else if (!self.textFiled.text.length)
    {
        self.isNull = YES;
        labelRect.origin.y = self.textFiled.frame.origin.y;
        [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.placerLabel.frame = labelRect;
        } completion:nil];
    }
}



@end
