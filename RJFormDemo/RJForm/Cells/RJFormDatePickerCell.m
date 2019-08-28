//
//  RJFormDatePickerCell.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/9.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormDatePickerCell.h"
#import "RJFormDatePickerItem.h"
#import "RJFormDescriptor.h"
#import "RJFormConstant.h"
#import "RJFormEmptyTool.h"


@interface RJFormDatePickerCell ()

/********* text *********/
@property (nonatomic, weak) UILabel *textLbl;
/********* detail text *********/
@property (nonatomic, weak) UILabel *detailTextLbl;

@end

@implementation RJFormDatePickerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupInit];
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.textLbl.text = @"";
    self.detailTextLbl.text = @"";
}

#pragma mark - Setup Init

- (void)setupInit
{
    self.backgroundColor = [UIColor whiteColor];
    self.accessoryType = UITableViewCellAccessoryNone;
    
    UILabel *textLbl = [[UILabel alloc] init];
    [self.contentView addSubview:textLbl];
    [textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(RJFormRowLeftAndRightMargin);
        make.centerY.mas_equalTo(self.contentView);
    }];
    self.textLbl = textLbl;
    textLbl.text = @"";
    textLbl.font = [UIFont systemFontOfSize:17.0];
    textLbl.textColor = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
    
    UILabel *detailTextLbl = [[UILabel alloc] init];
    [self.contentView addSubview:detailTextLbl];
    [detailTextLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_greaterThanOrEqualTo(textLbl.mas_right).mas_offset(5.0);
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_offset(-RJFormRowLeftAndRightMargin);
    }];
    self.detailTextLbl = detailTextLbl;
    detailTextLbl.text = @"";
    detailTextLbl.font = [UIFont systemFontOfSize:14.0];
    detailTextLbl.textColor = [UIColor colorWithRed:181.0 / 255.0 green:181.0 / 255.0 blue:181.0 / 255.0 alpha:1.0];
    detailTextLbl.textAlignment = NSTextAlignmentRight;
    
    
}

#pragma mark - RJFormCellDataUpdate Methods

- (void)updateViewData:(RJFormDatePickerItem *)data tag:(nonnull NSString *)tag
{
    [super updateViewData:data tag:tag];
    
    self.textLbl.attributedText = RJFormAsteriskTextRequired(data.required, data.text, data.textColor, data.textFont);
    
    BOOL isEmpty = [RJFormEmptyTool stringIsEmpty:data.detailText];
    
    self.detailTextLbl.text = isEmpty ? data.noDetailTextPlaceholder : data.detailText;
    self.detailTextLbl.font = data.detailTextFont;
    self.detailTextLbl.textColor = isEmpty ? data.noDetailTextColor : data.detailTextColor;
    
    
    CGFloat detailTextRightMargin = data.hiddenArror ? RJFormRowLeftAndRightMargin : 0;
    [self.detailTextLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-detailTextRightMargin);
    }];
    
    self.accessoryType = data.hiddenArror ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
    
}

@end

