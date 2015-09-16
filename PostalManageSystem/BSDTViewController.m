//
//  BSDTViewController.m
//  PostalManageSystem
//
//  Created by ZengYifei on 15/8/21.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//
#import "PostalManageSystem-Swift.h"

#import "BSDTViewController.h"
#import "BSDTDetailViewController.h"
#import "UploadPicViewController.h"
#import "SearchForMyApply.h"
#define BTNWIDTH (UISCREENWIDTH/2-2)
#define BTNHEIGHT ((UISCREENHEIGHT - NAVIGATIONHEIGHT)/4-2)
#define IMGSIZERATIO 0.7
#define TABLEVIEWCELLWIDTH 70
@interface BSDTViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    AppDelegate *app;
    UITextField * accountTextField;
    UITextField * passwordTextField;
    BOOL showLoginSetting;
}
@property (strong,nonatomic) UILabel * titleLabel;
@property (strong,nonatomic) UIView * loginView;
@property (strong,nonatomic) UIView * bsdtView;
@property (strong,nonatomic) UITableView * table;
@property (strong,nonatomic) NSMutableArray * dataList;
@property (strong,nonatomic) SearchForMyApply * search;
@end

@implementation BSDTViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.table =[[UITableView alloc]init];
        self.table.scrollEnabled = NO;
        self.dataList = [[NSMutableArray alloc]initWithObjects:@"注销",@"关于", nil];
        self.table.dataSource = self;
        self.table.delegate = self;
        self.table.frame = CGRectMake(UISCREENWIDTH - TABLEVIEWCELLWIDTH, 0, TABLEVIEWCELLWIDTH, 0);
        [self.view addSubview:self.table];

    }
    return self;
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    //获取单例
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //设置导航栏label
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.textColor = [UIColor yellowColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = app.titleForCurrentPage;
    self.navigationItem.titleView = self.titleLabel;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(doLogin:) name:@"doLogin" object:nil];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"settings"]forState:UIControlStateNormal];
    [button addTarget:self action:@selector(setting)forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = menuButton;
    
    self.bsdtView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.bsdtView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.bsdtView];
    
    UIButton * yhxxxgBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImageView * yhxxxgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yonghuxinxixiugai"]];
    yhxxxgImageView.frame = CGRectMake(0, 0, BTNWIDTH*IMGSIZERATIO, BTNWIDTH*IMGSIZERATIO*1.64);
    yhxxxgImageView.center = CGPointMake(BTNWIDTH/2, BTNHEIGHT/2);
    [yhxxxgBtn addSubview:yhxxxgImageView];
    yhxxxgBtn.backgroundColor = [UIColor whiteColor];
    yhxxxgBtn.frame = CGRectMake(1, NAVIGATIONHEIGHT+1,BTNWIDTH,BTNHEIGHT );
    [yhxxxgBtn addTarget:self action:@selector(jumpPageForBSDT:) forControlEvents:UIControlEventTouchUpInside];
    yhxxxgBtn.tag = 1;
    [self.view addSubview:yhxxxgBtn];
    
    UIButton * sqxzwdBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImageView * sqxzwdImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shenqingxinzengwangdian"]];
    sqxzwdImageView.frame = CGRectMake(0, 0, BTNWIDTH*IMGSIZERATIO, BTNWIDTH*IMGSIZERATIO*1.64);
    sqxzwdImageView.center = CGPointMake(BTNWIDTH/2, BTNHEIGHT/2);
    [sqxzwdBtn addSubview:sqxzwdImageView];
    sqxzwdBtn.backgroundColor = [UIColor whiteColor];
    sqxzwdBtn.frame = CGRectMake(UISCREENWIDTH/2+ 1, NAVIGATIONHEIGHT+1,BTNWIDTH,BTNHEIGHT );
    [sqxzwdBtn addTarget:self action:@selector(jumpPageForBSDT:) forControlEvents:UIControlEventTouchUpInside];
    sqxzwdBtn.tag = 2;
    [self.view addSubview:sqxzwdBtn];
    
    UIButton * sqcxwdBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImageView * sqcxwdImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shenqingchexiaowangdian"]];
    sqcxwdImageView.frame = CGRectMake(0, 0, BTNWIDTH*IMGSIZERATIO, BTNWIDTH*IMGSIZERATIO*1.64);
    sqcxwdImageView.center = CGPointMake(BTNWIDTH/2, BTNHEIGHT/2);
    [sqcxwdBtn addSubview:sqcxwdImageView];
    sqcxwdBtn.backgroundColor = [UIColor whiteColor];
    sqcxwdBtn.frame = CGRectMake(1, NAVIGATIONHEIGHT+1+BTNHEIGHT+2,BTNWIDTH,BTNHEIGHT );
    [sqcxwdBtn addTarget:self action:@selector(jumpPageForBSDT:) forControlEvents:UIControlEventTouchUpInside];
    sqcxwdBtn.tag = 3;
    [self.view addSubview:sqcxwdBtn];
    
    UIButton * sqbgwddBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImageView * sqbdwdImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shenqingbiangengwangdian"]];
    sqbdwdImageView.frame = CGRectMake(0, 0, BTNWIDTH*IMGSIZERATIO, BTNWIDTH*IMGSIZERATIO*1.64);
    sqbdwdImageView.center = CGPointMake(BTNWIDTH/2, BTNHEIGHT/2);
    [sqbgwddBtn addSubview:sqbdwdImageView];
    sqbgwddBtn.backgroundColor = [UIColor whiteColor];
    sqbgwddBtn.frame = CGRectMake(UISCREENWIDTH/2+ 1, NAVIGATIONHEIGHT+1+BTNHEIGHT+2,BTNWIDTH,BTNHEIGHT );
    [sqbgwddBtn addTarget:self action:@selector(jumpPageForBSDT:) forControlEvents:UIControlEventTouchUpInside];
    sqbgwddBtn.tag = 4;
    [self.view addSubview:sqbgwddBtn];
    
    UIButton * sqztzxblywBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImageView * sqztzxblywImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shenqingzantingxianyewu"]];
    sqztzxblywImageView.frame = CGRectMake(0, 0, BTNWIDTH*IMGSIZERATIO, BTNWIDTH*IMGSIZERATIO*1.64);
    sqztzxblywImageView.center = CGPointMake(BTNWIDTH/2, BTNHEIGHT/2);
    [sqztzxblywBtn addSubview:sqztzxblywImageView];
    sqztzxblywBtn.backgroundColor = [UIColor whiteColor];
    sqztzxblywBtn.frame = CGRectMake(1, NAVIGATIONHEIGHT+1+(BTNHEIGHT+2)*2,BTNWIDTH,BTNHEIGHT );
    [sqztzxblywBtn addTarget:self action:@selector(jumpPageForBSDT:) forControlEvents:UIControlEventTouchUpInside];
    sqztzxblywBtn.tag = 5;
    [self.view addSubview:sqztzxblywBtn];
    
    UIButton * sqtxywBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImageView * sqtxywImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shenqingtingxianyewu"]];
    sqtxywImageView.frame = CGRectMake(0, 0, BTNWIDTH*IMGSIZERATIO, BTNWIDTH*IMGSIZERATIO*1.64);
    sqtxywImageView.center = CGPointMake(BTNWIDTH/2, BTNHEIGHT/2);
    [sqtxywBtn addSubview:sqtxywImageView];
    sqtxywBtn.backgroundColor = [UIColor whiteColor];
    sqtxywBtn.frame = CGRectMake(UISCREENWIDTH/2+ 1, NAVIGATIONHEIGHT+1+(BTNHEIGHT+2)*2,BTNWIDTH,BTNHEIGHT );
    [sqtxywBtn addTarget:self action:@selector(jumpPageForBSDT:) forControlEvents:UIControlEventTouchUpInside];
    sqtxywBtn.tag = 6;
    [self.view addSubview:sqtxywBtn];
    
    UIButton * sqhfywBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImageView * sqhfywImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shenqinghuifuyewu"]];
    sqhfywImageView.frame = CGRectMake(0, 0, BTNWIDTH*IMGSIZERATIO, BTNWIDTH*IMGSIZERATIO*1.64);
    sqhfywImageView.center = CGPointMake(BTNWIDTH/2, BTNHEIGHT/2);
    [sqhfywBtn addSubview:sqhfywImageView];
    sqhfywBtn.backgroundColor = [UIColor whiteColor];
    sqhfywBtn.frame = CGRectMake(1, NAVIGATIONHEIGHT+1+(BTNHEIGHT+2)*3,BTNWIDTH,BTNHEIGHT );
    [sqhfywBtn addTarget:self action:@selector(jumpPageForBSDT:) forControlEvents:UIControlEventTouchUpInside];
    sqhfywBtn.tag = 7;
    [self.view addSubview:sqhfywBtn];
    
    UIButton * qysqcxBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImageView * qysqcxImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wodeshenqingchaxun"]];
    qysqcxImageView.frame = CGRectMake(0, 0, BTNWIDTH*IMGSIZERATIO, BTNWIDTH*IMGSIZERATIO*1.64);
    qysqcxImageView.center = CGPointMake(BTNWIDTH/2, BTNHEIGHT/2);
    [qysqcxBtn addSubview:qysqcxImageView];
    qysqcxBtn.backgroundColor = [UIColor whiteColor];
    qysqcxBtn.frame = CGRectMake(UISCREENWIDTH/2+ 1, NAVIGATIONHEIGHT+1+(BTNHEIGHT+2)*3,BTNWIDTH,BTNHEIGHT );
    [qysqcxBtn addTarget:self action:@selector(jumpPageForBSDT:) forControlEvents:UIControlEventTouchUpInside];
    qysqcxBtn.tag = 8;
    [self.view addSubview:qysqcxBtn];
    
    
    if (!app.login) {
        self.loginView = [[UIView alloc]initWithFrame:self.view.bounds];
        self.loginView.backgroundColor = [UIColor whiteColor];
        self.titleLabel.text = @"用户登录";
        
        accountTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, NAVIGATIONHEIGHT, UISCREENWIDTH, 50)];
        accountTextField.delegate = self;
        [accountTextField setBorderStyle:UITextBorderStyleLine];
        accountTextField.placeholder = @"账号";
        accountTextField.returnKeyType = UIReturnKeyDone;
        UIImageView *accountImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zhanghao"]];
        accountImageView.frame = CGRectMake(0, 0, accountTextField.frame.size.height*2/3, accountTextField.frame.size.height*2/3);
        accountTextField.leftView = accountImageView;
        accountTextField.leftViewMode = UITextFieldViewModeAlways;
        accountTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [self.loginView addSubview:accountTextField];
        
        passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(0,NAVIGATIONHEIGHT+ 50, UISCREENWIDTH, 50)];
        passwordTextField.delegate = self;
        [passwordTextField setBorderStyle:UITextBorderStyleLine];
        passwordTextField.placeholder = @"密码";
        passwordTextField.returnKeyType = UIReturnKeyDone;
        UIImageView *passwordImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mima"]];
        passwordImageView.frame = CGRectMake(0, 0, passwordTextField.frame.size.height*2/3, passwordTextField.frame.size.height*2/3);
        passwordTextField.leftView = passwordImageView;
        passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        passwordTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [self.loginView addSubview:passwordTextField];
        
        UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        loginBtn.frame = CGRectMake(0, 0, UISCREENWIDTH*2/3, 40);
        loginBtn.center = CGPointMake(UISCREENWIDTH/2, NAVIGATIONHEIGHT+150);
        loginBtn.backgroundColor = UIColorFromRGBValue(0x028e45);
        //绘制圆角矩形按钮和边线
        [loginBtn.layer setMasksToBounds:YES];
        [loginBtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
        [loginBtn.layer setBorderWidth:1.0];   //边框宽度
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 2/255.0, 142/255.0, 69/255.0, 1 });
        [loginBtn.layer setBorderColor:colorref];//边框颜色
        [loginBtn setTitle:@"登陆" forState:UIControlStateNormal] ;
        [loginBtn setTitleColor:[UIColor yellowColor]forState:UIControlStateNormal];
        loginBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        loginBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [self.loginView addSubview:loginBtn];
        
        UIButton * forgetBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        forgetBtn.frame = CGRectMake(UISCREENWIDTH*4/5, NAVIGATIONHEIGHT+180, UISCREENWIDTH*1/5, 40);
        forgetBtn.backgroundColor = [UIColor clearColor];
        [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [forgetBtn setTintColor:[UIColor redColor]];
        [forgetBtn addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
        [self.loginView addSubview:forgetBtn];
        [self.view addSubview:self.loginView];
        [self.view bringSubviewToFront:self.loginView];
        accountTextField.text = @"1";
        passwordTextField.text = @"111111";
    }
}

- (void)jumpPageForBSDT:(UIButton*)btn{
//    BSDTDetailViewController * bsdt = [BSDTDetailViewController alloc];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ChangeUserInfoViewController * changeUserInfoVC = [storyboard instantiateViewControllerWithIdentifier:@"changeUserInfoVC"];
    ApplyAddBranchViewController * applyAddBranchVC = [storyboard instantiateViewControllerWithIdentifier:@"applyAddBranchVC"];
    ApplyResignBranchViewController2 * applyResignBranchVC = [storyboard instantiateViewControllerWithIdentifier:@"applyResignBranchVC"];
    ApplyChangeBranchViewController * applyChangeBranchVC = [storyboard instantiateViewControllerWithIdentifier:@"applyChangeBranchVC"];
    ApplyPausedViewController * applyPausedBranchVC = [storyboard instantiateViewControllerWithIdentifier:@"applyPausedBranchVC"];
    ApplyStopBranchViewController * applyStopBranchVC = [storyboard instantiateViewControllerWithIdentifier:@"applyStopBranchVC"];
    ApplyRestoreBranchViewController * applyRestoreBranchVC = [storyboard instantiateViewControllerWithIdentifier:@"applyRestoreBranchVC"];

    
    UploadPicViewController * uploadPic = [[UploadPicViewController alloc]init];
    //提前初始化查询  以接受服务器返回数据
    _search = [[SearchForMyApply alloc]init];
    switch (btn.tag) {
        case 1:
            app.titleForCurrentPage = @"用户信息修改";
//            bsdt = [bsdt init];
            [self.navigationController pushViewController:changeUserInfoVC animated:YES];
            break;
        case 2:
            app.titleForCurrentPage = @"申请新增网点";
//            bsdt = [bsdt init];
           [self.navigationController pushViewController:applyAddBranchVC animated:YES];
            break;
        case 3:
        {
            app.titleForCurrentPage = @"申请撤销网点";
            [self.navigationController pushViewController:applyResignBranchVC animated:YES];
        }
            break;
            
        case 4:
        {
            app.titleForCurrentPage = @"申请变更网点";
            [self.navigationController pushViewController:applyChangeBranchVC animated:YES];
        }
            break;
            
        case 5:
        {
            app.titleForCurrentPage = @"申请暂停/暂限办理业务";
            [self.navigationController pushViewController:applyPausedBranchVC animated:YES];
        }
            break;
            
        case 6:
        {
            app.titleForCurrentPage = @"申请停止/限制办理业务";
            [self.navigationController pushViewController:applyStopBranchVC animated:YES];
        }
            break;
        case 7:
        {
            app.titleForCurrentPage = @"申请恢复办理业务";
            [self.navigationController pushViewController:applyRestoreBranchVC animated:YES];
        }
            break;
            
        case 8:
            [app.network getUserList];
            [GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];
            app.titleForCurrentPage = @"我的申请查询";
            [self.navigationController pushViewController:[_search init] animated:YES];
            break;
        default:
            break;
    }
}

#pragma mark - 功能实现

- (void)login{
    if (accountTextField.text.length > 0 && passwordTextField.text.length > 0) {
        [GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];
        [app.network loginWithToken:@"jiou" AndUserName:accountTextField.text AndUserPassword:passwordTextField.text];
    }else{
        UIAlertView * alerts = [[UIAlertView alloc]initWithTitle:nil message:@"账户密码均不能为空！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alerts show];
    }
    
    if (passwordTextField.isFirstResponder) {
        [passwordTextField resignFirstResponder];
    }else if (accountTextField.isFirstResponder){
        [accountTextField resignFirstResponder];
    }
}

- (void)doLogin:(NSNotification *)note{
    [GMDCircleLoader hideFromView:self.view animated:YES];
    NSString * loginResult = [[note userInfo] objectForKey:@"result"];
    if ([loginResult isEqualToString:@"0"]) {
        UIAlertView * alerts = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"请检查账号、密码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alerts show];
    }else if ([loginResult isEqualToString:@"1"]){
        [self.view sendSubviewToBack:self.loginView];
        app.userData = [[note userInfo] objectForKey:@"data"];
        self.titleLabel.text = @"办事大厅";
        app.login = YES;
    }
}

- (void)setting{
    if (showLoginSetting ==YES) {
        showLoginSetting = NO;
        [self cancelView];
    }else{
        showLoginSetting = YES;
        [self showTableView];
    }
}

- (void)forget{
    UIAlertView * alerts = [[UIAlertView alloc]initWithTitle:@"忘记密码提示" message:@"请与贵阳市邮政管理局联系，电话:0851-84584352" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alerts.delegate = self;
    [alerts show];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //这样写在IOS7.0以后 TableViewCell的分割线就不会往右挫15个像素点了
    [tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self.dataList objectAtIndex:indexPath.row];
    cell.backgroundColor = UIColorFromRGBValue(0x028e45);
    cell.textLabel.textColor = [UIColor yellowColor];
    cell.alpha = 0.8;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    switch (indexPath.row) {
        case 0:{
            NSLog(@"注销");
            if (app.login == YES) {
                UIAlertView * alerts = [[UIAlertView alloc]initWithTitle:@"注销" message:@"是否确定注销" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alerts.delegate = self;
                [alerts show];
            }else{
                UIAlertView * alerts = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有登陆，请先登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                alerts.delegate = self;
                [alerts show];
            }
            
            break;
        }
        case 1:{
            NSLog(@"关于");
            UIAlertView * alerts = [[UIAlertView alloc]initWithTitle:@"关于" message:@"2015-2016 贵阳市邮政管理局保留所有权利" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alerts show];
            break;
        }
        default:
            break;
    }
}

-(void)cancelView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.table.frame =  CGRectMake(UISCREENWIDTH - TABLEVIEWCELLWIDTH, 0, TABLEVIEWCELLWIDTH, 0);
    }];
    
}

- (void)showTableView{
    [UIView animateWithDuration:0.3 animations:^{
        self.table.frame = CGRectMake(UISCREENWIDTH - TABLEVIEWCELLWIDTH, NAVIGATIONHEIGHT, TABLEVIEWCELLWIDTH, 44*self.dataList.count);
                }];
}

#pragma mark - AlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSLog(@"logout");
        app.login = NO;
        [self cancelView];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    if (touch.view != self.table ) {
        [self cancelView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
