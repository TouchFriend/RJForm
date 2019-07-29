//
//  RJFormImageItem.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormImageItem.h"
#import "RJFormEmptyTool.h"

@interface RJFormImageItem ()

@end

@implementation RJFormImageItem

#pragma mark - Init Methods

+ (instancetype)itemWithText:(NSString *)text iconImage:(UIImage *)iconImage
{
    return [self itemWithText:text iconImage:iconImage style:RJFormImageCellStyleLeft];
}

+ (instancetype)itemWithText:(NSString *)text iconImage:(UIImage *)iconImage style:(RJFormImageCellStyle)style
{
    RJFormImageItem *imageItem = [[self alloc] init];
    imageItem.text = text;
    imageItem.iconImage = iconImage;
    imageItem.style = style;
    return imageItem;
}

+ (instancetype)itemWithText:(NSString *)text webImageUrl:(NSString *)webImageUrl style:(RJFormImageCellStyle)style
{
    RJFormImageItem *imageItem = [[self alloc] init];
    imageItem.text = text;
    imageItem.webImageUrl = webImageUrl;
    imageItem.style = style;
    return imageItem;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.textFont = [UIFont systemFontOfSize:17.0];
        self.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        self.style = RJFormImageCellStyleLeft;
        
    }
    return self;
}

#pragma mark - RJFormItemValue Methods

- (id)itemValue
{
    if (self.iconImage)
    {
        return self.iconImage;
    }
    
    if (![RJFormEmptyTool stringIsEmpty:self.webImageUrl])
    {
        return self.webImageUrl;
    }
    
    return nil;
}

- (RJFormValidationStatus *)doValidation
{
#warning 还需要处理网络图片地址
    if (!self.iconImage)
    {
        return nil;
    }
    return nil;
}

@end
