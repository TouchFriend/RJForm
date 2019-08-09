//
//  RJFormImagePickerCell.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/9.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormImagePickerCell.h"
#import "RJFormImagePickerContentView.h"

@interface RJFormImagePickerCell ()

/********* text *********/
@property (nonatomic, weak) UILabel *textLbl;
/********* 图片选择view *********/
@property (nonatomic, weak) RJFormImagePickerContentView *imagePickerContentView;

@end

@implementation RJFormImagePickerCell

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
        make.left.mas_offset(16.0);
        make.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(56.0);
    }];
    self.textLbl = textLbl;
    textLbl.text = @"企业宣传图";
    textLbl.font = [UIFont systemFontOfSize:17.0];
    textLbl.textColor = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
    
    RJFormImagePickerContentView *imagePickerContentView = [[RJFormImagePickerContentView alloc] init];
    [self.contentView addSubview:imagePickerContentView];
    [imagePickerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textLbl.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.contentView);
    }];
    self.imagePickerContentView = imagePickerContentView;
    
}


@end
