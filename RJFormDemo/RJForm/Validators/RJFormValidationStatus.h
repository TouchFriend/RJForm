//
//  RJFormValidationStatus.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/26.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RJFormRowDescriptor;
NS_ASSUME_NONNULL_BEGIN

@interface RJFormValidationStatus : NSObject

/********* 错误提示 *********/
@property (nonatomic, copy) NSString *msg;
/********* 是否验证成功 *********/
@property (nonatomic, assign, getter=isValidte) BOOL validate;
/********* 行信息 *********/
@property (nonatomic, weak) RJFormRowDescriptor *rowDescriptor;

- (instancetype)initWithMsg:(NSString *)msg validate:(BOOL)validate rowDescriptor:(RJFormRowDescriptor *_Nullable)rowDescriptor;

+ (instancetype)validationStatusWithMsg:(NSString *)msg validate:(BOOL)validate;

+ (instancetype)validationStatusWithMsg:(NSString *)msg validate:(BOOL)validate rowDescriptor:(RJFormRowDescriptor *_Nullable)rowDescriptor;

@end

NS_ASSUME_NONNULL_END
