//
//  RJFormMainViewController.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/24.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormMainViewController.h"
#import "RJFormAllSimpleViewController.h"
#import "RJFormSettingViewController.h"

static NSString * const ID = @"UITableViewCell";

@interface RJFormMainViewController () <UITableViewDataSource, UITableViewDelegate>

/********* tableView *********/
@property (nonatomic, weak) UITableView *tableView;
/********* <#注释#> *********/
@property (nonatomic, strong) NSArray *dataArr;


@end

@implementation RJFormMainViewController

#pragma mark - Life Cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupInit];
}

#pragma mark - Setup Init

- (void)setupInit
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTableView];
    
}

#pragma mark - TableView

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView = tableView;
    tableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.estimatedRowHeight = 0.1;
    tableView.estimatedSectionHeaderHeight = 0.1;
    tableView.estimatedSectionFooterHeight = 0.1;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorColor = [UIColor colorWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0];
    //    tableView.separatorInset = UIEdgeInsetsMake(0, 52.0, 0, 0);
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dataDic = self.dataArr[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.textLabel.text = dataDic[@"title"];
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dataDic = self.dataArr[indexPath.row];
    NSString *classStr = dataDic[@"controller"];
    if (classStr == nil || classStr.length == 0)
    {
        return;
    }
    Class controllerClass = NSClassFromString(classStr);
    UIViewController *vc = [[controllerClass alloc] init];
    vc.title = dataDic[@"title"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - Properties Methods

- (NSArray *)dataArr
{
    if (_dataArr == nil)
    {
        _dataArr = @[
                     @{
                         @"title" : @"全部示例",
                         @"controller" : NSStringFromClass([RJFormAllSimpleViewController class])
                         },
                     @{
                         @"title" : @"设置中心",
                         @"controller" : NSStringFromClass([RJFormSettingViewController class])
                         },
                     ];
    }
    return _dataArr;
}
@end
