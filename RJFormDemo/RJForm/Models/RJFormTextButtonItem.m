//
//  RJFormTextButtonItem.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/24.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormTextButtonItem.h"

@implementation RJFormTextButtonItem

+ (instancetype)itemWithText:(NSString *)text
{
    RJFormTextButtonItem *textButtonItem = [[self alloc] init];
    textButtonItem.text = text;
    return textButtonItem;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.text = @"";
        self.textFont = [UIFont systemFontOfSize:17.0];
        self.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        
    }
    return self;
}

@end
