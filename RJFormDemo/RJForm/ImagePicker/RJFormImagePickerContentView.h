//
//  RJFormImagePickerContentView.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/9.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RJFormImagePickerContentItem;
NS_ASSUME_NONNULL_BEGIN

@interface RJFormImagePickerContentView : UIView

- (void)changeImages:(NSMutableArray<RJFormImagePickerContentItem *> * _Nullable)imagesM;

/**
 点击图片时，外部实现展示图片。
 两个参数 第一个NSNumber,点击第几张图片。第二个参数，NSArray,图片数据数组。
 默认为nil，使用默认的行为
 **/
@property (nonatomic, copy) NSString *didTapImageSelector;

@end

NS_ASSUME_NONNULL_END
