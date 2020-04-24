//
//  RJFormDescriptor.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormDescriptor.h"
#import "RJFormSectionDescriptor.h"
#import "RJFormRowDescriptor.h"
#import "RJFormValidationStatus.h"
#import "RJFormConstant.h"
#import "RJFormSelectorItem.h"
#import "RJFormSelectorManager.h"
#import "RJFormDatePickerManager.h"
#import "RJFormDatePickerItem.h"
#import "RJFormImagePickerItem.h"

static NSMutableDictionary *_itemCellClassPairs = nil;
static BOOL _addAsteriskToRequiredRowsTitle = YES;

@interface RJFormDescriptor ()

/********* 分组数据 *********/
@property (nonatomic, strong) NSMutableArray<RJFormSectionDescriptor *> *formSections;

@end

@implementation RJFormDescriptor

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *pair = @{
                               @"RJFormInfoItem" : @"RJFormInfoCell",
                               @"RJFormImageItem" : @"RJFormImageCell",
                               @"RJFormSwitchItem" : @"RJFormSwitchCell",
                               @"RJFormTextButtonItem" : @"RJFormTextButtonCell",
                               @"RJFormButtonItem" : @"RJFormButtonCell",
                               @"RJFormTextFieldItem" : @"RJFormTextFieldCell",
                               @"RJFormTextViewItem" : @"RJFormTextViewCell",
                               @"RJFormSelectorItem" : @"RJFormSelectorCell",
                               @"RJFormDatePickerItem" : @"RJFormDatePickerCell",
                               @"RJFormImagePickerItem" : @"RJFormImagePickerCell"
                               };
        _itemCellClassPairs = [NSMutableDictionary dictionary];
        [_itemCellClassPairs addEntriesFromDictionary:pair];
    });
}

#pragma mark - Init Methods

+ (instancetype)formWithTableView:(UITableView *)tableView
{
    RJFormDescriptor *formDescriptor = [[self alloc] init];
    formDescriptor.tableView = tableView;
    //注册现有的所有cell
    [formDescriptor registerAllCells];
    return formDescriptor;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.formSections = [NSMutableArray array];
        [self addObserveNotifications];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserveNotifications];
}

#pragma mark - Public Methods

- (void)addItemCellClassPair:(Class)itemClass cellClass:(Class)cellClass
{
    NSAssert(itemClass, @"itemClass不能为空");
    NSAssert(cellClass, @"cellClass不能为空");
    NSString *cellClassString = NSStringFromClass(cellClass);
    //注册cell
    [self.tableView registerClass:cellClass forCellReuseIdentifier:cellClassString];
    [_itemCellClassPairs setObject:cellClassString forKey:NSStringFromClass(itemClass)];
}

- (void)removeItemCellClassPairWithItemClass:(Class)itemClass
{
    NSAssert(itemClass, @"itemClass不能为空");
    [_itemCellClassPairs removeObjectForKey:NSStringFromClass(itemClass)];
}

- (NSDictionary *)formValue
{
    NSMutableDictionary *valueDicM = [NSMutableDictionary dictionary];
    for (RJFormSectionDescriptor *section in self.formSections) {
        for (RJFormRowDescriptor *row in section.formRows) {
            id value = [row.item itemValue];
            if (row.tag && row.tag.length > 0 && value)
            {
                [valueDicM setObject:value forKey:row.tag];
            }
        }
    }
    return [valueDicM copy];
}

- (NSArray<NSError *> *)formValidationErrors
{
    NSMutableArray *errorArrM = [NSMutableArray array];
    for (RJFormSectionDescriptor *section in self.formSections) {
        for (RJFormRowDescriptor *row in section.formRows) {
            RJFormValidationStatus *status = [row.item doValidation];
            if (status && !status.isValidte)
            {
                status.rowDescriptor = row;
                NSDictionary *userInfo = @{
                                           NSLocalizedDescriptionKey : status.msg,
                                           RJFormValidationErrorKey : status
                                           
                                           };
                NSError *error = [NSError errorWithDomain:RJFormErrorDomain code:RJFormErrorCodeValidation userInfo:userInfo];
                [errorArrM addObject:error];
            }
        }
    }
    
    return errorArrM;
}

- (RJFormRowDescriptor *)formRowWithTag:(NSString *)tag
{
    for (RJFormSectionDescriptor *section in self.formSections) {
        for (RJFormRowDescriptor *row in section.formRows) {
            if ([row.tag isEqualToString:tag])
            {
                return row;
            }
        }
    }
    return nil;
}

- (RJFormRowDescriptor *)formRowWithIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section >= self.formSections.count)
    {
        return nil;
    }
    
    RJFormSectionDescriptor *section = self.formSections[indexPath.section];
    if (indexPath.row >= section.formRows.count)
    {
        return nil;
    }
    
    return section.formRows[indexPath.row];
    
}

- (NSIndexPath *)indexPathOfFormRow:(RJFormRowDescriptor *)row
{
    for (NSInteger i = 0; i < self.formSections.count; i++) {
        RJFormSectionDescriptor *section = self.formSections[i];
        if ([section.formRows containsObject:row])
        {
            NSUInteger index = [section.formRows indexOfObject:row];
            return [NSIndexPath indexPathForRow:index inSection:i];
        }
    }

    return nil;
}

- (BOOL)addFormSection:(RJFormSectionDescriptor *)section
{
    if (!section) {
        return NO;
    }
    
    [self.formSections addObject:section];
    return YES;
}

- (BOOL)addFormSections:(NSArray<RJFormSectionDescriptor *> *)sections
{
    if (!sections) {
        return NO;
    }
    
    [self.formSections addObjectsFromArray:sections];
    return YES;
}

- (BOOL)removeFormSectionAtIndex:(NSUInteger)index
{
    if (index < self.formSections.count)
    {
        [self.formSections removeObjectAtIndex:index];
        return YES;
    }
    return NO;
}

- (BOOL)removeFormSection:(RJFormSectionDescriptor *)section
{
    if (!section) {
        return NO;
    }
    [self.formSections removeObject:section];
    return YES;
}

- (BOOL)addFormRowInSection:(NSUInteger)sectionIndex rowDescriptor:(RJFormRowDescriptor *)rowDescriptor {
    if (sectionIndex >= self.formSections.count) {
        return NO;
    }
    RJFormSectionDescriptor *sectionDescriptor = self.formSections[sectionIndex];
    return [sectionDescriptor addFormRow:rowDescriptor];
}

- (BOOL)insertFormRowInSection:(NSUInteger)sectionIndex rowIndex:(NSUInteger)rowIndex rowDescriptor:(RJFormRowDescriptor *)rowDescriptor {
    if (sectionIndex >= self.formSections.count) {
        return NO;
    }
    RJFormSectionDescriptor *sectionDescriptor = self.formSections[sectionIndex];
    return [sectionDescriptor addFormRow:rowDescriptor atIndex:rowIndex];
}

- (BOOL)removeFormRowInSection:(NSUInteger)sectionIndex rowIndex:(NSUInteger)rowIndex {
    if (sectionIndex >= self.formSections.count) {
        return NO;
    }
    RJFormSectionDescriptor *sectionDescriptor = self.formSections[sectionIndex];
    return [sectionDescriptor removeFormRowAtIndex:rowIndex];
}

- (BOOL)removeFormRowInSection:(NSUInteger)sectionIndex rowDescriptor:(RJFormRowDescriptor *)rowDescriptor {
    if (sectionIndex >= self.formSections.count) {
        return NO;
    }
    RJFormSectionDescriptor *sectionDescriptor = self.formSections[sectionIndex];
    return [sectionDescriptor removeFormRow:rowDescriptor];
}

- (void)registerAllCells
{
    if (self.tableView == nil)
    {
        
        NSDictionary *userInfo = @{};
        @throw [NSException exceptionWithName:@"RJFormDescriptor register cell failed" reason:@"RJFormDescriptor's tableView is nil" userInfo:userInfo];
        return;
    }
    
    for (NSString *cellClassString in [_itemCellClassPairs allValues]) {
        [self.tableView registerClass:NSClassFromString(cellClassString) forCellReuseIdentifier:cellClassString];
    };
}

- (void)reloadData
{
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath formController:(UIViewController *)formController
{
    NSAssert(tableView, @"tableView不能为空");
    NSAssert(formController, @"formController不能为空");
    
    RJFormSectionDescriptor *sectionDescriptor = self.formSections[indexPath.section];
    RJFormRowDescriptor *rowDescriptor = sectionDescriptor.formRows[indexPath.row];
    if ([rowDescriptor.item isKindOfClass:[RJFormSelectorItem class]])
    {
        RJFormSelectorItem *selectorItem = rowDescriptor.item;
        
        [[RJFormSelectorManager shareInstance] showSelectorViewWithTableView:tableView item:selectorItem formController:formController];
        return;
    }
    
    if ([rowDescriptor.item isKindOfClass:[RJFormDatePickerItem class]])
    {
        RJFormDatePickerItem *datePickerItem = rowDescriptor.item;
        [[RJFormDatePickerManager shareInstance] showSelectorViewWithTableView:tableView item:datePickerItem formController:formController];
    }
    
    
    
}

#pragma mark - Private Methods

/**
 添加监听通知
 */
- (void)addObserveNotifications
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(refreshForm:) name:RJFormRefreshNotificationName object:nil];
}


/**
 移除监听通知
 */
- (void)removeObserveNotifications
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

#pragma mark - Target Methods

//刷新表单
- (void)refreshForm:(NSNotification *)notification
{
    for (RJFormSectionDescriptor *section in self.formSections) {
        for (RJFormRowDescriptor *row in section.formRows) {
            //计算图片选择cell的高度
            [row calculateRowHeight];
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark - Properties Methods


+ (NSDictionary *)itemCellClassPairs
{
    return [_itemCellClassPairs copy];
}

+ (BOOL)isAddAsteriskToRequiredRowsTitle
{
    return _addAsteriskToRequiredRowsTitle;
}

+ (void)setAddAsteriskToRequiredRowsTitle:(BOOL)addAsteriskToRequiredRowsTitle
{
    _addAsteriskToRequiredRowsTitle = addAsteriskToRequiredRowsTitle;
}

@end
