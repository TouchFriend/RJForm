//
//  RJFormImagePickerContentItem.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/12.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJFormImagePickerContentItem : NSObject

/********* 本地图片，优先显示 *********/
@property (nonatomic, copy) UIImage *localImage;
/********* 网络图片地址 *********/
@property (nonatomic, copy) NSString *imageUrl;
/********* 是否是添加图片 *********/
@property (nonatomic, assign) BOOL isAdd;


@end

NS_ASSUME_NONNULL_END
