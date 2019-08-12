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


@end

NS_ASSUME_NONNULL_END
