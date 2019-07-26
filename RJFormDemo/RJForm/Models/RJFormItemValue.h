//
//  RJFormItemValue.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/24.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RJFormItemValue <NSObject>

@required

- (id)itemValue;

/********* 是否必须的,就值不为空 *********/
@property (nonatomic, assign, getter=isRequired) BOOL required;


@end

NS_ASSUME_NONNULL_END
