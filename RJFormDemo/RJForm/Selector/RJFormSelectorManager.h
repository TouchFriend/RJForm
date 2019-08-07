//
//  RJFormSelectorManager.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/7.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RJFormSelectorItem;
NS_ASSUME_NONNULL_BEGIN

@interface RJFormSelectorManager : NSObject

+ (instancetype)shareInstance;

- (void)showSelectorViewWithTableView:(UITableView *)tableView item:(RJFormSelectorItem *)item formController:(UIViewController *)formController;

@end

NS_ASSUME_NONNULL_END
