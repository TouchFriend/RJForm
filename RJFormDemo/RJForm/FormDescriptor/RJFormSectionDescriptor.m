//
//  RJFormSectionDescriptor.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormSectionDescriptor.h"
#import "RJFormRowDescriptor.h"

@interface RJFormSectionDescriptor ()

@end

@implementation RJFormSectionDescriptor

#pragma mark - Init Methods

+ (instancetype)sectionWithSectionHeaderHeight:(CGFloat)sectionHeaderHeight sectionFooterHeight:(CGFloat)sectionFooterHeight
{
    RJFormSectionDescriptor *sectionDescriptor = [[self alloc] init];
    sectionDescriptor.sectionHeaderHeight = sectionHeaderHeight;
    sectionDescriptor.sectionFooterHeight = sectionFooterHeight;
    return sectionDescriptor;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.sectionHeaderHeight = 0.1;
        self.sectionFooterHeight = 0.1;
    }
    return self;
}

#pragma mark - Public Methods

- (BOOL)addFormRow:(RJFormRowDescriptor *)row
{
    return [self addFormRow:row atIndex:self.formRows.count];
}

- (BOOL)addFormRow:(RJFormRowDescriptor *)row atIndex:(NSUInteger)index {
    if (!row || index > self.formRows.count)
    {
        return NO;
    }
    [self.formRows insertObject:row atIndex:index];
    return YES;
}

- (BOOL)removeFormRowAtIndex:(NSUInteger)index {
    if (index >= self.formRows.count) {
        return NO;
    }
    
    [self.formRows removeObjectAtIndex:index];
    return YES;
}

- (BOOL)removeFormRow:(RJFormRowDescriptor *)row
{
    if (!row)
    {
        return NO;
    }
    [self.formRows removeObject:row];
    return YES;
}

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
