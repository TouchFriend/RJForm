//
//  RJFormSwitchItem.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormSwitchItem.h"

@implementation RJFormSwitchItem

+ (instancetype)itemWithText:(NSString *)text open:(BOOL)open
{
    return [self itemWithText:text open:open switchSelector:nil];
}

+ (instancetype)itemWithText:(NSString *)text open:(BOOL)open switchSelector:(NSString *)switchSelector
{
    RJFormSwitchItem *switchItem = [[self alloc] init];
    switchItem.text = text;
    switchItem.open = open;
    switchItem.switchSelector = switchSelector;
    return switchItem;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.textFont = [UIFont systemFontOfSize:17.0];
        self.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        
    }
    return self;
}

#pragma mark - RJFormItemValue Methods

- (NSNumber *)itemValue
{
    return [NSNumber numberWithBool:self.open];
}

@end
