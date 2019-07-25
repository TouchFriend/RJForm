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

- (void)updateViewData:(id)data;

@end

NS_ASSUME_NONNULL_END
