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

#pragma mark - initialize Form

- (void)initializeForm
{
    RJFormDescriptor *form;
    RJFormSectionDescriptor *section;
    RJFormRowDescriptor *row;
    
    form = [RJFormDescriptor formWithTableView:self.tableView];
    self.form = form;
    
    //第一分组
    section = [[RJFormSectionDescriptor alloc] init];
    section.sectionHeaderHeight = 0.1;
    section.sectionFooterHeight = 10.0;
    [form addFormSections:section];
    
    NSString *iconUrl = @"https://leancloud-gold-cdn.xitu.io/2OeknvJNSvZDnNlzX1iEMyA?imageView2/1/w/100/h/100/q/85/interlace/1";
    RJFormImageItem *businessLicenseItem = [RJFormImageItem itemWithText:@"营业执照" webImageUrl:iconUrl placeholderImage:[UIImage imageNamed:@"placeholder"] style:RJFormImageCellStyleRight];
    businessLicenseItem.iconSize = CGSizeMake(50.0, 50.0);
    row = [RJFormRowDescriptor rowWithTag:@"businessLicense" item:businessLicenseItem];
    row.rowHeight = 80.0;
    [section addFormRow:row];
    
    RJFormTextFieldItem *enterpriseNameItem = [RJFormTextFieldItem itemWithText:@"企业名称" detailText:@"" detailPlaceholder:@"请填写"];
    enterpriseNameItem.required = YES;
    row = [RJFormRowDescriptor rowWithTag:@"enterpriseName" item:enterpriseNameItem];
    [section addFormRow:row];
    
    //第二分组
    
    section = [RJFormSectionDescriptor sectionWithSectionHeaderHeight:0.1 sectionFooterHeight:10.0];
    [form addFormSections:section];
    
    RJFormTextFieldItem *socialCreditCodeItem = [RJFormTextFieldItem itemWithText:@"统一社会信用代码" detailText:@"91310117740271746E" detailPlaceholder:@"请填写"];
    socialCreditCodeItem.required = YES;
    row = [RJFormRowDescriptor rowWithTag:@"socialCreditCode" item:socialCreditCodeItem];
    [section addFormRow:row];
    
    RJFormInfoItem *typeItem = [RJFormInfoItem itemWithText:@"类型" detailText:@"有限责任公司（法人独资）"];
    typeItem.required = YES;
    row = [RJFormRowDescriptor rowWithTag:@"type" item:typeItem];
    [section addFormRow:row];
    
    RJFormInfoItem *enterpriseTypeItem = [RJFormInfoItem itemWithText:@"企业类型" detailText:@"实体型"];
    enterpriseTypeItem.required = YES;
    row = [RJFormRowDescriptor rowWithTag:@"enterpriseType" item:enterpriseTypeItem];
    [section addFormRow:row];
    
    RJFormInfoItem *enterpriseNatureItem = [RJFormInfoItem itemWithText:@"企业性质" detailText:@"私营"];
    enterpriseNatureItem.required = YES;
    row = [RJFormRowDescriptor rowWithTag:@"enterpriseNature" item:enterpriseNatureItem];
    [section addFormRow:row];
    
    RJFormTextFieldItem *createTimeItem = [RJFormTextFieldItem itemWithText:@"成立时间" detailText:@"" detailPlaceholder:@"请填写"];
    row = [RJFormRowDescriptor rowWithTag:@"createTime" item:createTimeItem];
    [section addFormRow:row];
    
    RJFormTextFieldItem *landClassifyItem = [RJFormTextFieldItem itemWithText:@"地块分类" detailText:@"" detailPlaceholder:@"请填写"];
    row = [RJFormRowDescriptor rowWithTag:@"landClassify" item:landClassifyItem];
    [section addFormRow:row];
    
    RJFormInfoItem *regionClassifyItem = [RJFormInfoItem itemWithText:@"区域分类" detailText:@""];
    regionClassifyItem.required = YES;
    row = [RJFormRowDescriptor rowWithTag:@"regionClassify" item:regionClassifyItem];
    [section addFormRow:row];
    
    RJFormInfoItem *manageAuthorityItem = [RJFormInfoItem itemWithText:@"管理权限" detailText:@""];
    manageAuthorityItem.required = YES;
    row = [RJFormRowDescriptor rowWithTag:@"manageAuthority" item:manageAuthorityItem];
    [section addFormRow:row];
    
    RJFormInfoItem *countryItem = [RJFormInfoItem itemWithText:@"国别" detailText:@"中国"];
    countryItem.required = YES;
    row = [RJFormRowDescriptor rowWithTag:@"country" item:countryItem];
    [section addFormRow:row];
    
    RJFormInfoItem *moneyTypeItem = [RJFormInfoItem itemWithText:@"币种" detailText:@""];
    moneyTypeItem.required = YES;
    row = [RJFormRowDescriptor rowWithTag:@"moneyType" item:moneyTypeItem];
    [section addFormRow:row];
    
    RJFormInfoItem *manageStateItem = [RJFormInfoItem itemWithText:@"管理状态" detailText:@""];
    manageStateItem.required = YES;
    row = [RJFormRowDescriptor rowWithTag:@"manageState" item:manageStateItem];
    [section addFormRow:row];
    
    RJFormTextFieldItem *registerMoneyItem = [RJFormTextFieldItem itemWithText:@"注册资本（万）" detailText:@"" detailPlaceholder:@"请填写"];
    registerMoneyItem.required = YES;
    row = [RJFormRowDescriptor rowWithTag:@"registerMoney" item:registerMoneyItem];
    [section addFormRow:row];
    
    RJFormTextFieldItem *contractForeignMoneyItem = [RJFormTextFieldItem itemWithText:@"合同外资（万）" detailText:@"" detailPlaceholder:@"请填写"];
    row = [RJFormRowDescriptor rowWithTag:@"contractForeignMoney" item:contractForeignMoneyItem];
    [section addFormRow:row];
    
    RJFormTextFieldItem *totalInvestmentMoneyItem = [RJFormTextFieldItem itemWithText:@"总投资额（万）" detailText:@"" detailPlaceholder:@"请填写"];
    row = [RJFormRowDescriptor rowWithTag:@"totalInvestmentMoney" item:totalInvestmentMoneyItem];
    [section addFormRow:row];
    
    RJFormTextFieldItem *getMoneyItem = [RJFormTextFieldItem itemWithText:@"到位资金（万）" detailText:@"" detailPlaceholder:@"请填写"];
    row = [RJFormRowDescriptor rowWithTag:@"getMoney" item:getMoneyItem];
    [section addFormRow:row];
    
    RJFormInfoItem *investorClassifyItem = [RJFormInfoItem itemWithText:@"投资方分类" detailText:@""];
    investorClassifyItem.required = YES;
    row = [RJFormRowDescriptor rowWithTag:@"investorClassify" item:investorClassifyItem];
    [section addFormRow:row];
    
    RJFormTextFieldItem *registerAuthorityItem = [RJFormTextFieldItem itemWithText:@"登记机关" detailText:@"" detailPlaceholder:@"请填写"];
    row = [RJFormRowDescriptor rowWithTag:@"registerAuthority" item:registerAuthorityItem];
    [section addFormRow:row];
    
    RJFormInfoItem *industryClassifyItem = [RJFormInfoItem itemWithText:@"所属行业分类" detailText:@""];
    industryClassifyItem.required = YES;
    row = [RJFormRowDescriptor rowWithTag:@"industryClassify" item:industryClassifyItem];
    [section addFormRow:row];
    
    //第三分组
    
    //第四分组
    
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
    [self.view endEditing:YES];
    
    //表单验证
//    NSArray<NSError *> * errors = [self.form formValidationErrors];
//    if (errors && errors.count > 0)
//    {
//        NSError *error = errors.firstObject;
//        NSString *errorMsg = error.localizedDescription;
//        //        NSLog(@"表单验证错误：%@", errorMsg);
//        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//        [SVProgressHUD showErrorWithStatus:errorMsg];
//        [SVProgressHUD dismissWithDelay:1.2];
//
//        RJFormValidationStatus *status = error.userInfo[RJFormValidationErrorKey];
//        RJFormRowDescriptor *row = status.rowDescriptor;
//        NSIndexPath *indexPath = [self.form indexPathOfFormRow:row];
//        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
//        return;
//    }
    
    NSDictionary *valueDic = [self.form formValue];
    NSLog(@"表单的值：%@", valueDic);
}

#pragma mark - Properties Methods

@end
