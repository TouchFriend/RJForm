//
//  RJFormDatePickerManager.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/9.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RJFormDatePickerItem;
NS_ASSUME_NONNULL_BEGIN

@interface RJFormDatePickerManager : NSObject

+ (instancetype)shareInstance;

- (void)showSelectorViewWithTableView:(UITableView *)tableView item:(RJFormDatePickerItem *)item formController:(UIViewController *)formController;

@end

NS_ASSUME_NONNULL_END
