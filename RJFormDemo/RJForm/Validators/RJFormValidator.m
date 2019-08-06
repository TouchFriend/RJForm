//
//  RJFormValidator.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/29.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormValidator.h"
#import "RJFormValidationStatus.h"
#import "RJFormRegexValidator.h"

@implementation RJFormValidator


#pragma mark - Public Methods

+ (RJFormValidator *)emailValidator
{
    return [RJFormRegexValidator validatorWithErrorMsg:@"邮箱格式不正确" regex:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

+ (RJFormValidator *)emailValidatorLong
{
    return [RJFormRegexValidator validatorWithErrorMsg:@"邮箱格式不正确" regex:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,11}"];
}

#warning 添加手机号的正则表达式


#pragma mark - RJFormValidatorProtocol Methods

- (RJFormValidationStatus *)doValidation:(id)value
{
    return [RJFormValidationStatus validationStatusWithMsg:@"" validate:YES];
}

@end
