//
//  RJFormValuePickerView.m
//  Destination
//
//  Created by TouchWorld on 2019/1/16.
//  Copyright © 2019 Redirect. All rights reserved.
//

#import "RJFormValuePickerView.h"
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

@interface RJFormValuePickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, weak) UIView *containerView;
/********* 选择器 *********/
@property (nonatomic, weak) UIPickerView *pickerView;
/********* 标题 *********/
@property (readwrite, nonatomic, weak) UILabel *titleLabel;
/********* 确认按钮 *********/
@property (readwrite, nonatomic, weak) UIButton *confirmBtn;
/********* 取消按钮 *********/
@property (readwrite, nonatomic, weak) UIButton *cancelBtn;
/********* 设置默认选中行 *********/
@property (nonatomic, assign) NSInteger selectedRow;
@end

@implementation RJFormValuePickerView

+ (instancetype)valuePickerWithTitles:(NSArray *)titles completedBlock:(void (^)(NSString * _Nonnull, NSInteger))completed
{
    RJFormValuePickerView *valuePicker = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    valuePicker.titleDataArr = titles;
    valuePicker.completedBlock = completed;
    [valuePicker reloadData];
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
    self.selectedRow = 0;
    self.rowHeight = 52.0;
    self.pickerTextColor = RJFormPickerTitleColor;
    self.pickerTextFont = [UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold];
    
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
        make.width.mas_equalTo(44);
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
        make.width.mas_equalTo(44);
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
    
    UIPickerView * pickerView = [[UIPickerView alloc] init];
    [containerView addSubview:pickerView];
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(containerView);
        make.top.mas_equalTo(toolView.mas_bottom);
    }];
    
    self.pickerView = pickerView;
    pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    
}

#pragma mark - UIPickerViewDataSource方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.titleDataArr.count;
}
#pragma mark - UIPickerViewDelegate方法
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.rowHeight;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString * title = self.titleDataArr[row];
    return [[NSAttributedString alloc] initWithString:title attributes:@{
                                                                         NSFontAttributeName : self.pickerTextFont,
                                                                         NSForegroundColorAttributeName : self.pickerTextColor
                                                                         }];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectedRow = row;
}

#pragma mark - Target Methods

- (void)confirmBtnClick
{
    if (self.titleDataArr == nil || self.titleDataArr.count == 0)
    {
        [self dismiss:YES];
        return;
    }
    NSInteger selectedIndex = [self.pickerView selectedRowInComponent:0];
    NSString * title = self.titleDataArr[selectedIndex];
    if(self.completedBlock != nil)
    {
        self.completedBlock(title, selectedIndex);
    }
    
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(pickerView:didSelectRow:title:)])
    {
        [self.delegate pickerView:self didSelectRow:selectedIndex title:title];
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

#pragma mark - Public Methods

- (void)show:(BOOL)animated
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
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

- (void)reloadData
{
    [self.pickerView reloadAllComponents];
}

- (void)selectRow:(NSInteger)row animated:(BOOL)animated
{
    if(row < 0 || row > self.titleDataArr.count)
    {
        return;
    }
    
    _selectedRow = row;
    
    [self.pickerView selectRow:row inComponent:0 animated:animated];
}

#pragma mark - Properties Method


@end
