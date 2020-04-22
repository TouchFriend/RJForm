//
//  RJFormImagePickerContentItem.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/12.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJFormImagePickerContentItem : NSObject

/********* 本地图片，优先显示 *********/
@property (nonatomic, copy) UIImage *localImage;
/********* 网络图片地址 *********/
@property (nonatomic, copy) NSString *imageUrl;
/********* 是否是添加图片 *********/
@property (nonatomic, assign) BOOL isAdd;

/********* 本地大图 点击头像优先显示本地大图->网络大图->本地图片->网络图片 *********/
@property (nonatomic, strong) UIImage *_Nullable localLargeImage;
/********* 网络大图 *********/
@property (nonatomic, copy) NSString *webLargeImageUrl;

@end

NS_ASSUME_NONNULL_END
