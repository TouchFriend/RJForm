//
//  NSBundle+RJFormBundle.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/12.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "NSBundle+RJFormBundle.h"
#import "RJFormDescriptor.h"

@implementation NSBundle (RJFormBundle)

+ (instancetype)rj_formBundle
{
    static NSBundle *formBundle = nil;
    if (formBundle == nil)
    {
        // 这里不使用mainBundle是为了适配pod 1.x和0.x
        NSBundle *bundle = [NSBundle bundleForClass:[RJFormDescriptor class]];
        formBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"RJForm" ofType:@"bundle"]];
    }
    return formBundle;
}

@end
