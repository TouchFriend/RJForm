//
//  RJFormSectionDescriptor.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormSectionDescriptor.h"
#import "RJFormRowDescriptor.h"

@implementation RJFormSectionDescriptor



#pragma mark - Properties Methods

- (NSMutableArray<RJFormRowDescriptor *> *)formRows
{
    if (_formRows == nil)
    {
        _formRows = [NSMutableArray array];
    }
    return _formRows;
}

@end
