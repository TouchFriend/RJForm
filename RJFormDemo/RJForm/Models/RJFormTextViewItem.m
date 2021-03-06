//
//  RJFormTextViewItem.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/29.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormTextViewItem.h"
#import "RJFormValidationStatus.h"
#import "RJFormEmptyTool.h"

@interface RJFormTextViewItem ()

@end

@implementation RJFormTextViewItem

#pragma mark - Init Methods

+ (instancetype)itemWithText:(NSString *)text detailText:(NSString *)detailText
{
    RJFormTextViewItem *item = [[self alloc] init];
    item.text = text;
    item.detailText = detailText;
    return item;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.text = @"";
        self.textFont = [UIFont systemFontOfSize:16.0];
        self.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        
        self.detailTextFont = [UIFont systemFontOfSize:15.0];
        self.detailTextColor = [UIColor colorWithRed:93.0/255.0 green:93.0/255.0 blue:93.0/255.0 alpha:1.0];
        NSDictionary *attriDic = @{
                                   NSForegroundColorAttributeName : [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:199.0/255.0 alpha:1.0],
                                   NSFontAttributeName : [UIFont systemFontOfSize:15.0 weight:UIFontWeightRegular]
                                   };
        self.detailAttributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请填写" attributes:attriDic];
    }
    return self;
}

#pragma mark - RJFormItemValue Methods

- (NSString *)itemValue
{
    return self.detailText;
}

- (RJFormValidationStatus *)doValidation
{
    RJFormValidationStatus *status = nil;
    if (self.required && [RJFormEmptyTool stringIsEmpty:[self itemValue]])
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

