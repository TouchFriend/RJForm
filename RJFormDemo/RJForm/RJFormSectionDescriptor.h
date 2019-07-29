//
//  RJFormSectionDescriptor.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RJFormRowDescriptor;

NS_ASSUME_NONNULL_BEGIN

@interface RJFormSectionDescriptor : NSObject

/********* 分组头部高度 默认0.1 *********/
@property (nonatomic, assign) CGFloat sectionHeaderHeight;
/********* 分组尾部高度 默认0.1 *********/
@property (nonatomic, assign) CGFloat sectionFooterHeight;
/********* 分组头部标题 *********/
@property (nonatomic, copy) NSString *sectionHeaderTitle;
/********* 分组尾部标题 *********/
@property (nonatomic, copy) NSString *sectionFooterTitle;

/********* 行数据 *********/
@property (nonatomic, strong) NSMutableArray<RJFormRowDescriptor *> *formRows;

- (void)addFormRow:(RJFormRowDescriptor *)row;

- (void)removeFormRow:(RJFormRowDescriptor *)row;


+ (instancetype)sectionWithSectionHeaderHeight:(CGFloat)sectionHeaderHeight sectionFooterHeight:(CGFloat)sectionFooterHeight;

@end

NS_ASSUME_NONNULL_END
