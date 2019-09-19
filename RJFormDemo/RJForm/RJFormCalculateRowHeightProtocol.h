//
//  RJFormCalculateRowHeightProtocol.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/9/19.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 如果是动态改变cell高度的，请遵守此协议，并更加内容计算新的cell高度
 **/
@protocol RJFormCalculateRowHeightProtocol <NSObject>

@required

- (CGFloat)calculateRowHeight;

@end

NS_ASSUME_NONNULL_END
