//
//  RJFormCellDataUpdate.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RJFormCellDataUpdate <NSObject>

@required

/**
 更新cell的数据

 @param data 数据
 @param tag 标签
 */
- (void)updateViewData:(id)data tag:(NSString *)tag;

@end

NS_ASSUME_NONNULL_END
