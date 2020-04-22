//
//  RJFormRowDescriptor.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RJFormItemValue.h"
NS_ASSUME_NONNULL_BEGIN

@interface RJFormRowDescriptor : NSObject

/********* cell的class *********/
@property (readonly, nonatomic, strong) Class cellClass;
/********* tag(标签) *********/
@property (nonatomic, copy) NSString *tag;
/********* 重利用id *********/
@property (readonly, nonatomic, copy) NSString *reuseIdentifier;
/********* 模型 *********/
@property (readonly, nonatomic, strong) id<RJFormItemValue> item;
/********* 行高 默认49.0 *********/
@property (nonatomic, assign) CGFloat rowHeight;
/********* 选中cell时，执行的方法 *********/
@property (nonatomic, copy) NSString *didSelectedSelector;

/**
 设置cell数据

 @param cell UITableViewCell的实例
 */
- (void)updateCell:(UITableViewCell *)cell;


/**
 初始化方法

 @param cellClass cell的class
 @param item 模型数据
 @return 实例对象
 */
+ (instancetype)rowWithTag:(nullable NSString * )tag cellClass:(Class)cellClass item:(id)item;

+ (instancetype)rowWithTag:(nullable NSString * )tag item:(id<RJFormItemValue>)item;

/**
 初始化方法 会通过模型类，识别对应的cell的class。
 注意：自定义的模型类和cell，需要通过RJFormDescriptor的+ (void)addItemCellClassPair:(Class)itemClass cellClass:(Class)cellClass 方法来添加。

 @param item 模型数据
 @return 实例对象
 */
+ (instancetype)rowWithItem:(id<RJFormItemValue>)item;


/**
 计算图片选择cell的高度
 */
- (void)calculateRowHeight;

@end

NS_ASSUME_NONNULL_END
