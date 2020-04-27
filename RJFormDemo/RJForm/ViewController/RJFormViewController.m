//
//  RJFormViewController.m
//  RJFormDemo
//
//  Created by TouchWorld on 2020/4/22.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import "RJFormViewController.h"
#import <Masonry/Masonry.h>
#import "RJFormSectionHeaderFooterView.h"

@interface RJFormViewController ()

/// tableView style
@property (nonatomic, assign) UITableViewStyle style;

@end

@implementation RJFormViewController

#pragma mark - Initialize

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super init]) {
        self.style = style;
    }
    return self;
}

#pragma mark - Life Cycles

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupInitialize];
}

#pragma mark - Setting

- (void)setupInitialize {
    [self setupTableView];
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.style];
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
    //    tableView.separatorInset = UIEdgeInsetsMake(0, 52.0, 0, 0);
    
    tableView.dataSource = self;
    tableView.delegate = self;
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
    RJFormSectionDescriptor *sectionDescriptor = self.form.formSections[indexPath.section];
    RJFormRowDescriptor *rowDescriptor = sectionDescriptor.formRows[indexPath.row];
    
    //是否可编辑
    if ([rowDescriptor.item isKindOfClass:[RJFormBaseItem class]] && ![(RJFormBaseItem *)rowDescriptor.item enabled])
    {
        return ;
    }
    
    if (rowDescriptor.didSelectedSelector && rowDescriptor.didSelectedSelector.length > 0 && [self respondsToSelector:NSSelectorFromString(rowDescriptor.didSelectedSelector)])
    {
        SEL selector = NSSelectorFromString(rowDescriptor.didSelectedSelector);
        
        //内存泄露警告,因为编译器不知道selector是哪个方法id，需要在runtime才知道
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:selector withObject:rowDescriptor];
#pragma clang diagnostic pop
        
        return;
    }
    
    [self.form tableView:tableView didSelectRowAtIndexPath:indexPath formController:self];
    
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    RJFormSectionDescriptor *sectionDescriptor = self.form.formSections[section];
    RJFormSectionHeaderFooterView *sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionDescriptor.sectionHeaderViewReuseIdentifier];
    [sectionHeaderView updateViewData:sectionDescriptor.sectionHeaderData];
    return sectionHeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    RJFormSectionDescriptor *sectionDescriptor = self.form.formSections[section];
    RJFormSectionHeaderFooterView *sectionFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionDescriptor.sectionFooterViewReuseIdentifier];
    [sectionFooterView updateViewData:sectionDescriptor.sectionFooterData];
    return sectionFooterView;
}

@end
