//
//  UITextView+RJFormPlaceholder.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/15.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (RJFormPlaceholder)

@property (nonatomic, readonly) UILabel *placeholderLabel;

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong) UIColor *placeholderColor;

+ (UIColor *)RJ_defaultPlaceholderColor;

@end

NS_ASSUME_NONNULL_END
