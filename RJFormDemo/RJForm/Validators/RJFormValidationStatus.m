//
//  RJFormValidationStatus.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/26.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormValidationStatus.h"
#import "RJFormRowDescriptor.h"

@implementation RJFormValidationStatus

- (instancetype)initWithMsg:(NSString *)msg validate:(BOOL)validate rowDescriptor:(RJFormRowDescriptor *)rowDescriptor
{
    if(self = [super init])
    {
        self.msg = msg;
        self.validate = validate;
        self.rowDescriptor = rowDescriptor;
    }
    return self;
}

+ (instancetype)validationStatusWithMsg:(NSString *)msg validate:(BOOL)validate
{
    return [self validationStatusWithMsg:msg validate:validate rowDescriptor:nil];
}

+ (instancetype)validationStatusWithMsg:(NSString *)msg validate:(BOOL)validate rowDescriptor:(RJFormRowDescriptor *)rowDescriptor
{
    return [[self alloc] initWithMsg:msg validate:validate rowDescriptor:rowDescriptor];
}

@end
