//
//  RJFormSwitchCell.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormSwitchCell.h"
#import "RJFormSwitchItem.h"
#import "RJFormConstant.h"

@interface RJFormSwitchCell ()

/********* text *********/
@property (nonatomic, weak) UILabel *textLbl;
/********* 开关 *********/
@property (nonatomic, weak) UISwitch *openSwitch;
/********* 数据 *********/
@property (nonatomic, strong) RJFormSwitchItem *data;


@end

@implementation RJFormSwitchCell

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
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *textLbl = [[UILabel alloc] init];
    [self.contentView addSubview:textLbl];
    [textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(RJFormRowLeftAndRightMargin);
        make.right.mas_lessThanOrEqualTo(self.contentView.mas_right).mas_offset(-15.0);
        make.centerY.mas_equalTo(self.contentView);
    }];
    self.textLbl = textLbl;
    textLbl.text = @"";
    textLbl.font = [UIFont systemFontOfSize:17.0];
    textLbl.textColor = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
    
    UISwitch *openSwitch = [[UISwitch alloc] init];
    self.openSwitch = openSwitch;
    self.accessoryView = openSwitch;
    [openSwitch addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Target Methods

- (void)valueChange:(UISwitch *)openSwitch
{
    if (!self.data.switchSelector || self.data.switchSelector.length == 0)
    {
        return;
    }
    
    SEL selector = NSSelectorFromString(self.data.switchSelector);
    UIViewController *vc = [self viewController];
    if (vc && [vc respondsToSelector:selector])
    {
        //内存泄露警告,因为编译器不知道selector是哪个方法id，需要在runtime才知道
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [vc performSelector:selector withObject:openSwitch];
#pragma clang diagnostic pop
        
    }
}

#pragma mark - RJFormCellDataUpdate Methods

- (void)updateViewData:(RJFormSwitchItem *)data
{
    [super updateViewData:data];
    
    self.data = data;
    
    self.textLbl.text = data.text;
    self.textLbl.font = data.textFont;
    self.textLbl.textColor = data.textColor;
    
    self.openSwitch.on = data.open;
    
}

@end
