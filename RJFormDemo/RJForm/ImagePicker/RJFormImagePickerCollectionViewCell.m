//
//  RJFormImagePickerCollectionViewCell.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/9.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormImagePickerCollectionViewCell.h"

@interface RJFormImagePickerCollectionViewCell ()

/********* icon *********/
@property (nonatomic, weak) UIImageView *iconImageV;

@end

@implementation RJFormImagePickerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupInit];
    }
    return self;
}

#pragma mark - Setup Init

- (void)setupInit
{
    UIImageView *iconImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:iconImageV];
    [iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    self.iconImageV = iconImageV;
    iconImageV.image = [UIImage imageNamed:@"zhanweijian"];
}


@end
