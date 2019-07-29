//
//  RJFormEnterpriseInfoViewController.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/29.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormEnterpriseInfoViewController.h"
#import "RJForm.h"

@interface RJFormEnterpriseInfoViewController () <UITableViewDataSource, UITableViewDelegate>

/********* tableView *********/
@property (nonatomic, weak) UITableView *tableView;
/********* 数据 *********/
@property (nonatomic, strong) RJFormDescriptor *form;

@end

@implementation RJFormEnterpriseInfoViewController

#pragma mark - Life Cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupInit];
}

#pragma mark - Setup Init

- (void)setupInit
{
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    [self setupNaviBar];
    
    [self setupTableView];
    
    [self initializeForm];
}

#pragma mark - Navigation Bar

- (void)setupNaviBar
{
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveBtnClick)];
    self.navigationItem.rightBarButtonItems = @[saveItem];
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
    tableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.estimatedRowHeight = 0.0;
    tableView.estimatedSectionHeaderHeight = 0.0;
    tableView.estimatedSectionFooterHeight = 0.0;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorColor = [UIColor colorWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0];
    tableView.separatorInset = UIEdgeInsetsMake(0, 15.0, 0, 15.0);
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
}

- (void)initializeForm
{
    RJFormDescriptor *form;
    RJFormSectionDescriptor *section;
    RJFormRowDescriptor *row;
    
    form = [RJFormDescriptor formWithTableView:self.tableView];
    self.form = form;
    
    
    
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    RJFormSectionDescriptor *sectionDescriptor = self.form.formSections[section];
    return sectionDescriptor.sectionHeaderTitle;
}


#pragma mark - Override Methods

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Target Methods

- (void)saveBtnClick
{
    
}

#pragma mark - Properties Methods

@end
