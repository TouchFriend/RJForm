//
//  RJFormSectionHeaderFooterViewUpdateProtocol.h
//  RJFormDemo
//
//  Created by TouchWorld on 2020/4/24.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RJFormSectionHeaderFooterViewUpdateProtocol <NSObject>

@required

/**
 更新分组头部或者尾部的数据

 @param data 数据
 */
- (void)updateViewData:(id)data;

@end

NS_ASSUME_NONNULL_END
