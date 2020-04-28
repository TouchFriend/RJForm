//
//  RJFormSettingViewController.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/24.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormSettingViewController.h"
#import "RJForm.h"
#import <Masonry/Masonry.h>

static NSString * const RJUserIconTag = @"RJUserIconTag";
static NSString * const RJPhoneNumberTag = @"RJPhoneNumberTag";
static NSString * const RJChangePwdTag = @"RJChangePwdTag";
static NSString * const RJNotificationTag = @"RJNotificationTag";
static NSString * const RJVersionUpdateTag = @"RJVersionUpdateTag";

@interface RJFormSettingViewController ()


@end

@implementation RJFormSettingViewController

#pragma mark - Init Methods

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self) {
        return nil;
    }
    return self;
}

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
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 10.0;
    [form addFormSection:section];
    
    RJFormImageItem *userIconItem = [RJFormImageItem itemWithText:@"头像" iconImage:[UIImage imageNamed:@"zhanweijian"] style:RJFormImageCellStyleRight];
    userIconItem.hiddenArrow = NO;
    row = [RJFormRowDescriptor rowWithTag:RJUserIconTag item:userIconItem];
    row.rowHeight = 90.0;
    row.didSelectedSelector = @"iconClick:";
    [section addFormRow:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 10.0;
    [form addFormSection:section];
    
    RJFormInfoItem *phoneNumberItem = [RJFormInfoItem itemWithText:@"手机号" detailText:@"182******25"];
    phoneNumberItem.hiddenArrow = NO;
    phoneNumberItem.detailTextColor = [UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1.0];
    row = [RJFormRowDescriptor rowWithTag:RJPhoneNumberTag item:phoneNumberItem];
    row.didSelectedSelector = @"phoneClick:";
    [section addFormRow:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 10.0;
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


#pragma mark - Override Methods

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Target Methods

- (void)signOutBtnClick:(UIButton *)btn
{
    NSLog(@"点击了退出登录按钮");
}

- (void)notificationSwitchChange:(UISwitch *)openSwitch
{
    NSLog(@"通知状态：%@", openSwitch.on ? @"打开" : @"关闭");
}

- (void)iconClick:(RJFormRowDescriptor *)rowDescriptor
{
    NSLog(@"点击了头像");
}

- (void)phoneClick:(RJFormRowDescriptor *)rowDescriptor
{
    NSLog(@"点击了手机号");
}

- (void)changePwdClick:(RJFormRowDescriptor *)rowDescriptor
{
    NSLog(@"点击了修改密码");
}

- (void)versionUpdateClick:(RJFormRowDescriptor *)rowDescriptor
{
    NSLog(@"点击了版本更新");
}

#pragma mark - Properties Methods

@end
