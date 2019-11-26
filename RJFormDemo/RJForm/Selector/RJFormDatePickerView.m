//
//  RJFormDatePickerView.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/9.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormDatePickerView.h"
#import <Masonry/Masonry.h>

/*************** 适配iPhone X *********************/

// 判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size): NO)

//是否是FaceID
#define IS_FaceID (IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES)

// 状态栏高度
#define STATUS_BAR_HEIGHT (IS_FaceID ? 44.0 : 20.0)
// 导航条高度
#define NAVIGATION_BAR_HEIGHT 44.0
// 导航栏高度
#define NAVIGATION_BAR_Max_Y (IS_FaceID ? 88.0 : 64.0)
// tabBar高度
#define TAB_BAR_HEIGHT (IS_FaceID ? 83.0 : 49.0)
// home indicator
#define HOME_INDICATOR_HEIGHT (IS_FaceID ? 34.0 : 0)

/*************** 适配iPhone X *********************/

#define RJFormContainerViewHeight (294 + HOME_INDICATOR_HEIGHT)

#define RJFormPickerTitleColor [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0]

@interface RJFormDatePickerView ()
@property (nonatomic, weak) UIView *containerView;
/********* 日期选择器 *********/
@property (nonatomic, weak) UIDatePicker *pickerView;
/********* 标题 *********/
@property (readwrite, nonatomic, weak) UILabel *titleLabel;
/********* 确认按钮 *********/
@property (readwrite, nonatomic, weak) UIButton *confirmBtn;
/********* 取消按钮 *********/
@property (readwrite, nonatomic, weak) UIButton *cancelBtn;
/********* 日期 *********/
@property (readwrite, nonatomic, strong) NSDate *date;
/********* 滚动选中的日期 *********/
@property (nonatomic, strong) NSDate *selectedDate;



@end

@implementation RJFormDatePickerView

+ (instancetype)valuePickerWithDate:(NSDate *)date completedBlock:(void (^)(NSDate * date))completed
{
    RJFormDatePickerView *valuePicker = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    valuePicker.date = date;
    valuePicker.completedBlock = completed;
    return valuePicker;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setupInit];
    }
    return self;
}

- (void)setupInit
{
    self.backgroundColor = [UIColor colorWithRed:0.0 / 255.0 green:0.0 / 255.0 blue:0.0 / 255.0 alpha:0.0];
    
    UIView * bgView = [[UIView alloc] init];
    
    bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelBtnClick)];
    [bgView addGestureRecognizer:tapGesture];
    
    [self setupContainerView];
}

- (void)setupContainerView
{
    UIView * containerView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).mas_offset(RJFormContainerViewHeight);
        make.height.mas_equalTo(RJFormContainerViewHeight);
    }];
    
    self.containerView = containerView;
    containerView.backgroundColor = [UIColor colorWithRed:126.0 / 255.0 green:126.0 / 255.0 blue:126.0 / 255.0 alpha:1.0];
    
    UIView * toolView = [[UIView alloc] init];
    [containerView addSubview:toolView];
    [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(containerView);
        make.height.mas_equalTo(44);
    }];
    toolView.backgroundColor = [UIColor whiteColor];
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [toolView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.top.left.bottom.mas_equalTo(toolView);
    }];
    self.cancelBtn = cancelBtn;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [cancelBtn setTitleColor:RJFormPickerTitleColor forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [toolView addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.top.right.bottom.mas_equalTo(toolView);
    }];
    self.confirmBtn = confirmBtn;
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [confirmBtn setTitleColor:RJFormPickerTitleColor forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    [toolView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(toolView);
        make.left.mas_equalTo(cancelBtn.mas_right).mas_offset(5);
        make.right.mas_equalTo(confirmBtn.mas_left).mas_offset(5);
    }];
    
    self.titleLabel = titleLabel;
    titleLabel.font = [UIFont systemFontOfSize:16.0];
    titleLabel.textColor = RJFormPickerTitleColor;
    titleLabel.text = @"日期选择器";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    UIView * seperatorView = [[UIView alloc] init];
    [toolView addSubview:seperatorView];
    [seperatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(toolView);
        make.height.mas_equalTo(0.5);
    }];
    seperatorView.backgroundColor = [UIColor colorWithRed:240.0 / 255.0 green:240.0 / 255.0 blue:240.0 / 255.0 alpha:1.0];
    
    UIDatePicker * pickerView = [[UIDatePicker alloc] init];
    [containerView addSubview:pickerView];
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(containerView);
        make.top.mas_equalTo(toolView.mas_bottom);
    }];
    
    self.pickerView = pickerView;
    pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.datePickerMode = UIDatePickerModeDate;
    //设置地区
    pickerView.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    //设置时区
    pickerView.timeZone = [NSTimeZone localTimeZone];
    //设置显示的分钟的间隔
    pickerView.minuteInterval = 1;
    //日期值的改变
    [pickerView addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
}

#pragma mark - Target Methods

- (void)confirmBtnClick
{
    if (self.selectedDate == nil)
    {
        self.selectedDate = [NSDate date];
    }
    
    if(self.completedBlock != nil)
    {
        self.completedBlock(self.selectedDate);
    }

    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(pickerView:date:)])
    {
        [self.delegate pickerView:self date:self.selectedDate];
    }
    
    [self dismiss:YES];
}

- (void)cancelBtnClick
{
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(pickerViewDidCancel:)])
    {
        [self.delegate pickerViewDidCancel:self];
    }
    
    [self dismiss:YES];
}

//日期改变
- (void)datePickerValueChanged:(UIDatePicker *)datePicker
{
    self.selectedDate = datePicker.date;
}

- (void)reloadData
{
    [self setDate:self.date animated:NO];
}

#pragma mark - Public Methods

- (void)show:(BOOL)animated
{
    [[UIApplication sharedApplication].windows[0] addSubview:self];
    
    //动画开始前，强制刷新
    [self layoutIfNeeded];
    
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
    }];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    if(!animated)
    {
        [self layoutIfNeeded];
        self.backgroundColor = [UIColor colorWithRed:0.0 / 255.0 green:0.0 / 255.0 blue:0.0 / 255.0 alpha:0.4];
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        //在动画中，强制刷新，产生动画效果
        [self layoutIfNeeded];
        self.backgroundColor = [UIColor colorWithRed:0.0 / 255.0 green:0.0 / 255.0 blue:0.0 / 255.0 alpha:0.4];
    }];
}

- (void)dismiss:(BOOL)animated
{
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).mas_offset(RJFormContainerViewHeight);
    }];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    if(!animated)
    {
        [self layoutIfNeeded];
        self.backgroundColor = [UIColor colorWithRed:0.0 / 255.0 green:0.0 / 255.0 blue:0.0 / 255.0 alpha:0.0];
        [self removeFromSuperview];
        
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
        self.backgroundColor = [UIColor colorWithRed:0.0 / 255.0 green:0.0 / 255.0 blue:0.0 / 255.0 alpha:0.0];
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)setDate:(NSDate *)date animated:(BOOL)animated
{
    if (date == nil)
    {
        date = [NSDate date];
    }
    _date = date;
    [self.pickerView setDate:date animated:animated];
}

#pragma mark - Properties Method

- (void)setMinimumDate:(NSDate *)minimumDate
{
    _minimumDate = minimumDate;
    self.pickerView.minimumDate = minimumDate;
}

- (void)setMaximumDate:(NSDate *)maximumDate
{
    _maximumDate = maximumDate;
    self.pickerView.maximumDate = maximumDate;
}

@end
