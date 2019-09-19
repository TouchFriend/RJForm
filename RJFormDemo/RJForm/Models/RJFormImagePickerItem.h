//
//  RJFormImagePickerItem.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/9.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormBaseItem.h"
#import "RJFormCalculateRowHeightProtocol.h"

@class RJFormImagePickerContentItem;
NS_ASSUME_NONNULL_BEGIN

@interface RJFormImagePickerItem : RJFormBaseItem <RJFormCalculateRowHeightProtocol>

/********* 文本 *********/
@property (nonatomic, copy) NSString *text;
/********* 文本字体 默认16.0 *********/
@property (nonatomic, strong) UIFont *textFont;
/********* 文本颜色 默认黑色51 *********/
@property (nonatomic, strong) UIColor *textColor;
/********* 图片最大数量 默认6 *********/
@property (nonatomic, assign) NSInteger imageMaxCount;
/********* 行高 *********/
@property (nonatomic, assign) CGFloat rowHeight;

/********* 模型 多余的将无效 *********/
@property (readonly, nonatomic, strong) NSMutableArray<RJFormImagePickerContentItem *> *contentItemArrM;

+ (instancetype)itemWithText:(NSString *)text imageArr:(NSArray<RJFormImagePickerContentItem *> * _Nullable)imageArr;

#warning 获取图片数据的方法


/**
 获取带有+好按钮模型的模型数组

 @return 模型数组
 */
- (NSMutableArray<RJFormImagePickerContentItem *> *)getContentArrMWithAddButton;

/**
 获取不带有+好按钮模型的模型数组
 
 @return 模型数组
 */
- (NSMutableArray<RJFormImagePickerContentItem *> *)getContentArrMNoAddButton;

/**
 重新计算行高

 @return 行高
 */
- (CGFloat)calculateRowHeight;


- (NSArray<RJFormImagePickerContentItem *> *)itemValue;

@end

NS_ASSUME_NONNULL_END
