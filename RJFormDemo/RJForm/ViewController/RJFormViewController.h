//
//  RJFormViewController.h
//  RJFormDemo
//
//  Created by TouchWorld on 2020/4/22.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RJFormDescriptor.h"
#import "RJFormSectionDescriptor.h"
#import "RJFormRowDescriptor.h"
#import "RJFormBaseItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface RJFormViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

/// tableView style
@property (nonatomic, assign) UITableViewStyle style;
/// tableView
@property (nonatomic, weak) UITableView *tableView;
/// 表单
@property (nonatomic, strong) RJFormDescriptor *form;

- (instancetype)initWithForm:(RJFormDescriptor *_Nullable)form;

- (instancetype)initWithForm:(RJFormDescriptor *_Nullable)form style:(UITableViewStyle)style;

@end

NS_ASSUME_NONNULL_END
