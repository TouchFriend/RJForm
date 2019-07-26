//
//  RJFormTextFieldCell.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/25.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormTextFieldCell.h"
#import "RJFormTextFieldItem.h"
#import "RJFormConstant.h"

@interface RJFormTextFieldCell () <UITextFieldDelegate>

/********* text *********/
@property (nonatomic, weak) UILabel *textLbl;
/********* detail 输入框 *********/
@property (nonatomic, weak) UITextField *detailTextF;
/********* 数据 *********/
@property (nonatomic, strong) RJFormTextFieldItem *data;


@end

@implementation RJFormTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupInit];
    }
    return self;
}

- (void)dealloc
{
    
}

#pragma mark - Setup Init

- (void)setupInit
{
    self.backgroundColor = [UIColor whiteColor];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *textLbl = [[UILabel alloc] init];
    [self.contentView addSubview:textLbl];
    [textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15.0);
        make.centerY.mas_equalTo(self.contentView);
    }];
    self.textLbl = textLbl;
    textLbl.text = @"";
    textLbl.font = [UIFont systemFontOfSize:17.0];
    textLbl.textColor = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
    
    UITextField *detailTextF = [[UITextField alloc] init];
    [self.contentView addSubview:detailTextF];
    [detailTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView).mas_offset(-15.0);
        make.left.mas_equalTo(textLbl.mas_right).mas_offset(10.0);
    }];
    self.detailTextF = detailTextF;
    detailTextF.text = @"";
    detailTextF.font = [UIFont systemFontOfSize:15.0];
    detailTextF.textColor = [UIColor colorWithRed:93.0 / 255.0 green:93.0 / 255.0 blue:93.0 / 255.0 alpha:1.0];
    detailTextF.clearButtonMode = UITextFieldViewModeWhileEditing;
    detailTextF.delegate = self;
    [detailTextF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - Target Methods

- (void)textFieldDidChanged:(UITextField *)textField
{
    self.data.detailText = textField.text;
}

#pragma mark - RJFormCellDataUpdate Methods

- (void)updateViewData:(RJFormTextFieldItem *)data
{
    [super updateViewData:data];
    
    self.data = data;
    
    self.textLbl.attributedText = RJFormAsteriskTextRequired(data.required, data.text, data.textColor, data.textFont);
    
    self.detailTextF.text = data.detailText;
    self.detailTextF.font = data.detailTextFont;
    self.detailTextF.textColor = data.detailTextColor;
    self.detailTextF.attributedPlaceholder = data.detailAttributedPlaceholder;
    self.detailTextF.textAlignment = data.detailTextAlignment;
    self.detailTextF.keyboardType = data.detailKeyboardType;
    self.detailTextF.clearButtonMode = data.clearButtonMode;
    
    BOOL hidden = !data.text || data.text.length == 0;
    self.textLbl.hidden = hidden;
    CGFloat detailTextFLeftMargin = hidden ? 0 : 10.0;
    [self.detailTextF mas_updateConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.textLbl.mas_right).mas_offset(detailTextFLeftMargin);
    }];
    
}

#pragma mark - UITextFieldDelegate Methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.data.detailMaxNumberOfCharacters != nil)
    {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (newString.length > self.data.detailMaxNumberOfCharacters.integerValue)
        {
            textField.text = [newString substringToIndex:self.data.detailMaxNumberOfCharacters.integerValue];
            return NO;
        }
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self textFieldDidChanged:textField];
}

@end
