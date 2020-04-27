//
//  RJFormTestTableHeaderView.m
//  RJFormDemo
//
//  Created by TouchWorld on 2020/4/27.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import "RJFormTestTableHeaderView.h"
#import <Masonry/Masonry.h>

@implementation RJFormTestTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupInit];
    }
    return self;
}

#pragma mark - Setup Init

- (void)setupInit {
    self.backgroundColor = [UIColor greenColor];
    
    UILabel *textLbl = [[UILabel alloc] init];
    [self addSubview:textLbl];
    [textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    textLbl.text = @"TableHeaderView";
    textLbl.font = [UIFont systemFontOfSize:17.0];
    textLbl.textColor = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
    textLbl.textAlignment = NSTextAlignmentCenter;
}

@end
