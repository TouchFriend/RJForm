//
//  RJFormCustomCellViewController.m
//  RJFormDemo
//
//  Created by TouchWorld on 2020/4/24.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import "RJFormCustomCellViewController.h"
#import "RJForm.h"
#import "RJFormTestHeaderView.h"
#import "RJFormTestTableViewCell.h"
#import "RJFormTestItem.h"
#import "RJFormTestFooterView.h"
#import "RJFormTestTableHeaderView.h"
#import "RJFormTestTableFooterView.h"

static NSString * const RJUserIconTag = @"RJUserIconTag";
static NSString * const RJPhoneNumberTag = @"RJPhoneNumberTag";
static NSString * const RJChangePwdTag = @"RJChangePwdTag";
static NSString * const RJNotificationTag = @"RJNotificationTag";
static NSString * const RJVersionUpdateTag = @"RJVersionUpdateTag";
static NSString * const RJSectionHeaderID = @"RJFormTestHeaderView";
static NSString * const RJSectionFooterID = @"RJFormTestFooterView";

@interface RJFormCustomCellViewController ()

@end

@implementation RJFormCustomCellViewController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self) {
        return nil;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupInit];
}

#pragma mark - Setup Init

- (void)setupInit
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initializeForm];
}

#pragma mark - Init Form

- (void)initializeForm
{
    RJFormDescriptor *form;
    RJFormSectionDescriptor *section;
    RJFormRowDescriptor *row;
    
    form = [RJFormDescriptor formWithTableView:self.tableView];
    self.form = form;
    
    //注册分组头部和尾部
    [form registerClass:[RJFormTestHeaderView class] forHeaderFooterViewReuseIdentifier:RJSectionHeaderID];
    [form registerClass:[RJFormTestFooterView class] forHeaderFooterViewReuseIdentifier:RJSectionFooterID];
    
    //注册自定义cell
    [form addItemCellClassPair:[RJFormTestItem class] cellClass:[RJFormTestTableViewCell class]];
    
    //TableHeaderView
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self.tableView.tableHeaderView = [[RJFormTestTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, 70.0)];
    self.tableView.tableFooterView = [[RJFormTestTableFooterView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, 70.0)];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 40.0;
    section.sectionFooterHeight = 30.0;
    section.sectionHeaderViewReuseIdentifier = RJSectionHeaderID;
    section.sectionFooterViewReuseIdentifier = RJSectionFooterID;
    section.sectionHeaderData = @"头部测试1";
    section.sectionFooterData = @"尾部测试1";
    [form addFormSection:section];
    
    RJFormImageItem *userIconItem = [RJFormImageItem itemWithText:@"头像" iconImage:[UIImage imageNamed:@"zhanweijian"] style:RJFormImageCellStyleRight];
    userIconItem.hiddenArrow = NO;
    row = [RJFormRowDescriptor rowWithTag:RJUserIconTag item:userIconItem];
    row.rowHeight = 90.0;
    row.didSelectedSelector = @"iconClick:";
    [section addFormRow:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 40.0;
    section.sectionFooterHeight = 30.0;
    section.sectionHeaderViewReuseIdentifier = RJSectionHeaderID;
    section.sectionFooterViewReuseIdentifier = RJSectionFooterID;
    section.sectionHeaderData = @"头部测试2";
    section.sectionFooterData = @"尾部测试2";
    [form addFormSection:section];
    
    RJFormInfoItem *phoneNumberItem = [RJFormInfoItem itemWithText:@"手机号" detailText:@"182******25"];
    phoneNumberItem.hiddenArrow = NO;
    phoneNumberItem.detailTextColor = [UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1.0];
    row = [RJFormRowDescriptor rowWithTag:RJPhoneNumberTag item:phoneNumberItem];
    row.didSelectedSelector = @"phoneClick:";
    [section addFormRow:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 40.0;
    section.sectionFooterHeight = 30.0;
    section.sectionHeaderViewReuseIdentifier = RJSectionHeaderID;
    section.sectionFooterViewReuseIdentifier = RJSectionFooterID;
    section.sectionHeaderData = @"头部测试3";
    section.sectionFooterData = @"尾部测试3";
    [form addFormSection:section];
    
    RJFormInfoItem *changePwdItem = [RJFormInfoItem itemWithText:@"修改密码" detailText:@""];
    changePwdItem.hiddenArrow = NO;
    row = [RJFormRowDescriptor rowWithTag:RJChangePwdTag item:changePwdItem];
    row.didSelectedSelector = @"changePwdClick:";
    [section addFormRow:row];
    
    RJFormSwitchItem *notificationItem = [RJFormSwitchItem itemWithText:@"消息通知设置" open:YES switchSelector:@"notificationSwitchChange:"];
    row = [RJFormRowDescriptor rowWithTag:RJNotificationTag item:notificationItem];
    [section addFormRow:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 10.0;
    section.sectionFooterHeight = 30.0;
    section.sectionFooterViewReuseIdentifier = RJSectionFooterID;
    section.sectionFooterData = @"尾部测试4";
    [form addFormSection:section];
    
    RJFormInfoItem *versionUpdateItem = [RJFormInfoItem itemWithText:@"版本更新" detailText:@"最新版本v1.0"];
    versionUpdateItem.hiddenArrow = YES;
    versionUpdateItem.detailTextColor = [UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1.0];
    row = [RJFormRowDescriptor rowWithTag:RJVersionUpdateTag item:versionUpdateItem];
    row.didSelectedSelector = @"versionUpdateClick:";
    [section addFormRow:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 15.0;
    [form addFormSection:section];
    
    RJFormButtonItem *signOutItem = [RJFormButtonItem itemWithText:@"退出登录" selector:@"signOutBtnClick:"];
    row = [RJFormRowDescriptor rowWithItem:signOutItem];
    [section addFormRow:row];
}

@end
