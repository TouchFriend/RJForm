//
//  RJFormTextButtonItem.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/24.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RJFormBaseItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface RJFormTextButtonItem : RJFormBaseItem

/********* 文本 *********/
@property (nonatomic, copy) NSString *text;
/********* 文本字体 默认17.0 *********/
@property (nonatomic, strong) UIFont *textFont;
/********* 文本颜色 默认黑色51 *********/
@property (nonatomic, strong) UIColor *textColor;

+ (instancetype)itemWithText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
