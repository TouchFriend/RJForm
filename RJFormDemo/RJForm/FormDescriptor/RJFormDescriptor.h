//
//  RJFormDescriptor.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RJFormSectionDescriptor, RJFormRowDescriptor;

NS_ASSUME_NONNULL_BEGIN

@interface RJFormDescriptor : NSObject

/********* tableView *********/
@property (nonatomic, weak) UITableView *tableView;
/********* 分组数据 *********/
@property (nonatomic, strong, readonly) NSMutableArray<RJFormSectionDescriptor *> *formSections;

/********* 是否添加 * 到要求行的标题开头 默认为YES *********/
@property (class, nonatomic, assign, getter=isAddAsteriskToRequiredRowsTitle) BOOL addAsteriskToRequiredRowsTitle;


+ (instancetype)formWithTableView:(UITableView *)tableView;


/********* 模型类和cell类的配对 *********/
@property (class, readonly, nonatomic, strong) NSDictionary *itemCellClassPairs;

/**
 添加自定义的模型和cell的配对，内部会给tableView注册cell

 @param itemClass 自定义模型类
 @param cellClass 自定义的cell类
 */
- (void)addItemCellClassPair:(Class)itemClass cellClass:(Class)cellClass;

/**
 通过指定模型类，移除自定义的模型和cell的配对

 @param itemClass 自定义模型类
 */
- (void)removeItemCellClassPairWithItemClass:(Class)itemClass;


/**
 获取表单所有的值

 @return 表单的值
 */
- (NSDictionary *)formValue;


/**
 表单验证，哪些行是否有错

 @return 所有错误
 */
- (NSArray<NSError *> *)formValidationErrors;

/**
 获取tag所对应的RJFormRowDescriptor

 @param tag tag
 @return tag所对应的RJFormRowDescriptor的实例
 */
- (RJFormRowDescriptor *)formRowWithTag:(NSString *)tag;

/**
 获取indexPath对应的row

 @param indexPath 下标
 @return 如果找到，返回对应的row。否则返回nil
 */
- (RJFormRowDescriptor *)formRowWithIndexPath:(NSIndexPath *)indexPath;

/**
 获取RJFormRowDescriptor的位置

 @param row RJFormRowDescriptor的实例
 @return 位置
 */
- (NSIndexPath *)indexPathOfFormRow:(RJFormRowDescriptor *)row;

/// 添加分组
/// @param section 分组模型
/// @return 添加结果
- (BOOL)addFormSection:(RJFormSectionDescriptor *)section;

/// 添加分组数组
/// @param sections 分组数组
/// @return 添加结果
- (BOOL)addFormSections:(NSArray<RJFormSectionDescriptor *> *)sections;

/// 通过下标删除分组
/// @param index 下标
/// @return 删除结果
- (BOOL)removeFormSectionAtIndex:(NSUInteger)index;

/// 通过section实例删除分组
/// @param section section实例
/// @return 删除结果
- (BOOL)removeFormSection:(RJFormSectionDescriptor *)section;

/// 向指定分组添加行数据
/// @param sectionIndex 分组索引
/// @param rowDescriptor 行模型
- (BOOL)addFormRowInSection:(NSUInteger)sectionIndex rowDescriptor:(RJFormRowDescriptor *)rowDescriptor;

/// 向指定分组插入行数据
/// @param sectionIndex 分组索引
/// @param rowIndex 插入的位置
/// @param rowDescriptor 行模型
- (BOOL)insertFormRowInSection:(NSUInteger)sectionIndex rowIndex:(NSUInteger)rowIndex rowDescriptor:(RJFormRowDescriptor *)rowDescriptor;

/// 移除指定分组指定位置的行
/// @param sectionIndex 分组索引
/// @param rowIndex 行索引
- (BOOL)removeFormRowInSection:(NSUInteger)sectionIndex rowIndex:(NSUInteger)rowIndex;

/// 移除指定分组的指定行数据
/// @param sectionIndex 分组索引
/// @param rowDescriptor 行模型
- (BOOL)removeFormRowInSection:(NSUInteger)sectionIndex rowDescriptor:(RJFormRowDescriptor *)rowDescriptor;

/**
 注册所有cell。
 */
- (void)registerAllCells;

/**
 刷新表单数据。
 */
- (void)reloadData;


/**
 处理选择器cell点击，显示选择器

 @param tableView tableView
 @param indexPath indexPath
 @param formController formController
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath formController:(UIViewController *)formController;

@end

NS_ASSUME_NONNULL_END
