//
//  RJFormBaseCell.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormBaseCell.h"
#import "RJFormBaseItem.h"
#import "RJFormBaseItem.h"

@interface RJFormBaseCell ()

/********* 头部分割线(分组第一个cell有) *********/
@property (nonatomic, weak) UIView *topSeparatorView;
/********* 底部分割线 *********/
@property (nonatomic, weak) UIView *bottomSeparatorView;
/********* 数据 *********/
@property (nonatomic, weak) RJFormBaseItem *baseData;

@end

@implementation RJFormBaseCell



#pragma mark - Overload Methods

- (void)prepareForReuse
{
    [super prepareForReuse];

    if (self.topSeparatorView)
    {
        self.topSeparatorView.hidden = NO;
    }
    if (self.bottomSeparatorView)
    {
        self.bottomSeparatorView.hidden = NO;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    __weak typeof(self) weakSelf = self;
    //class:_UITableViewCellSeparatorView,
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[obj class] isEqual:NSClassFromString(@"_UITableViewCellSeparatorView")])
        {
            if (CGRectGetMinY(obj.frame) == 0)
            {
                weakSelf.topSeparatorView = obj;
            }
            else
            {
                weakSelf.bottomSeparatorView = obj;
            }
            
//            NSLog(@"class:%@, obj:%@", NSStringFromClass([obj class]), obj);
        }
        
    }];
    
    if (self.topSeparatorView)
    {
        self.topSeparatorView.hidden = self.baseData.topSeparatorViewHidden;
    }
    if (self.bottomSeparatorView)
    {
        self.bottomSeparatorView.hidden = self.baseData.bottomSeparatorViewHidden;
    }
}

#pragma mark - Public Methods

- (UIViewController *)viewController
{
    id responder = self;
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]])
        {
            return responder;
        }
        responder = [responder nextResponder];
    }
    
    return nil;
}

- (void)updateViewData:(id)data tag:(NSString *)tag
{
    self.baseData = data;
    self.itemTag = tag;
}

@end
