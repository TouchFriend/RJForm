//
//  RJFormValuePickerView.h
//  Destination
//
//  Created by TouchWorld on 2019/1/16.
//  Copyright © 2019 Redirect. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RJFormValuePickerView;

@protocol RJFormValuePickerViewDelegate <NSObject>


/**
 点击取消按钮

 @param pickerView pickerView
 */
- (void)pickerViewDidCancel:(nonnull RJFormValuePickerView *)pickerView;

/**
 点击确认按钮

 @param pickerView pickerView
 @param row 第几行
 @param title 标题
 */
- (void)pickerView:(nonnull RJFormValuePickerView *)pickerView didSelectRow:(NSInteger)row title:(NSString *_Nullable)title;

@end

NS_ASSUME_NONNULL_BEGIN

@interface RJFormValuePickerView : UIView



/**
 实例化方法

 @param titles 标题数据
 @param completed 回调
 @return 点击完成按钮回调
 */
+ (instancetype)valuePickerWithTitles:(nullable NSArray *)titles completedBlock:(void(^_Nullable)(NSString * title, NSInteger index))completed;

/********* 代理 *********/
@property (nonatomic, weak) id<RJFormValuePickerViewDelegate> delegate;
/********* 数据 *********/
@property (nonatomic, strong) NSArray<NSString *> *_Nullable titleDataArr;
/********* 标题 *********/
@property (readonly, nonatomic, weak) UILabel *titleLabel;
/********* 确认按钮 *********/
@property (readonly, nonatomic, weak) UIButton *confirmBtn;
/********* 取消按钮 *********/
@property (readonly, nonatomic, weak) UIButton *cancelBtn;
/********* 选择器文字颜色 *********/
@property (nonatomic, strong) UIColor *pickerTextColor;
/********* 选择器文字颜色字体 *********/
@property (nonatomic, strong) UIFont *pickerTextFont;
/********* 选择器每行高度 默认52.0 *********/
@property (nonatomic, assign) CGFloat rowHeight;
/********* 点击完成按钮回调 *********/
@property(nonatomic,copy)void (^completedBlock)(NSString * title, NSInteger index);

/********* 选中行 默认第0行 *********/
@property (readonly, nonatomic, assign) NSInteger selectedRow;


/**
 选中第几行

 @param row 第几行
 @param animated 是否动画
 */
- (void)selectRow:(NSInteger)row animated:(BOOL)animated;

/**
 重新加载数据
 */
- (void)reloadData;

/**
 显示

 @param animated 是否动画
 */
- (void)show:(BOOL)animated;


/**
 隐藏

 @param animated 是否动画
 */
- (void)dismiss:(BOOL)animated;


@end

NS_ASSUME_NONNULL_END
