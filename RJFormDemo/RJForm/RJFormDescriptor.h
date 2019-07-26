//
//  RJFormDescriptor.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RJFormSectionDescriptor, RJFormRowDescriptor;

NS_ASSUME_NONNULL_BEGIN

@interface RJFormDescriptor : NSObject

/********* tableView *********/
@property (nonatomic, weak) UITableView *tableView;
/********* 分组数据 *********/
@property (nonatomic, strong) NSArray<RJFormSectionDescriptor *> *formSections;

/********* 是否添加 * 到要求行的标题开头 默认为YES *********/
@property (class, nonatomic, assign, getter=isAddAsteriskToRequiredRowsTitle) BOOL addAsteriskToRequiredRowsTitle;


+ (instancetype)formWithTableView:(UITableView *)tableView;


/********* 模型类和cell类的配对 *********/
@property (class, readonly, nonatomic, strong) NSDictionary *itemCellClassPairs;

/**
 添加自定义的模型和cell的配对

 @param itemClass 自定义模型类
 @param cellClass 自定义的cell类
 */
+ (void)addItemCellClassPair:(Class)itemClass cellClass:(Class)cellClass;

/**
 通过指定模型类，移除自定义的模型和cell的配对

 @param itemClass 自定义模型类
 */
+ (void)removeItemCellClassPairWithItemClass:(Class)itemClass;


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
 获取RJFormRowDescriptor的位置

 @param row RJFormRowDescriptor的实例
 @return 位置
 */
- (NSIndexPath *)indexPathOfFormRow:(RJFormRowDescriptor *)row;

@end

NS_ASSUME_NONNULL_END
