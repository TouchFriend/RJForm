//
//  RJFormItemValue.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/24.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RJFormValidationStatus;
NS_ASSUME_NONNULL_BEGIN

@protocol RJFormItemValue <NSObject>

@required


/**
 获取row的值

 @return value
 */
- (id)itemValue;

/********* tag(标签) *********/
@property (nonatomic, copy) NSString *tag;
/********* 是否必须的,就值不为空 *********/
@property (nonatomic, assign, getter=isRequired) BOOL required;
/********* 值为空时，显示的提示 *********/
@property (nonatomic, copy) NSString *requireMsg;


- (RJFormValidationStatus *)doValidation;

@end

NS_ASSUME_NONNULL_END
