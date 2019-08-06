//
//  RJFormOptionItem.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/6.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormOptionItem.h"

@implementation RJFormOptionItem

#pragma mark - Init Methods

+ (instancetype)itemWithOptionText:(NSString *)optionText optionValue:(id)optionValue
{
    return [[self alloc] initWithOptionText:optionText optionValue:optionValue];
}

- (instancetype)initWithOptionText:(NSString *)optionText optionValue:(id)optionValue
{
    if (self = [super init])
    {
        self.optionText = optionText;
        self.optionValue = optionValue;
    }
    return self;
}

@end
