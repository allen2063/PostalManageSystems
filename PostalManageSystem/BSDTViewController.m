//
//  BSDTViewController.m
//  PostalManageSystem
//
//  Created by ZengYifei on 15/8/21.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "BSDTViewController.h"
#import "BSDTDetailViewController.h"
#define BTNWIDTH (UISCREENWIDTH/2-2)
#define BTNHEIGHT ((UISCREENHEIGHT - NAVIGATIONHIGHT)/4-2)
#define IMGSIZERATIO 0.7
@interface BSDTViewController ()<UITextFieldDelegate>{
    AppDelegate *app;
    UITextField * accountTextField;
    UITextField * passwordTextField;
}
@property (strong,nonatomic) UILabel * titleLabel;
@property (strong,nonatomic) UIView * loginView;
@property (strong,nonatomic) UIView * bsdtView;
@end

@implementation BSDTViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
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
    
    self.bsdtView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.bsdtView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.bsdtView];
    
    UIButton * yhxxxgBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImageView * yhxxxgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yonghuxinxixiugai"]];
    yhxxxgImageView.frame = CGRectMake(0, 0, BTNWIDTH*IMGSIZERATIO, BTNWIDTH*IMGSIZERATIO*1.64);
    yhxxxgImageView.center = CGPointMake(BTNWIDTH/2, BTNHEIGHT/2);
    [yhxxxgBtn addSubview:yhxxxgImageView];
    yhxxxgBtn.backgroundColor = [UIColor whiteColor];
    yhxxxgBtn.frame = CGRectMake(1, NAVIGATIONHIGHT+1,BTNWIDTH,BTNHEIGHT );
    [yhxxxgBtn addTarget:self action:@selector(jumpPageForBSDT:) forControlEvents:UIControlEventTouchUpInside];
    yhxxxgBtn.tag = 1;
    [self.view addSubview:yhxxxgBtn];
    
    UIButton * sqxzwdBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImageView * sqxzwdImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shenqingxinzengwangdian"]];
    sqxzwdImageView.frame = CGRectMake(0, 0, BTNWIDTH*IMGSIZERATIO, BTNWIDTH*IMGSIZERATIO*1.64);
    sqxzwdImageView.center = CGPointMake(BTNWIDTH/2, BTNHEIGHT/2);
    [sqxzwdBtn addSubview:sqxzwdImageView];
    sqxzwdBtn.backgroundColor = [UIColor whiteColor];
    sqxzwdBtn.frame = CGRectMake(UISCREENWIDTH/2+ 1, NAVIGATIONHIGHT+1,BTNWIDTH,BTNHEIGHT );
    [sqxzwdBtn addTarget:self action:@selector(jumpPageForBSDT:) forControlEvents:UIControlEventTouchUpInside];
    sqxzwdBtn.tag = 2;
    [self.view addSubview:sqxzwdBtn];
    
    UIButton * sqcxwdBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImageView * sqcxwdImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shenqingchexiaowangdian"]];
    sqcxwdImageView.frame = CGRectMake(0, 0, BTNWIDTH*IMGSIZERATIO, BTNWIDTH*IMGSIZERATIO*1.64);
    sqcxwdImageView.center = CGPointMake(BTNWIDTH/2, BTNHEIGHT/2);
    [sqcxwdBtn addSubview:sqcxwdImageView];
    sqcxwdBtn.backgroundColor = [UIColor whiteColor];
    sqcxwdBtn.frame = CGRectMake(1, NAVIGATIONHIGHT+1+BTNHEIGHT+2,BTNWIDTH,BTNHEIGHT );
    [sqcxwdBtn addTarget:self action:@selector(jumpPageForBSDT:) forControlEvents:UIControlEventTouchUpInside];
    sqcxwdBtn.tag = 3;
    [self.view addSubview:sqcxwdBtn];
    
    UIButton * sqbgwddBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImageView * sqbdwdImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shenqingbiangengwangdian"]];
    sqbdwdImageView.frame = CGRectMake(0, 0, BTNWIDTH*IMGSIZERATIO, BTNWIDTH*IMGSIZERATIO*1.64);
    sqbdwdImageView.center = CGPointMake(BTNWIDTH/2, BTNHEIGHT/2);
    [sqbgwddBtn addSubview:sqbdwdImageView];
    sqbgwddBtn.backgroundColor = [UIColor whiteColor];
    sqbgwddBtn.frame = CGRectMake(UISCREENWIDTH/2+ 1, NAVIGATIONHIGHT+1+BTNHEIGHT+2,BTNWIDTH,BTNHEIGHT );
    [sqbgwddBtn addTarget:self action:@selector(jumpPageForBSDT:) forControlEvents:UIControlEventTouchUpInside];
    sqbgwddBtn.tag = 4;
    [self.view addSubview:sqbgwddBtn];
    
    UIButton * sqztzxblywBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImageView * sqztzxblywImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shenqingzantingxianyewu"]];
    sqztzxblywImageView.frame = CGRectMake(0, 0, BTNWIDTH*IMGSIZERATIO, BTNWIDTH*IMGSIZERATIO*1.64);
    sqztzxblywImageView.center = CGPointMake(BTNWIDTH/2, BTNHEIGHT/2);
    [sqztzxblywBtn addSubview:sqztzxblywImageView];
    sqztzxblywBtn.backgroundColor = [UIColor whiteColor];
    sqztzxblywBtn.frame = CGRectMake(1, NAVIGATIONHIGHT+1+(BTNHEIGHT+2)*2,BTNWIDTH,BTNHEIGHT );
    [sqztzxblywBtn addTarget:self action:@selector(jumpPageForBSDT:) forControlEvents:UIControlEventTouchUpInside];
    sqztzxblywBtn.tag = 5;
    [self.view addSubview:sqztzxblywBtn];
    
    UIButton * sqtxywBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImageView * sqtxywImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shenqingtingxianyewu"]];
    sqtxywImageView.frame = CGRectMake(0, 0, BTNWIDTH*IMGSIZERATIO, BTNWIDTH*IMGSIZERATIO*1.64);
    sqtxywImageView.center = CGPointMake(BTNWIDTH/2, BTNHEIGHT/2);
    [sqtxywBtn addSubview:sqtxywImageView];
    sqtxywBtn.backgroundColor = [UIColor whiteColor];
    sqtxywBtn.frame = CGRectMake(UISCREENWIDTH/2+ 1, NAVIGATIONHIGHT+1+(BTNHEIGHT+2)*2,BTNWIDTH,BTNHEIGHT );
    [sqtxywBtn addTarget:self action:@selector(jumpPageForBSDT:) forControlEvents:UIControlEventTouchUpInside];
    sqtxywBtn.tag = 6;
    [self.view addSubview:sqtxywBtn];
    
    UIButton * sqhfywBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImageView * sqhfywImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shenqinghuifuyewu"]];
    sqhfywImageView.frame = CGRectMake(0, 0, BTNWIDTH*IMGSIZERATIO, BTNWIDTH*IMGSIZERATIO*1.64);
    sqhfywImageView.center = CGPointMake(BTNWIDTH/2, BTNHEIGHT/2);
    [sqhfywBtn addSubview:sqhfywImageView];
    sqhfywBtn.backgroundColor = [UIColor whiteColor];
    sqhfywBtn.frame = CGRectMake(1, NAVIGATIONHIGHT+1+(BTNHEIGHT+2)*3,BTNWIDTH,BTNHEIGHT );
    [sqhfywBtn addTarget:self action:@selector(jumpPageForBSDT:) forControlEvents:UIControlEventTouchUpInside];
    sqhfywBtn.tag = 7;
    [self.view addSubview:sqhfywBtn];
    
    UIButton * qysqcxBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImageView * qysqcxImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wodeshenqingchaxun"]];
    qysqcxImageView.frame = CGRectMake(0, 0, BTNWIDTH*IMGSIZERATIO, BTNWIDTH*IMGSIZERATIO*1.64);
    qysqcxImageView.center = CGPointMake(BTNWIDTH/2, BTNHEIGHT/2);
    [qysqcxBtn addSubview:qysqcxImageView];
    qysqcxBtn.backgroundColor = [UIColor whiteColor];
    qysqcxBtn.frame = CGRectMake(UISCREENWIDTH/2+ 1, NAVIGATIONHIGHT+1+(BTNHEIGHT+2)*3,BTNWIDTH,BTNHEIGHT );
    [sqhfywBtn addTarget:self action:@selector(jumpPageForBSDT:) forControlEvents:UIControlEventTouchUpInside];
    qysqcxBtn.tag = 8;
    [self.view addSubview:qysqcxBtn];
    
    
    if (!app.login) {
        self.loginView = [[UIView alloc]initWithFrame:self.view.bounds];
        self.loginView.backgroundColor = [UIColor whiteColor];
        self.titleLabel.text = @"用户登录";
        
        accountTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, NAVIGATIONHIGHT, UISCREENWIDTH, 50)];
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
        
        passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(0,NAVIGATIONHIGHT+ 50, UISCREENWIDTH, 50)];
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
        loginBtn.center = CGPointMake(UISCREENWIDTH/2, NAVIGATIONHIGHT+150);
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
        forgetBtn.frame = CGRectMake(UISCREENWIDTH*4/5, NAVIGATIONHIGHT+180, UISCREENWIDTH*1/5, 40);
        forgetBtn.backgroundColor = [UIColor clearColor];
        [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [forgetBtn setTintColor:[UIColor redColor]];
        [self.loginView addSubview:forgetBtn];
        [self.view addSubview:self.loginView];
        [self.view bringSubviewToFront:self.loginView];
        
    }

}

- (void)login{
    [self.view sendSubviewToBack:self.loginView];
    self.titleLabel.text = @"办事大厅";
    if (passwordTextField.isFirstResponder) {
        [passwordTextField resignFirstResponder];
    }else if (accountTextField.isFirstResponder){
        [accountTextField resignFirstResponder];
    }
}

- (void)jumpPageForBSDT:(UIButton*)btn{
    BSDTDetailViewController * bsdt = [BSDTDetailViewController alloc];
    switch (btn.tag) {
        case 1:
            app.titleForCurrentPage = @"用户信息修改";

            bsdt = [bsdt init];
            [self.navigationController pushViewController:bsdt animated:YES];
            break;
        case 2:
            app.titleForCurrentPage = @"申请新增网点";

            bsdt = [bsdt init];
            [self.navigationController pushViewController:bsdt animated:YES];
            break;
            
        default:
            break;
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
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
