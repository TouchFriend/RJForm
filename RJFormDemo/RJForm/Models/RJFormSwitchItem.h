//
//  RJFormSwitchItem.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RJFormBaseItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface RJFormSwitchItem : RJFormBaseItem

/********* 文本 *********/
@property (nonatomic, copy) NSString *text;
/********* 文本字体 默认16.0 *********/
@property (nonatomic, strong) UIFont *textFont;
/********* 文本颜色 默认黑色51 *********/
@property (nonatomic, strong) UIColor *textColor;

/********* 是否打开 *********/
@property (nonatomic, assign) BOOL open;
/********* 开关切换时，执行控制器的方法,有一个参数,就是UISwitch ********/
@property (nonatomic, copy) NSString *switchSelector;


+ (instancetype)itemWithText:(NSString *)text open:(BOOL)open;

+ (instancetype)itemWithText:(NSString *)text open:(BOOL)open switchSelector:(NSString *_Nullable)switchSelector;

- (NSNumber *)itemValue;

@end

NS_ASSUME_NONNULL_END
