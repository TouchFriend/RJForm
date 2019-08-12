//
//  RJFormButtonItem.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/24.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormButtonItem.h"

@implementation RJFormButtonItem

+ (instancetype)itemWithText:(NSString *)text selector:(NSString *)clickedSelector
{
    RJFormButtonItem *buttonItem = [[self alloc] init];
    buttonItem.text = text;
    buttonItem.clickedSelector = clickedSelector;
    return buttonItem;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.text = @"";
        self.textFont = [UIFont systemFontOfSize:18.0];
        self.textColor = [UIColor whiteColor];
        self.insets = UIEdgeInsetsMake(0.0, 15.0, 0.0, 15.0);
        self.buttonBackgroudColor = [UIColor colorWithRed:34.0/255.0 green:161.0/255.0 blue:241.0/255.0 alpha:1.0];
        self.cornerRadius = 4.0;
        
        self.cellBackgroudColor = [UIColor clearColor];
    }
    return self;
}

@end
