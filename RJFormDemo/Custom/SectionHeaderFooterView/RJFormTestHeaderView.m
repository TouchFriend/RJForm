//
//  RJFormTestHeaderView.m
//  RJFormDemo
//
//  Created by TouchWorld on 2020/4/24.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import "RJFormTestHeaderView.h"
#import <Masonry/Masonry.h>

@interface RJFormTestHeaderView ()

/// <#Desription#>
@property (nonatomic, weak) UILabel *textLbl;

@end

@implementation RJFormTestHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupInit];
    }
    return self;
}

- (void)setupInit {
    self.contentView.backgroundColor = [UIColor grayColor];
    
    UIView *verticalView = [[UIView alloc] init];
    [self.contentView addSubview:verticalView];
    [verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(2.0, 15.0));
        make.left.mas_offset(15.0);
        make.centerY.mas_equalTo(self.contentView);
    }];
    verticalView.backgroundColor = [UIColor blueColor];
    
    UILabel *textLbl = [[UILabel alloc] init];
    [self.contentView addSubview:textLbl];
    [textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(verticalView).mas_offset(5.0);
        make.centerY.mas_equalTo(self.contentView);
    }];
    self.textLbl = textLbl;
    textLbl.text = @"";
    textLbl.font = [UIFont systemFontOfSize:17.0];
    textLbl.textColor = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
}

- (void)updateViewData:(NSString *)data {
    self.textLbl.text = data;
}

@end
