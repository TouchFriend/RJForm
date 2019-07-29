//
//  RJFormRegexValidator.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/29.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormRegexValidator.h"
#import "RJFormValidationStatus.h"

@implementation RJFormRegexValidator

#pragma mark - Init Methods

+ (instancetype)validatorWithErrorMsg:(NSString *)errorMsg regex:(NSString *)regex
{
    return [[self alloc] initWithErrorMsg:errorMsg regex:regex];
}

- (instancetype)initWithErrorMsg:(NSString *)errorMsg regex:(NSString *)regex
{
    if (self = [super init])
    {
        self.errorMsg = errorMsg;
        self.regex = regex;
    }
    return self;
}

#pragma mark - RJFormValidatorProtocol Methods

- (RJFormValidationStatus *)doValidation:(id)value
{
    
    if (value == nil)
    {
        return nil;
    }
    
    if ([value isKindOfClass:[NSNumber class]])
    {
        value = [value stringValue];
    }
    
    if (![value isKindOfClass:[NSString class]] || [value length] == 0)
    {
        return nil;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.regex];
    BOOL flag = [predicate evaluateWithObject:[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    return [RJFormValidationStatus validationStatusWithMsg:self.errorMsg validate:flag];
}

@end
