//
//  RJFormBaseItem.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/24.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormBaseItem.h"
#import "RJFormValidatorProtocol.h"

@interface RJFormBaseItem ()

/********* 正则表达式 *********/
@property (readwrite, nonatomic, strong) NSMutableArray<id<RJFormValidatorProtocol>> *regexValidators;


@end

@implementation RJFormBaseItem

- (instancetype)init
{
    if (self = [super init])
    {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.separatorInset = UIEdgeInsetsZero;
        self.required = NO;
        self.regexValidators = [NSMutableArray array];
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

- (void)addValidator:(id<RJFormValidatorProtocol>)validator
{
    if (!validator || ![validator conformsToProtocol:@protocol(RJFormValidatorProtocol)])
    {
        return;
    }
    
    if ([self.regexValidators containsObject:validator])
    {
        return;
    }
    
    [self.regexValidators addObject:validator];
}

- (void)removeValidator:(id<RJFormValidatorProtocol>)validator
{
    if (!validator || ![validator conformsToProtocol:@protocol(RJFormValidatorProtocol)])
    {
        return;
    }
    
    if (![self.regexValidators containsObject:validator])
    {
        return;
    }
    
    [self.regexValidators removeObject:validator];
}

- (void)removeAllValidators
{
    [self.regexValidators removeAllObjects];
}

@end
