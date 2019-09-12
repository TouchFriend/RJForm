//
//  RJFormTextViewCell.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/29.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormTextViewCell.h"
#import "RJFormDescriptor.h"
#import "RJFormConstant.h"
#import "RJFormTextViewItem.h"
#import "UITextView+RJFormPlaceholder.h"

@interface RJFormTextViewCell () <UITextViewDelegate>

/********* data *********/
@property (nonatomic, weak) RJFormTextViewItem *data;
/********* text *********/
@property (nonatomic, weak) UILabel *textLbl;
/********* textView *********/
@property (nonatomic, weak) UITextView *textView;

@end

@implementation RJFormTextViewCell

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
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *textLbl = [[UILabel alloc] init];
    [self.contentView addSubview:textLbl];
    [textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(RJFormRowLeftAndRightMargin);
        make.top.mas_equalTo(self.contentView).mas_offset(20.0);
        make.height.mas_equalTo(16.0);
    }];
    self.textLbl = textLbl;
    textLbl.text = @"";
    textLbl.font = [UIFont systemFontOfSize:16.0];
    textLbl.textColor = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
    
    
    UITextView *textView = [[UITextView alloc] init];
    [self.contentView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textLbl.mas_bottom).mas_offset(20.0);
        make.left.mas_offset(RJFormRowLeftAndRightMargin);
        make.right.mas_offset(-RJFormRowLeftAndRightMargin);
        make.bottom.mas_offset(-20.0);
    }];
    self.textView = textView;
    textView.showsHorizontalScrollIndicator = NO;
    textView.textContainerInset = UIEdgeInsetsZero;
    textView.textContainer.lineFragmentPadding = 0.0;
    textView.delegate = self;
}

#pragma mark - UITextViewDelegate Methods

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.data.detailText = textView.text;
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.data.detailText = textView.text;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (self.data.detailMaxNumberOfCharacters != nil)
    {
        NSString *newString = [textView.text stringByReplacingCharactersInRange:range withString:text];
        if (newString.length > self.data.detailMaxNumberOfCharacters.integerValue)
        {
            textView.text = [newString substringToIndex:self.data.detailMaxNumberOfCharacters.integerValue];
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - RJFormCellDataUpdate Methods

- (void)updateViewData:(RJFormTextViewItem *)data tag:(nonnull NSString *)tag
{
    [super updateViewData:data tag:tag];
    
    self.data = data;
    
    self.textLbl.attributedText = RJFormAsteriskTextRequired(data.required, data.text, data.textColor, data.textFont);
    
    self.textView.text = data.detailText;
    self.textView.textColor = data.detailTextColor;
    self.textView.font = data.detailTextFont;
    self.textView.attributedPlaceholder = data.detailAttributedPlaceholder;
    
    //是否可用
    self.textView.editable = data.enabled;
}

@end
