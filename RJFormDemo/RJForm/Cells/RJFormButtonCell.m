//
//  RJFormButtonCell.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/24.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormButtonCell.h"
#import "RJFormButtonItem.h"

@interface RJFormButtonCell ()

/********* btn *********/
@property (nonatomic, weak) UIButton *btn;
/********* 数据 *********/
@property (nonatomic, strong) RJFormButtonItem *data;


@end

@implementation RJFormButtonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupInit];
    }
    return self;
}

#pragma mark - Setup Init

- (void)setupInit
{
    self.backgroundColor = [UIColor clearColor];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(0.0, 15.0, 0.0, 15.0));
    }];
    self.btn = btn;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:34.0/255.0 green:161.0/255.0 blue:241.0/255.0 alpha:1.0];
    [self.btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Override Methods

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.btn.layer.masksToBounds = NO;
    self.btn.layer.cornerRadius = 0.0;
}

#pragma mark - Target Mehtods

- (void)btnClick:(UIButton *)btn
{
    if (!self.data.clickedSelector || self.data.clickedSelector.length == 0)
    {
        return;
    }
    
    SEL selector = NSSelectorFromString(self.data.clickedSelector);
    UIViewController *vc = [self viewController];
    if (vc && [vc respondsToSelector:selector])
    {
        //内存泄露警告,因为编译器不知道selector是哪个方法id，需要在runtime才知道
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [vc performSelector:selector withObject:btn];
#pragma clang diagnostic pop

    }
    
}

#pragma mark - RJFormCellDataUpdate Methods

- (void)updateViewData:(RJFormButtonItem *)data
{
    self.data = data;
    self.backgroundColor = data.cellBackgroudColor;
    
    [self.btn setTitle:data.text forState:UIControlStateNormal];
    [self.btn setTitleColor:data.textColor forState:UIControlStateNormal];
    self.btn.titleLabel.font = data.textFont;
    self.btn.backgroundColor = data.buttonBackgroudColor;
    if (data.cornerRadius > 0)
    {
        self.btn.layer.masksToBounds = YES;
        self.btn.layer.cornerRadius = data.cornerRadius;
    }
    
    [self.btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).insets(data.insets);
    }];
    
    
    
}

@end
