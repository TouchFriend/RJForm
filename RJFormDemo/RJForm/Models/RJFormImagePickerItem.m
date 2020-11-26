//
//  RJFormImagePickerItem.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/9.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormImagePickerItem.h"
#import "RJFormImagePickerContentItem.h"
#import "RJFormConstant.h"
#import "RJFormEmptyTool.h"
#import "RJFormValidationStatus.h"

@interface RJFormImagePickerItem ()

@property (readwrite, nonatomic, strong) NSMutableArray<RJFormImagePickerContentItem *> *contentItemArrM;

@end

@implementation RJFormImagePickerItem

#pragma mark - Init Methods

+ (instancetype)itemWithText:(NSString *)text imageArr:(NSArray<RJFormImagePickerContentItem *> *)imageArr
{
    RJFormImagePickerItem *item = [[self alloc] init];
    item.text = text;
    [item.contentItemArrM addObjectsFromArray:imageArr];
    
    //计算行高
    [item calculateRowHeight];
    return item;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.text = @"";
        self.textFont = [UIFont systemFontOfSize:16.0];
        self.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        self.imageMaxCount = 6;
    }
    return self;
}

- (NSMutableArray<RJFormImagePickerContentItem *> *)contentItemArrM
{
    if (_contentItemArrM == nil)
    {
        _contentItemArrM = [NSMutableArray array];
    }
    return _contentItemArrM;
}

- (NSMutableArray<RJFormImagePickerContentItem *> *)getContentArrMWithAddButton
{
    //如果超出最大图片数量
    if (self.contentItemArrM.count > self.imageMaxCount)
    {
        [self.contentItemArrM removeObjectsInRange:NSMakeRange(self.imageMaxCount, self.contentItemArrM.count - self.imageMaxCount)];
    }
    
    //添加+号按钮
    if(self.contentItemArrM.lastObject.isAdd == NO && self.contentItemArrM.count < self.imageMaxCount)
    {
        RJFormImagePickerContentItem * item = [[RJFormImagePickerContentItem alloc] init];
        item.isAdd = YES;
        
        [self.contentItemArrM addObject:item];
    }
    return self.contentItemArrM;
}

- (NSMutableArray<RJFormImagePickerContentItem *> *)getContentArrMNoAddButton
{
    NSMutableArray<RJFormImagePickerContentItem *> *imagesArrM = [self.contentItemArrM mutableCopy];
    
    //如果超出最大图片数量
    if (imagesArrM.count > self.imageMaxCount)
    {
        [imagesArrM removeObjectsInRange:NSMakeRange(self.imageMaxCount, imagesArrM.count - self.imageMaxCount)];
    }
    
    //添加+号按钮
    if(imagesArrM.lastObject.isAdd == YES)
    {
        [imagesArrM removeLastObject];
    }
    return imagesArrM;
}

- (CGFloat)calculateRowHeight
{
    NSMutableArray<RJFormImagePickerContentItem *> *imageArrM = [self getContentArrMWithAddButton];
    NSUInteger column = 3;
    NSUInteger rowCount = (imageArrM.count + column - 1) / column;
    //33 + 20.0 + 23.0
    CGFloat rowHeight = 76.0;
    CGFloat itemWidth = (RJScreenWidth - 56.0) / 3.0;
    rowHeight += rowCount * itemWidth + (rowCount - 1) * 7.0;
    
    self.rowHeight = rowHeight;
    
    return rowHeight;
}

#pragma mark - RJFormItemValue Methods

- (NSArray<RJFormImagePickerContentItem *> *)itemValue
{
    return [self getContentArrMNoAddButton];
}

- (RJFormValidationStatus *)doValidation
{
    RJFormValidationStatus *status = nil;
    NSArray *imageArr = [self itemValue];
    if (self.required && (!imageArr || imageArr.count == 0))
    {
        status = [RJFormValidationStatus validationStatusWithMsg:@"" validate:NO];
        if (![RJFormEmptyTool stringIsEmpty:self.requireMsg])
        {
            status.msg = self.requireMsg;
            return status;
        }
        
        if (![RJFormEmptyTool stringIsEmpty:self.text])
        {
            status.msg = [NSString stringWithFormat:@"%@不能为空", self.text];
            return status;
        }
        
        if (![RJFormEmptyTool stringIsEmpty:self.tag])
        {
            status.msg = [NSString stringWithFormat:@"%@不能为空", self.tag];
            return status;
        }
    }
    
    return status;
}


@end
