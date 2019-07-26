//
//  RJFormEmptyTool.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/26.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormEmptyTool.h"

@implementation RJFormEmptyTool

+ (BOOL)stringIsEmpty:(NSString *)text
{
    return !text || text.length == 0 || [text isKindOfClass:[NSNull class]];
}

@end
