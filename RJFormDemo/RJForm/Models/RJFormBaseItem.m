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
        self.separatorInset = UIEdgeInsetsZero;
        self.required = NO;
    }
    return self;
}

- (id)itemValue
{
    return nil;
}

- (RJFormValidationStatus *)doValidation
{
    return nil;
}



@end
