//
//  RJFormInfoItem.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormInfoItem.h"

@implementation RJFormInfoItem

#pragma mark - Init Methods

+ (instancetype)itemWithText:(NSString *)text detailText:(NSString *)detailText
{
    RJFormInfoItem *infoItem = [[self alloc] init];
    infoItem.text = text;
    infoItem.detailText = detailText;
    return infoItem;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.textFont = [UIFont systemFontOfSize:17.0];
        self.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        
        self.detailTextFont = [UIFont systemFontOfSize:14.0];
        self.detailTextColor = [UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1.0];
    }
    return self;
}

#pragma mark - RJFormItemValue Methods

- (NSString *)itemValue
{
    return self.detailText;
}

@end
