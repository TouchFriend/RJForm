//
//  RJFormTextButtonCell.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/24.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormTextButtonCell.h"
#import "RJFormTextButtonItem.h"

@interface RJFormTextButtonCell ()

/********* text *********/
@property (nonatomic, weak) UILabel *textLbl;

@end

@implementation RJFormTextButtonCell

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
    
    UILabel *textLbl = [[UILabel alloc] init];
    [self.contentView addSubview:textLbl];
    [textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
    }];
    self.textLbl = textLbl;
    textLbl.text = @"";
    textLbl.font = [UIFont systemFontOfSize:17.0];
    textLbl.textColor = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
    textLbl.textAlignment = NSTextAlignmentCenter;
    
}

#pragma mark - RJFormCellDataUpdate Methods

- (void)updateViewData:(RJFormTextButtonItem *)data
{
    [super updateViewData:data];
    
    self.textLbl.text = data.text;
    self.textLbl.font = data.textFont;
    self.textLbl.textColor = data.textColor;
}

@end
