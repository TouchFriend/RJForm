//
//  RJFormConstant.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/24.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RJFormDescriptor.h"

#define RJFormScreenWidth [UIScreen mainScreen].bounds.size.width
#define RJFormScreenHeight [UIScreen mainScreen].bounds.size.height

/// 图片的位置
typedef NS_ENUM(NSUInteger, RJFormImageCellStyle)
{
    RJFormImageCellStyleLeft = 0, //图片在左边
    RJFormImageCellStyleMiddle, //图片在中间
    RJFormImageCellStyleRight, //图片在右边
    
};

/// 选择器显示方式
typedef NS_ENUM(NSUInteger, RJFormSelectorStyle)
{
    RJFormSelectorStylePicker = 0, //选择器
    RJFormSelectorStyleAlert, //警告框
    RJFormSelectorStyleActionSheet , //底部警告框
    RJFormSelectorStylePush , //push
};

/// 表单错误
typedef NS_ENUM(NSUInteger, RJFormErrorCode)
{
    RJFormErrorCodeValidation = -1000, //验证错误
};

//*号颜色
#define RJFormAsteriskColor [UIColor colorWithRed:255.0/255.0 green:105.0/255.0 blue:105.0/255.0 alpha:1.0]

//每行的左右间距 15.0
UIKIT_EXTERN CGFloat const RJFormRowLeftAndRightMargin;
//显示箭头时，距离箭头的默认间距
UIKIT_EXTERN CGFloat const RJFormRowDefaultRightMarginWhenShowArrow;

FOUNDATION_EXTERN NSString * const RJFormErrorDomain;
FOUNDATION_EXTERN NSString * const RJFormValidationErrorKey;

//刷新界面的通知
FOUNDATION_EXTERN NSString * const RJFormRefreshNotificationName;

/**
 如果需要添加*号，返回添加*号后的富文本

 @param required 是否要求填写
 @param text 文本
 @param textColor 颜色
 @param textFont 字体
 @return 富文本
 */
static inline NSAttributedString * RJFormAsteriskTextRequired(BOOL required, NSString *text, UIColor *textColor, UIFont *textFont)
{
    text = text == nil ? @"" : text;
    BOOL flag = required && text && text.length > 0 && [RJFormDescriptor isAddAsteriskToRequiredRowsTitle];
    NSString *newText = flag ? [NSString stringWithFormat:@"*%@", text] : text;
    NSDictionary *normalDic = @{
                                NSForegroundColorAttributeName : textColor,
                                NSFontAttributeName : textFont
                                };
    NSDictionary *asteriskDic = @{
                                  NSForegroundColorAttributeName : RJFormAsteriskColor,
                                  NSFontAttributeName : textFont
                                  };
    NSMutableAttributedString *textAttriM = [[NSMutableAttributedString alloc] initWithString:newText attributes:normalDic];
    if (flag)
    {
        [textAttriM addAttributes:asteriskDic range:NSMakeRange(0, 1)];
    }
    
    return [textAttriM copy];
}
