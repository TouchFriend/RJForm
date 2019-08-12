//
//  RJFormImagePickerCollectionViewCell.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/9.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RJFormImagePickerContentItem;

NS_ASSUME_NONNULL_BEGIN

@interface RJFormImagePickerCollectionViewCell : UICollectionViewCell

/********* 模型 *********/
@property (nonatomic, strong) RJFormImagePickerContentItem *contentItem;
/********* 删除回调 *********/
@property (nonatomic, copy) void (^deleteBlock)(RJFormImagePickerContentItem *contentItem);


@end

NS_ASSUME_NONNULL_END
