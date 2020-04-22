//
//  RJFormDemoViewController.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormDemoViewController.h"
#import "RJForm.h"
#import <Masonry/Masonry.h>

@interface RJFormDemoViewController () <UITableViewDataSource, UITableViewDelegate>

/********* tableView *********/
@property (nonatomic, weak) UITableView *tableView;

/********* 数据 *********/
@property (nonatomic, strong) RJFormDescriptor *form;


@end

@implementation RJFormDemoViewController

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
    
    [self initializeForm];
}

#pragma mark - TableView

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView = tableView;
    tableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.estimatedRowHeight = 0.0;
    tableView.estimatedSectionHeaderHeight = 0.0;
    tableView.estimatedSectionFooterHeight = 0.0;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorColor = [UIColor colorWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0];
    //    tableView.separatorInset = UIEdgeInsetsMake(0, 52.0, 0, 0);
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
}

#pragma mark - Init Form

- (void)initializeForm
{
    RJFormDescriptor *form;
    RJFormSectionDescriptor *section;
    RJFormRowDescriptor *row;
    
    NSMutableArray *formSections = [NSMutableArray array];
    
    form = [RJFormDescriptor formWithTableView:self.tableView];
    self.form = form;
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 10.0;
    [formSections addObject:section];
    
    RJFormImageItem *rightIconItem = [RJFormImageItem itemWithText:@"头像" iconImage:[UIImage imageNamed:@"zhanweijian"] style:RJFormImageCellStyleRight];
    rightIconItem.hiddenArrow = NO;
    row = [RJFormRowDescriptor rowWithItem:rightIconItem];
    row.rowHeight = 90.0;
    [section.formRows addObject:row];
    
    RJFormImageItem *middleIconItem = [RJFormImageItem itemWithText:@"头像" iconImage:[UIImage imageNamed:@"zhanweijian"] style:RJFormImageCellStyleMiddle];
    middleIconItem.hiddenArrow = NO;
    row = [RJFormRowDescriptor rowWithItem:middleIconItem];
    row.rowHeight = 90.0;
    [section.formRows addObject:row];
    
    RJFormImageItem *leftIconItem = [RJFormImageItem itemWithText:@"头像" iconImage:[UIImage imageNamed:@"zhanweijian"] style:RJFormImageCellStyleLeft];
    leftIconItem.hiddenArrow = NO;
    row = [RJFormRowDescriptor rowWithItem:leftIconItem];
    row.rowHeight = 90.0;
    [section.formRows addObject:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 10.0;
    [formSections addObject:section];
    
    RJFormInfoItem *infoItem = [RJFormInfoItem itemWithText:@"手机号" detailText:@"182******25"];
    infoItem.hiddenArrow = NO;
    row = [RJFormRowDescriptor rowWithItem:infoItem];
    [section.formRows addObject:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 10.0;
    [formSections addObject:section];
    
    RJFormInfoItem *changePwdItem = [RJFormInfoItem itemWithText:@"修改密码" detailText:@""];
    changePwdItem.hiddenArrow = NO;
    row = [RJFormRowDescriptor rowWithItem:changePwdItem];
    [section.formRows addObject:row];
    RJFormSwitchItem *notificationItem = [RJFormSwitchItem itemWithText:@"消息通知设置" open:YES];
    row = [RJFormRowDescriptor rowWithItem:notificationItem];
    [section.formRows addObject:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 10.0;
    [formSections addObject:section];
    
    RJFormInfoItem *versionUpdateItem = [RJFormInfoItem itemWithText:@"版本更新" detailText:@"最新版本v1.0"];
    versionUpdateItem.hiddenArrow = YES;
    row = [RJFormRowDescriptor rowWithItem:versionUpdateItem];
    [section.formRows addObject:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 10.0;
    [formSections addObject:section];
    
    
//    [formSections addObjectsFromArray:formSections];
//    [formSections addObjectsFromArray:formSections];
//    [formSections addObjectsFromArray:formSections];
    [form.formSections addObjectsFromArray:formSections];
    
    //注册cell
    [form registerAllCells];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.form.formSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    RJFormSectionDescriptor *sectionDescriptor = self.form.formSections[section];
    return sectionDescriptor.formRows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RJFormSectionDescriptor *sectionDescriptor = self.form.formSections[indexPath.section];
    RJFormRowDescriptor *rowDescriptor = sectionDescriptor.formRows[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rowDescriptor.reuseIdentifier forIndexPath:indexPath];
//    NSLog(@"%p--%ld--%ld", cell, indexPath.section, indexPath.row);
    [rowDescriptor updateCell:cell];
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RJFormSectionDescriptor *sectionDescriptor = self.form.formSections[indexPath.section];
    RJFormRowDescriptor *rowDescriptor = sectionDescriptor.formRows[indexPath.row];
    return rowDescriptor.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    RJFormSectionDescriptor *sectionDescriptor = self.form.formSections[section];
    return sectionDescriptor.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    RJFormSectionDescriptor *sectionDescriptor = self.form.formSections[section];
    return sectionDescriptor.sectionFooterHeight;
}


#pragma mark - Override Methods

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Properties Methods

@end
