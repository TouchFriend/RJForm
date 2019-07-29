//
//  RJFormRegexValidator.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/29.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormValidator.h"

NS_ASSUME_NONNULL_BEGIN

@interface RJFormRegexValidator : RJFormValidator

/********* 错误信息 *********/
@property (nonatomic, copy) NSString *errorMsg;
/********* 正则表达式 *********/
@property (nonatomic, copy) NSString *regex;

+ (instancetype)validatorWithErrorMsg:(NSString *)errorMsg regex:(NSString *)regex;

- (instancetype)initWithErrorMsg:(NSString *)errorMsg regex:(NSString *)regex;

@end

NS_ASSUME_NONNULL_END
