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

static NSMutableDictionary *_itemCellClassPairs = nil;

@implementation RJFormDescriptor

#pragma mark - Init Methods

+ (instancetype)formWithTableView:(UITableView *)tableView
{
    RJFormDescriptor *formDescriptor = [[self alloc] init];
    formDescriptor.tableView = tableView;
    formDescriptor.addAsteriskToRequiredRowsTitle = NO;
    return formDescriptor;
}



- (instancetype)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

#pragma mark - Public Methods

+ (void)addItemCellClassPair:(Class)itemClass cellClass:(Class)cellClass
{
    [_itemCellClassPairs setObject:NSStringFromClass(cellClass) forKey:NSStringFromClass(itemClass)];
}

+ (void)removeItemCellClassPairWithItemClass:(Class)itemClass
{
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

#pragma mark - Private Methods


/**
 注册cell
 */
- (void)registerCells
{
    if (self.tableView == nil)
    {
        
        NSDictionary *userInfo = @{};
        @throw [NSException exceptionWithName:@"RJFormDescriptor register cell failed" reason:@"RJFormDescriptor's tableView is nil" userInfo:userInfo];
        return;
    }
    for (RJFormSectionDescriptor *section in self.formSections) {
        for (RJFormRowDescriptor *row in section.formRows) {
            [self.tableView registerClass:row.cellClass forCellReuseIdentifier:row.reuseIdentifier];
        }
    }
}


#pragma mark - Properties Methods

- (void)setFormSections:(NSArray<RJFormSectionDescriptor *> *)formSections
{
    _formSections = formSections;
    [self registerCells];
}

+ (NSDictionary *)itemCellClassPairs
{
    if (_itemCellClassPairs == nil)
    {
        NSDictionary *pair = @{
                               @"RJFormInfoItem" : @"RJFormInfoCell",
                               @"RJFormImageItem" : @"RJFormImageCell",
                               @"RJFormSwitchItem" : @"RJFormSwitchCell",
                               @"RJFormTextButtonItem" : @"RJFormTextButtonCell",
                               @"RJFormButtonItem" : @"RJFormButtonCell",
                               @"RJFormTextFieldItem" : @"RJFormTextFieldCell"
                               };
        _itemCellClassPairs = [NSMutableDictionary dictionary];
        [_itemCellClassPairs addEntriesFromDictionary:pair];
    }
    return [_itemCellClassPairs copy];
}

@end
