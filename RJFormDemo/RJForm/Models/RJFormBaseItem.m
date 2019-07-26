//
//  RJFormBaseItem.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/24.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormBaseItem.h"

@implementation RJFormBaseItem

- (instancetype)init
{
    if (self = [super init])
    {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.separatorInset = UIEdgeInsetsMake(0.0, 15.0, 0.0, 0.0);
        self.required = NO;
    }
    return self;
}

- (id)itemValue
{
    return nil;
}

@end
