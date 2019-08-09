//
//  RJFormDatePickerView.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/9.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RJFormDatePickerView;

@protocol RJFormDatePickerViewDelegate <NSObject>


/**
 点击取消按钮
 
 @param pickerView pickerView
 */
- (void)pickerViewDidCancel:(nonnull RJFormDatePickerView *)pickerView;

/**
 点击确认按钮
 
 @param pickerView pickerView
 @param date 日期
 */
- (void)pickerView:(nonnull RJFormDatePickerView *)pickerView date:(NSDate *_Nullable)date;

@end

NS_ASSUME_NONNULL_BEGIN

@interface RJFormDatePickerView : UIView



/**
 实例化方法
 
 @param date 日期
 @param completed 回调
 @return 点击完成按钮回调
 */
+ (instancetype)valuePickerWithDate:(NSDate *_Nullable)date completedBlock:(void (^_Nullable)(NSDate * date))completed;

/********* 代理 *********/
@property (nonatomic, weak) id<RJFormDatePickerViewDelegate> delegate;
/********* 日期 *********/
@property (readonly, nonatomic, strong) NSDate *date;

/********* 标题 *********/
@property (readonly, nonatomic, weak) UILabel *titleLabel;
/********* 确认按钮 *********/
@property (readonly, nonatomic, weak) UIButton *confirmBtn;
/********* 取消按钮 *********/
@property (readonly, nonatomic, weak) UIButton *cancelBtn;
/********* 点击完成按钮回调 *********/
@property(nonatomic,copy)void (^completedBlock)(NSDate * date);

/********* 可以选的最小日期 默认为nil *********/
@property (nullable, nonatomic, strong) NSDate *minimumDate;
/********* 可以选的最大日期 默认为nil *********/
@property (nullable, nonatomic, strong) NSDate *maximumDate;


/**
 设置日期

 @param date 日期
 @param animated 是否动画
 */
- (void)setDate:(NSDate *_Nullable)date animated:(BOOL)animated;


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

/**
 重新加载数据
 */
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
