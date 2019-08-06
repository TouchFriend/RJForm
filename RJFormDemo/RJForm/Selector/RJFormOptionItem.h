//
//  RJFormOptionItem.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/6.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJFormOptionItem : NSObject

/********* 显示文本 *********/
@property (nonatomic, copy) NSString *optionText;
/********* 选项值 *********/
@property (nonatomic, strong) id optionValue;

+ (instancetype)itemWithOptionText:(NSString *)optionText optionValue:(id)optionValue;



@end

NS_ASSUME_NONNULL_END
