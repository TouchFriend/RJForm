//
//  RJFormImageTapProtocol.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/28.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RJFormImageItem, RJFormImagePickerContentItem;
NS_ASSUME_NONNULL_BEGIN

@protocol RJFormImageTapProtocol <NSObject>

@optional


/**
 如果实现此方法，点击RJFormInfoCell的头像时，会调用此方法,由外部展示大图

 @param tag 标签
 @param item 图片数据
 */
- (void)singleImageTapWithTag:(NSString *)tag data:(RJFormImageItem *)item;


/**
 如果实现此方法，点击RJFormImagePickerCell的图片时，会调用此方法,由外部展示大图

 @param tag 标签
 @param index 图片下标
 @param images 图片数据
 */
- (void)multipleImageTapWithTag:(NSString *)tag index:(NSUInteger)index images:(NSArray<RJFormImagePickerContentItem *> *)images;

@end

NS_ASSUME_NONNULL_END
