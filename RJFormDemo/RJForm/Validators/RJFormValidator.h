//
//  RJFormValidator.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/29.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RJFormValidatorProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface RJFormValidator : NSObject <RJFormValidatorProtocol>

+ (RJFormValidator *)emailValidator;

+ (RJFormValidator *)emailValidatorLong;

@end

NS_ASSUME_NONNULL_END
