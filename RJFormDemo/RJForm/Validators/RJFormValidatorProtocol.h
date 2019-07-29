//
//  RJFormValidatorProtocol.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/29.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RJFormValidationStatus;

NS_ASSUME_NONNULL_BEGIN

@protocol RJFormValidatorProtocol <NSObject>

@required

- (RJFormValidationStatus *)doValidation:(id)value;

@end

NS_ASSUME_NONNULL_END
