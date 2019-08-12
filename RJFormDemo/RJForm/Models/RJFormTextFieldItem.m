//
//  RJFormTextFieldItem.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/25.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormTextFieldItem.h"
#import "RJFormEmptyTool.h"
#import "RJFormValidationStatus.h"
#import "RJFormValidatorProtocol.h"

@implementation RJFormTextFieldItem

+ (instancetype)itemWithText:(NSString *)text detailText:(NSString *)detailText
{
    return [self itemWithText:text detailText:detailText detailPlaceholder:nil];
}

+ (instancetype)itemWithText:(NSString *)text detailText:(NSString *)detailText detailPlaceholder:(NSString *)detailPlaceholder
{
    RJFormTextFieldItem *textFieldItem = [[self alloc] init];
    textFieldItem.text = text;
    textFieldItem.detailText = detailText;
    if (detailPlaceholder && detailPlaceholder.length > 0)
    {
        NSDictionary *attriDic = @{
                                   NSForegroundColorAttributeName : [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:199.0/255.0 alpha:1.0],
                                   NSFontAttributeName : [UIFont systemFontOfSize:15.0 weight:UIFontWeightRegular]
                                   };
        textFieldItem.detailAttributedPlaceholder = [[NSAttributedString alloc] initWithString:detailPlaceholder attributes:attriDic];
    }
    
    return textFieldItem;
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
        self.detailTextAlignment = NSTextAlignmentRight;
        self.detailKeyboardType = UIKeyboardTypeDefault;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
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
    
#warning 自定义的正则表达式
    
    id itemValue = [self itemValue];
    for (id<RJFormValidatorProtocol>validator in self.regexValidators) {
        if (![validator conformsToProtocol:@protocol(RJFormValidatorProtocol)])
        {
            continue;
        }
        
        RJFormValidationStatus *validateStatus = [validator doValidation:itemValue];
        if (validateStatus && !validateStatus.validate)
        {
            return validateStatus;
        }
    }
    
    return status;
}


@end
