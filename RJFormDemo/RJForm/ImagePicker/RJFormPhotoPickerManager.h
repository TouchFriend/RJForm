//
//  RJFormPhotoPickerManager.h
//  Destination
//
//  Created by TouchWorld on 2018/11/14.
//  Copyright © 2018 Redirect. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PHAsset;

typedef void (^RJFormPickImageCompletedBlock)(UIImage * _Nullable image, NSError * _Nullable error);

typedef NS_ENUM(NSUInteger, RJFormPhotoPickerType)
{
    RJFormPhotoPickerTypePhotoLibrary = 0,
    RJFormPhotoPickerTypeCamera,
    RJFormPhotoPickerTypeSavedPhotosAlbum
};

NS_ASSUME_NONNULL_BEGIN

@interface RJFormPhotoPickerManager : NSObject

+ (instancetype)shareInstance;


/**
 选择图片 不需要asset

 @param type 类型
 @param vc 控制器
 @param completed 回调
 */
- (void)presentPicker:(RJFormPhotoPickerType)type target:(UIViewController *)vc completed:(RJFormPickImageCompletedBlock _Nullable)completed;

@end

NS_ASSUME_NONNULL_END
