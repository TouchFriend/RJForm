//
//  RJFormDatePickerManager.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/9.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormDatePickerManager.h"
#import "RJFormDatePickerItem.h"
#import "RJFormDatePickerView.h"

@interface RJFormDatePickerManager () <RJFormDatePickerViewDelegate>

/********* tableView *********/
@property (nonatomic, weak) UITableView *tableView;
/********* 数据 *********/
@property (nonatomic, weak) RJFormDatePickerItem *item;
/********* 表单控制器 *********/
@property (nonatomic, weak) UIViewController *formController;
/********* 选择器 *********/
@property (nonatomic, strong) RJFormDatePickerView *datePickerView;
/********* 日期格式器 *********/
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation RJFormDatePickerManager

static RJFormDatePickerManager *manager = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}


#pragma mark - Public Methods

- (void)showSelectorViewWithTableView:(UITableView *)tableView item:(RJFormDatePickerItem *)item formController:(UIViewController *)formController
{
    self.tableView = tableView;
    self.item = item;
    self.formController = formController;
    //日期格式
    self.dateFormatter.dateFormat = item.dateFormat;
    
    [self showPickerView];
}

#pragma mark - Private Methods

/**
 显示选择器
 */
- (void)showPickerView
{
    if (self.item == nil)
    {
        [self.datePickerView setDate:[NSDate date] animated:NO];
        return;
    }
    
    BOOL flag = self.item.selectorTitle == nil || self.item.selectorTitle.length == 0;
    self.datePickerView.titleLabel.text = flag ? self.item.text : self.item.selectorTitle;
    
    self.datePickerView.minimumDate = self.item.minimumDate;
    self.datePickerView.maximumDate = self.item.maximumDate;
    
    NSDate *date = [self.dateFormatter dateFromString:self.item.detailText];
    
    [self.datePickerView setDate:date animated:NO];

    [self.datePickerView reloadData];

    [self.datePickerView show:YES];
}

#pragma mark - RJFormDatePickerViewDelegate Methods

- (void)pickerViewDidCancel:(RJFormDatePickerView *)pickerView
{
    
}

- (void)pickerView:(RJFormDatePickerView *)pickerView date:(NSDate *)date
{
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    self.item.detailText = dateString;
    [self.tableView reloadData];
}


#pragma mark - Properties methods

- (RJFormDatePickerView *)datePickerView
{
    if (_datePickerView == nil)
    {
        _datePickerView = [RJFormDatePickerView valuePickerWithDate:nil completedBlock:nil];
        _datePickerView.delegate = self;
    }
    return _datePickerView;
}


- (NSDateFormatter *)dateFormatter
{
    if (_dateFormatter == nil)
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return _dateFormatter;
}


@end

