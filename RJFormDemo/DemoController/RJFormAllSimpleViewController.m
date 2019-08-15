//
//  RJFormAllSimpleViewController.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/24.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormAllSimpleViewController.h"
#import "RJForm.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface RJFormAllSimpleViewController () <UITableViewDataSource, UITableViewDelegate>

/********* tableView *********/
@property (nonatomic, weak) UITableView *tableView;

/********* 数据 *********/
@property (nonatomic, strong) RJFormDescriptor *form;


@end

@implementation RJFormAllSimpleViewController

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
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 64.0, 0);
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
    
//    section = [[RJFormSectionDescriptor alloc] init];
//    section.sectionHeaderHeight = 50.0;
//    section.sectionHeaderTitle = @"图片示例";
//    [formSections addObject:section];
//    RJFormSelectorItem *areaType1Item = [RJFormSelectorItem itemWithSelectorStyle:RJFormSelectorStylePicker text:@"区域分类（alert警告框）" selectedOption:[RJFormOptionItem itemWithOptionText:@"区域分类1" optionValue:@(0)]];
//    areaType1Item.selectorTitle = @"区域分类";
//    areaType1Item.selectorOptions = @[
//                                     [RJFormOptionItem itemWithOptionText:@"区域分类1" optionValue:@(0)],
//                                     [RJFormOptionItem itemWithOptionText:@"区域分类2" optionValue:@(1)],
//                                     [RJFormOptionItem itemWithOptionText:@"区域分类3" optionValue:@(2)],
//                                     [RJFormOptionItem itemWithOptionText:@"区域分类4" optionValue:@(3)],
//                                     ];
//    row = [RJFormRowDescriptor rowWithTag:@"areaType" item:areaType1Item];
//    [section.formRows addObject:row];
    
//    section = [[RJFormSectionDescriptor alloc] init];
//    section.sectionHeaderHeight = 44.0;
//    section.sectionHeaderTitle = @"图片选择器";
//    [formSections addObject:section];
//    
//    RJFormImagePickerItem *publicizeImage1Item = [RJFormImagePickerItem itemWithText:@"企业宣传图1" imageArr:nil];
//    row = [RJFormRowDescriptor rowWithTag:@"publicizeImage1" item:publicizeImage1Item];
//    row.rowHeight = publicizeImage1Item.rowHeight;
//    [section.formRows addObject:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 50.0;
    section.sectionHeaderTitle = @"图片示例";
    [formSections addObject:section];
    
    RJFormImageItem *rightIconItem = [RJFormImageItem itemWithText:@"头像" iconImage:[UIImage imageNamed:@"zhanweijian"] style:RJFormImageCellStyleRight];
    rightIconItem.hiddenArror = NO;
    rightIconItem.iconSize = CGSizeMake(60.0, 60.0);
    rightIconItem.iconCornerRadius = 30.0;
    rightIconItem.iconBorderWidth = 1.0;
    rightIconItem.iconBorderColor = [UIColor redColor];
    row = [RJFormRowDescriptor rowWithTag:@"rightIconItem" item:rightIconItem];
    row.rowHeight = 90.0;
    [section.formRows addObject:row];
    
    NSString *iconUrl = @"https://leancloud-gold-cdn.xitu.io/2OeknvJNSvZDnNlzX1iEMyA?imageView2/1/w/100/h/100/q/85/interlace/1";
    RJFormImageItem *right1IconItem = [RJFormImageItem itemWithText:@"头像" webImageUrl:iconUrl style:RJFormImageCellStyleRight];
    right1IconItem.hiddenArror = NO;
    right1IconItem.iconSize = CGSizeMake(60.0, 60.0);
    right1IconItem.iconCornerRadius = 30.0;
    right1IconItem.iconBorderWidth = 1.0;
    right1IconItem.iconBorderColor = [UIColor redColor];
    right1IconItem.placeholderImage = [UIImage imageNamed:@"placeholder"];
    right1IconItem.required = YES;
    row = [RJFormRowDescriptor rowWithTag:@"right1IconItem" item:right1IconItem];
    row.rowHeight = 90.0;
    [section.formRows addObject:row];
    
    RJFormImageItem *middleIconItem = [RJFormImageItem itemWithText:@"头像" iconImage:[UIImage imageNamed:@"zhanweijian"] style:RJFormImageCellStyleMiddle];
    middleIconItem.hiddenArror = NO;
    row = [RJFormRowDescriptor rowWithItem:middleIconItem];
    row.rowHeight = 90.0;
    [section.formRows addObject:row];
    
    RJFormImageItem *leftIconItem = [RJFormImageItem itemWithText:@"头像" iconImage:[UIImage imageNamed:@"zhanweijian"] style:RJFormImageCellStyleLeft];
    leftIconItem.hiddenArror = NO;
    leftIconItem.iconSize = CGSizeMake(22.5, 22.5);
    row = [RJFormRowDescriptor rowWithItem:leftIconItem];
    row.rowHeight = 90.0;
    [section.formRows addObject:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 10.0;
    [formSections addObject:section];
    
    RJFormInfoItem *infoItem = [RJFormInfoItem itemWithText:@"手机号" detailText:@"182******25"];
    infoItem.hiddenArror = NO;
    row = [RJFormRowDescriptor rowWithItem:infoItem];
    [section.formRows addObject:row];
    
    RJFormInfoItem *info1Item = [RJFormInfoItem itemWithText:@"手机号" detailText:@"182******25"];
    info1Item.hiddenArror = NO;
    info1Item.required = YES;
    row = [RJFormRowDescriptor rowWithItem:info1Item];
    row.didSelectedSelector = @"phoneClick:";
    [section.formRows addObject:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 10.0;
    [formSections addObject:section];
    
    RJFormInfoItem *changePwdItem = [RJFormInfoItem itemWithText:@"修改密码" detailText:@""];
    changePwdItem.hiddenArror = NO;
    row = [RJFormRowDescriptor rowWithItem:changePwdItem];
    [section.formRows addObject:row];
    RJFormSwitchItem *notificationItem = [RJFormSwitchItem itemWithText:@"消息通知设置" open:YES];
    row = [RJFormRowDescriptor rowWithTag:@"notification" item:notificationItem];
    [section.formRows addObject:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 10.0;
    [formSections addObject:section];
    
    RJFormInfoItem *versionUpdateItem = [RJFormInfoItem itemWithText:@"版本更新" detailText:@"最新版本v1.0"];
    versionUpdateItem.hiddenArror = YES;
    row = [RJFormRowDescriptor rowWithItem:versionUpdateItem];
    [section.formRows addObject:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 44.0;
    section.sectionHeaderTitle = @"按钮类型";
    [formSections addObject:section];
    
    RJFormTextButtonItem *changeAccountItem = [RJFormTextButtonItem itemWithText:@"切换账号"];
    row = [RJFormRowDescriptor rowWithItem:changeAccountItem];
    [section.formRows addObject:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 15.0;
    [formSections addObject:section];
    
    RJFormButtonItem *signOutItem = [RJFormButtonItem itemWithText:@"退出登录" selector:@"signOutBtnClick:"];
    row = [RJFormRowDescriptor rowWithItem:signOutItem];
    [section.formRows addObject:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 44.0;
    section.sectionHeaderTitle = @"输入框类型";
    [formSections addObject:section];
    
    RJFormTextFieldItem *rightAlignmentTextFieldItem = [RJFormTextFieldItem itemWithText:@"企业名称" detailText:@""];
    row = [RJFormRowDescriptor rowWithTag:@"enterpriseName" item:rightAlignmentTextFieldItem];
    [section.formRows addObject:row];
    
    RJFormTextFieldItem *rightAlignment1TextFieldItem = [RJFormTextFieldItem itemWithText:@"企业名称" detailText:@""];
    rightAlignment1TextFieldItem.required = YES;
    row = [RJFormRowDescriptor rowWithTag:@"enterpriseName1" item:rightAlignment1TextFieldItem];
    [section.formRows addObject:row];
    
    RJFormTextFieldItem *leftAlignmentTextFieldItem = [RJFormTextFieldItem itemWithText:@"企业邮箱" detailText:@""];
    leftAlignmentTextFieldItem.detailTextAlignment = NSTextAlignmentLeft;
    leftAlignmentTextFieldItem.detailKeyboardType = UIKeyboardTypeEmailAddress;
    leftAlignmentTextFieldItem.required = YES;
    [leftAlignmentTextFieldItem addValidator:[RJFormValidator emailValidatorLong]];
    row = [RJFormRowDescriptor rowWithTag:@"enterpriseEmail" item:leftAlignmentTextFieldItem];
    [section.formRows addObject:row];
    
    RJFormTextFieldItem *phoneTextFieldItem = [RJFormTextFieldItem itemWithText:@"电话" detailText:@"" detailPlaceholder:@"请输入电话号码"];
    phoneTextFieldItem.detailTextAlignment = NSTextAlignmentRight;
    phoneTextFieldItem.detailKeyboardType = UIKeyboardTypePhonePad;
    phoneTextFieldItem.detailMaxNumberOfCharacters = @(11);
    row = [RJFormRowDescriptor rowWithTag:@"enterprisePhone" item:phoneTextFieldItem];
    [section.formRows addObject:row];
    
    RJFormTextFieldItem *bankAccountItem = [RJFormTextFieldItem itemWithText:@"" detailText:@""];
    bankAccountItem.detailTextAlignment = NSTextAlignmentLeft;
    bankAccountItem.detailKeyboardType = UIKeyboardTypeDefault;
    row = [RJFormRowDescriptor rowWithTag:@"bankAccount" item:bankAccountItem];
    [section.formRows addObject:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 50.0;
    section.sectionHeaderTitle = @"选择器";
    [formSections addObject:section];
    
    RJFormSelectorItem *enterpriseTypeItem = [RJFormSelectorItem itemWithText:@"企业类型（选择器）" selectedOption:nil];
    enterpriseTypeItem.required = YES;
    enterpriseTypeItem.selectorTitle = @"企业类型";
    enterpriseTypeItem.selectorOptions = @[
                                           [RJFormOptionItem itemWithOptionText:@"企业类型1" optionValue:@(0)],
                                           [RJFormOptionItem itemWithOptionText:@"企业类型2" optionValue:@(1)],
                                           [RJFormOptionItem itemWithOptionText:@"企业类型3" optionValue:@(2)],
                                           [RJFormOptionItem itemWithOptionText:@"企业类型4" optionValue:@(3)],
                                           ];
    row = [RJFormRowDescriptor rowWithTag:@"enterpriseType" item:enterpriseTypeItem];
    [section.formRows addObject:row];
    
    RJFormSelectorItem *countryTypeItem = [RJFormSelectorItem itemWithText:@"国别（选择器 无数据）" selectedOption:nil];
    countryTypeItem.selectorTitle = @"国别";
    row = [RJFormRowDescriptor rowWithTag:@"countryType" item:countryTypeItem];
    [section.formRows addObject:row];
    
    RJFormSelectorItem *enterpriseNatureItem = [RJFormSelectorItem itemWithSelectorStyle:RJFormSelectorStyleActionSheet text:@"企业性质（actionSheet警告框）" selectedOption:[RJFormOptionItem itemWithOptionText:@"企业性质1" optionValue:@(0)]];
    enterpriseNatureItem.selectorTitle = @"企业性质";
    enterpriseNatureItem.selectorOptions = @[
                                           [RJFormOptionItem itemWithOptionText:@"企业性质1" optionValue:@(0)],
                                           [RJFormOptionItem itemWithOptionText:@"企业性质2" optionValue:@(1)],
                                           [RJFormOptionItem itemWithOptionText:@"企业性质3" optionValue:@(2)],
                                           [RJFormOptionItem itemWithOptionText:@"企业性质4" optionValue:@(3)],
                                           ];
    row = [RJFormRowDescriptor rowWithTag:@"enterpriseNature" item:enterpriseNatureItem];
    [section.formRows addObject:row];

    RJFormSelectorItem *areaTypeItem = [RJFormSelectorItem itemWithSelectorStyle:RJFormSelectorStyleAlert text:@"区域分类（alert警告框）" selectedOption:[RJFormOptionItem itemWithOptionText:@"区域分类1" optionValue:@(0)]];
    areaTypeItem.selectorTitle = @"区域分类";
    areaTypeItem.selectorOptions = @[
                                             [RJFormOptionItem itemWithOptionText:@"区域分类1" optionValue:@(0)],
                                             [RJFormOptionItem itemWithOptionText:@"区域分类2" optionValue:@(1)],
                                             [RJFormOptionItem itemWithOptionText:@"区域分类3" optionValue:@(2)],
                                             [RJFormOptionItem itemWithOptionText:@"区域分类4" optionValue:@(3)],
                                             ];
    row = [RJFormRowDescriptor rowWithTag:@"areaType" item:areaTypeItem];
    [section.formRows addObject:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 44.0;
    section.sectionHeaderTitle = @"日期选择器";
    [formSections addObject:section];
    
    RJFormDatePickerItem *createTimeItem = [RJFormDatePickerItem itemWithText:@"创建时间(无数据)" detailText:@""];
    createTimeItem.required = YES;
    createTimeItem.maximumDate = [NSDate date];
    row = [RJFormRowDescriptor rowWithTag:@"createTime" item:createTimeItem];
    [section.formRows addObject:row];
    
    RJFormDatePickerItem *birthdayItem = [RJFormDatePickerItem itemWithText:@"出生年月" detailText:@"2012-12-12"];
    birthdayItem.maximumDate = [NSDate date];
    row = [RJFormRowDescriptor rowWithTag:@"birthday" item:birthdayItem];
    [section.formRows addObject:row];
    
    RJFormDatePickerItem *marryDayItem = [RJFormDatePickerItem itemWithText:@"电影开场日期(自定义转换格式)" detailText:@"2012.12.12"];
    marryDayItem.dateFormat = @"yyyy.MM.dd";
    row = [RJFormRowDescriptor rowWithTag:@"marryDay" item:marryDayItem];
    [section.formRows addObject:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 44.0;
    section.sectionHeaderTitle = @"TextView";
    [formSections addObject:section];
    
    RJFormTextViewItem *investmentDescriptionItem = [RJFormTextViewItem itemWithText:@"固定资产投资计划说明" detailText:@""];
    row = [RJFormRowDescriptor rowWithTag:@"investmentDescription" item:investmentDescriptionItem];
    row.rowHeight = 150.0;
    [section.formRows addObject:row];
    
    RJFormTextViewItem *limitCharNumItem = [RJFormTextViewItem itemWithText:@"限制字数10" detailText:@""];
    limitCharNumItem.required = YES;
    limitCharNumItem.detailMaxNumberOfCharacters = @(10);
    limitCharNumItem.detailText = @"限制字数测试";
    row = [RJFormRowDescriptor rowWithTag:@"limitCharNum" item:limitCharNumItem];
    row.rowHeight = 150.0;
    [section.formRows addObject:row];
    
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 44.0;
    section.sectionHeaderTitle = @"图片选择器";
    [formSections addObject:section];
    
    RJFormImagePickerItem *publicizeImageItem = [RJFormImagePickerItem itemWithText:@"企业宣传图" imageArr:nil];
    row = [RJFormRowDescriptor rowWithTag:@"publicizeImage" item:publicizeImageItem];
    row.rowHeight = publicizeImageItem.rowHeight;
    [section.formRows addObject:row];
    

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
    RJFormSectionDescriptor *sectionDescriptor = self.form.formSections[indexPath.section];
    RJFormRowDescriptor *rowDescriptor = sectionDescriptor.formRows[indexPath.row];
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

#pragma mark - Override Methods

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Target Methods

- (void)saveBtnClick
{
    [self.view endEditing:YES];
    
    //表单验证
    NSArray<NSError *> * errors = [self.form formValidationErrors];
    if (errors && errors.count > 0)
    {
        NSError *error = errors.firstObject;
        NSString *errorMsg = error.localizedDescription;
//        NSLog(@"表单验证错误：%@", errorMsg);
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showErrorWithStatus:errorMsg];
        [SVProgressHUD dismissWithDelay:1.2];
        
        RJFormValidationStatus *status = error.userInfo[RJFormValidationErrorKey];
        RJFormRowDescriptor *row = status.rowDescriptor;
        NSIndexPath *indexPath = [self.form indexPathOfFormRow:row];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        return;
    }
    
    NSDictionary *valueDic = [self.form formValue];
    NSLog(@"表单的值：%@", valueDic);
}

- (void)signOutBtnClick:(UIButton *)btn
{
    NSLog(@"点击了退出登录按钮");
}

#pragma mark - Properties Methods

@end
