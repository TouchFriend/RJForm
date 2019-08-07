//
//  RJFormSelectorManager.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/7.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormSelectorManager.h"
#import "RJFormSelectorItem.h"
#import "RJFormValuePickerView.h"
#import "RJFormOptionItem.h"

@interface RJFormSelectorManager () <RJFormValuePickerViewDelegate>

/********* tableView *********/
@property (nonatomic, weak) UITableView *tableView;
/********* 数据 *********/
@property (nonatomic, weak) RJFormSelectorItem *item;
/********* 表单控制器 *********/
@property (nonatomic, weak) UIViewController *formController;
/********* 选择器 *********/
@property (nonatomic, strong) RJFormValuePickerView *pickerView;


@end

@implementation RJFormSelectorManager

static RJFormSelectorManager *manager = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}


#pragma mark - Public Methods

- (void)showSelectorViewWithTableView:(UITableView *)tableView item:(RJFormSelectorItem *)item formController:(UIViewController *)formController
{
    self.tableView = tableView;
    self.item = item;
    self.formController = formController;
    
    switch (item.selectorStyle) {
        case RJFormSelectorStylePicker:
        {
            [self showPickerView];
        }
            break;
        case RJFormSelectorStyleAlert:
        {
            [self showAlertControllerWithAlertStyle];
        }
            break;
        case RJFormSelectorStyleActionSheet:
        {
            [self showAlertControllerWithActionSheetStyle];
        }
            break;
        case RJFormSelectorStylePush:
        {
            
        }
            break;
            
        default:
        {
            [self showPickerView];
        }
            break;
    }
}

#pragma mark - Private Methods

/**
 显示选择器
 */
- (void)showPickerView
{
    if (self.item == nil)
    {
        self.pickerView.titleDataArr = nil;
        [self.pickerView reloadData];
        return;
    }
    NSArray *selectorTitleArr = [self selectorTitleArr];
    NSInteger selectedIndex = [self selectedIndex];
    BOOL flag = self.item.selectorTitle == nil || self.item.selectorTitle.length == 0;
    self.pickerView.titleLabel.text = flag ? self.item.text : self.item.selectorTitle;
    self.pickerView.titleDataArr = selectorTitleArr;
    [self.pickerView selectRow:selectedIndex animated:NO];
    
    [self.pickerView reloadData];
    
    [self.pickerView show:YES];
}


/**
 显示Alert样式警告控制器
 */
- (void)showAlertControllerWithAlertStyle
{
    [self showAlertControllerWithStyle:UIAlertControllerStyleAlert];
}

/**
 显示ActionSheet样式警告控制器
 */
- (void)showAlertControllerWithActionSheetStyle
{
    [self showAlertControllerWithStyle:UIAlertControllerStyleActionSheet];
}


/**
 显示指定样式的警告控制器

 @param preferredStyle 警告控制器样式
 */
- (void)showAlertControllerWithStyle:(UIAlertControllerStyle)preferredStyle
{
    BOOL flag = self.item.selectorTitle == nil || self.item.selectorTitle.length == 0;
    NSString *title = flag ? self.item.text : self.item.selectorTitle;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:preferredStyle];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    NSArray<NSString *> *selectorTitleArr = [self selectorTitleArr];
    __weak typeof(self) weakSelf = self;
    for (NSInteger i = 0; i < selectorTitleArr.count; i++)
    {
        NSString *alertTitle = selectorTitleArr[i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:alertTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.item.selectedOption = weakSelf.item.selectorOptions[i];
            [weakSelf.tableView reloadData];
        }];
        [alertController addAction:action];
    }
    
    [alertController addAction:cancelAction];
    [self.formController presentViewController:alertController animated:YES completion:nil];
}


/**
 当前选中的行下标

 @return 行下标
 */
- (NSInteger)selectedIndex
{
    if (self.item == nil || self.item.selectorOptions == nil || self.item.selectorOptions.count == 0)
    {
        return -1;
    }
    
    
    NSUInteger index = [self.item.selectorOptions indexOfObject:self.item.selectedOption];
    if (index != NSNotFound)
    {
        return index;
    }
    
    for (NSInteger i = 0; i < self.item.selectorOptions.count; i++)
    {
        RJFormOptionItem *optionItem = self.item.selectorOptions[i];
        if ([optionItem.optionValue isEqual:self.item.selectedOption.optionValue])
        {
            return i;
        }
    }
    
    return 0;
}


/**
 要显示的所有标题

 @return 标题
 */
- (NSArray<NSString *> *)selectorTitleArr
{
    if (self.item == nil)
    {
        return nil;
    }
    
    NSMutableArray<NSString *> *selectorTitleArrM = [NSMutableArray array];
    for (NSInteger i = 0; i < self.item.selectorOptions.count; i++)
    {
        RJFormOptionItem *optionItem = self.item.selectorOptions[i];
        [selectorTitleArrM addObject:optionItem.optionText];
    }
    
    return [selectorTitleArrM copy];
}

#pragma mark - RJFormValuePickerViewDelegate Methods

- (void)pickerViewDidCancel:(RJFormValuePickerView *)pickerView
{
    
}

- (void)pickerView:(RJFormValuePickerView *)pickerView didSelectRow:(NSInteger)row title:(NSString *)title
{
    
    self.item.selectedOption = self.item.selectorOptions[row];
    [self.tableView reloadData];
}


#pragma mark - Properties Methods

- (RJFormValuePickerView *)pickerView
{
    if (_pickerView == nil)
    {
        _pickerView = [RJFormValuePickerView valuePickerWithTitles:nil completedBlock:nil];
        _pickerView.delegate = self;
    }
    return _pickerView;
}

@end
