//
//  RJFormSelectorItem.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/6.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormSelectorItem.h"
#import "RJFormValidationStatus.h"
#import "RJFormEmptyTool.h"
#import "RJFormOptionItem.h"

@implementation RJFormSelectorItem

#pragma mark - Init Methods

+ (instancetype)itemWithText:(NSString *)text selectedOption:(RJFormOptionItem *)selectedOption
{
    return [self itemWithSelectorStyle:RJFormSelectorStylePicker text:text selectedOption:selectedOption];
}

+ (instancetype)itemWithSelectorStyle:(RJFormSelectorStyle)selectorStyle text:(NSString *)text selectedOption:(RJFormOptionItem * _Nullable)selectedOption
{
    RJFormSelectorItem *selectorItem = [[self alloc] init];
    selectorItem.selectorStyle = selectorStyle;
    selectorItem.text = text;
    selectorItem.selectedOption = selectedOption;
    return selectorItem;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.textFont = [UIFont systemFontOfSize:16.0];
        self.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        
        self.detailTextFont = [UIFont systemFontOfSize:15.0];
        self.detailTextColor = [UIColor colorWithRed:93.0/255.0 green:93.0/255.0 blue:93.0/255.0 alpha:1.0];
        
        self.selectorStyle = RJFormSelectorStylePicker;
        self.noDetailTextPlaceholder = @"请选择";
        self.noDetailTextColor = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:199.0/255.0 alpha:1.0];
    }
    return self;
}

#pragma mark - RJFormItemValue Methods

- (RJFormOptionItem *)itemValue
{
    return self.selectedOption;
}

- (RJFormValidationStatus *)doValidation
{
    RJFormValidationStatus *status = nil;
    if (self.required && [self itemValue] == nil)
    {
        status = [RJFormValidationStatus validationStatusWithMsg:@"" validate:NO];
        if (![RJFormEmptyTool stringIsEmpty:self.requireMsg])
        {
            status.msg = self.requireMsg;
            return status;
        }
        
        if (![RJFormEmptyTool stringIsEmpty:self.text])
        {
            status.msg = [NSString stringWithFormat:@"%@不能为空", self.text];
            return status;
        }
        
        if (![RJFormEmptyTool stringIsEmpty:self.tag])
        {
            status.msg = [NSString stringWithFormat:@"%@不能为空", self.tag];
            return status;
        }
    }
    
    return status;
}


@end
