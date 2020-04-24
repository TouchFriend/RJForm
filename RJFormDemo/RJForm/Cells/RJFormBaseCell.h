//
//  RJFormBaseCell.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RJFormCellDataUpdateProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface RJFormBaseCell : UITableViewCell <RJFormCellDataUpdateProtocol>


/**
 获取cell所在的控制器

 @return 控制器
 */
- (UIViewController *)viewController;

/********* 模型标签 *********/
@property (nonatomic, copy) NSString *itemTag;


@end

NS_ASSUME_NONNULL_END
