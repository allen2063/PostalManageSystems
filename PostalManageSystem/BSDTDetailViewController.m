//
//  BSDTDetailViewController.m
//  PostalManageSystem
//
//  Created by ZengYifei on 15/8/24.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "BSDTDetailViewController.h"
#define leftInterval 10
#define heightInterval 10
#define heightForOneLine 30
#define tableViewCellHeight 35
#define selectedfont 14
@interface BSDTDetailViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    AppDelegate *app;
    UIScrollView * createBranchesScrollView;
    int selectedTextFieldTag;
    UIView * currentView;
    UIDatePicker * datePicker;
    int textFieldHeight;
    CGPoint tempOffset;
}
@property (strong,nonatomic) UILabel * titleLabel;
@property (strong,nonatomic) UITableView * selectedTable;
@property (strong,nonatomic) NSMutableArray * dataList;
@property (strong,nonatomic) UIView * blackView;

@end

@implementation BSDTDetailViewController

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
    self.blackView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.blackView.backgroundColor = [UIColor blackColor];
    self.blackView.alpha = 0.0;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelView)];
    [self.blackView addGestureRecognizer:recognizer];
    
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
    if([app.titleForCurrentPage isEqualToString:@"用户信息修改"]){
        [self initYHXXXG];
    }else if ([app.titleForCurrentPage isEqualToString:@"申请新增网点"]){
        [self initCreateBranches];
    }
    tempOffset = CGPointMake(0, -64);
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int keyboardHeight = keyboardRect.size.height;
    //NSLog(@"textFieldHeight%d  keyboardHeight%d UISCREENHEIGHT%f",textFieldHeight,keyboardHeight,UISCREENHEIGHT);
    if ((keyboardHeight - (UISCREENHEIGHT - textFieldHeight)+NAVIGATIONHIGHT >0)&&[currentView isKindOfClass:[UIScrollView class]]) {
        UIScrollView * temp = (UIScrollView * )currentView;
        tempOffset = temp.contentOffset;
        temp.contentOffset = CGPointMake(0, keyboardHeight - (UISCREENHEIGHT - textFieldHeight));
        NSLog(@"%@",NSStringFromCGPoint(temp.contentOffset));
    }
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int keyboardHeight = keyboardRect.size.height;
    
    if ((keyboardHeight - (UISCREENHEIGHT - textFieldHeight)+NAVIGATIONHIGHT >0)&&[currentView isKindOfClass:[UIScrollView class]]) {
        UIScrollView * temp = (UIScrollView * )currentView;
        temp.contentOffset = tempOffset;
        NSLog(@"%@",NSStringFromCGPoint(temp.contentOffset));
    }
}


#pragma mark - 用户信息修改页面
- (void)initYHXXXG{
    UITextField * accountTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, NAVIGATIONHIGHT+30, UISCREENWIDTH-20, 40)];
    UILabel * accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    accountLabel.text = @" 账号:";
    accountTextField.leftView = accountLabel;
    accountTextField.leftViewMode = UITextFieldViewModeAlways;
    accountTextField.delegate = self;
    [accountTextField setBorderStyle:UITextBorderStyleLine];
    accountTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:accountTextField];
    
    UITextField * passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, NAVIGATIONHIGHT+30+41, UISCREENWIDTH-20, 40)];
    UILabel * passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    passwordLabel.text = @" 密码:";
    passwordTextField.leftView = passwordLabel;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    passwordTextField.delegate = self;
    [passwordTextField setBorderStyle:UITextBorderStyleLine];
    passwordTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:passwordTextField];
    
    UITextField * nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, NAVIGATIONHIGHT+30+41*2, UISCREENWIDTH-20, 40)];
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    nameLabel.text = @" 姓名:";
    nameTextField.leftView = nameLabel;
    nameTextField.leftViewMode = UITextFieldViewModeAlways;
    nameTextField.delegate = self;
    [nameTextField setBorderStyle:UITextBorderStyleLine];
    nameTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:nameTextField];
    
    UITextField * addressTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, NAVIGATIONHIGHT+30+41*3, UISCREENWIDTH-20, 40)];
    UILabel * addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    addressLabel.text = @" 地址:";
    addressTextField.leftView = addressLabel;
    addressTextField.leftViewMode = UITextFieldViewModeAlways;
    addressTextField.delegate = self;
    [addressTextField setBorderStyle:UITextBorderStyleLine];
    addressTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:addressTextField];
    
    UITextField * phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, NAVIGATIONHIGHT+30+41*4, UISCREENWIDTH-20, 40)];
    UILabel * phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
    phoneLabel.text = @" 联系电话:";
    phoneTextField.leftView = phoneLabel;
    phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    phoneTextField.delegate = self;
    [phoneTextField setBorderStyle:UITextBorderStyleLine];
    phoneTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:phoneTextField];
    
    UITextField * emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, NAVIGATIONHIGHT+30+41*5, UISCREENWIDTH-20, 40)];
    UILabel * emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
    emailLabel.text = @" 电子邮箱:";
    emailTextField.leftView = emailLabel;
    emailTextField.leftViewMode = UITextFieldViewModeAlways;
    emailTextField.delegate = self;
    [emailTextField setBorderStyle:UITextBorderStyleLine];
    emailTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:emailTextField];
    
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitBtn.frame = CGRectMake(10, NAVIGATIONHIGHT+60+41*6.2, UISCREENWIDTH-20, 40);
    submitBtn.backgroundColor = UIColorFromRGBValue(0x028e45);
    //绘制圆角矩形按钮和边线
    [submitBtn.layer setMasksToBounds:YES];
    [submitBtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [submitBtn.layer setBorderWidth:1.0];   //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 2/255.0, 142/255.0, 69/255.0, 1 });
    [submitBtn.layer setBorderColor:colorref];//边框颜色
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal] ;
    [submitBtn setTitleColor:[UIColor yellowColor]forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    submitBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
}

- (void)submit{
   
}

#pragma mark - 申请新增网点
- (void)initCreateBranches{
    createBranchesScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    createBranchesScrollView.delegate = self;
    createBranchesScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.5);
    currentView = createBranchesScrollView;
    createBranchesScrollView.bounces = NO;
    self.blackView.frame = CGRectMake(0, 0,  createBranchesScrollView.contentSize.width, createBranchesScrollView.contentSize.height);
    [self.view addSubview:createBranchesScrollView];
    //line1
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(leftInterval, heightInterval, 45, heightForOneLine)];
    label1.text = @"事项:";
    label1.font = [UIFont systemFontOfSize:selectedfont];
    //ios7后通过以下方法自动适应文字的长度
    CGRect rect = [label1.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, heightForOneLine) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label1.font} context:nil];
    label1.frame = CGRectMake(leftInterval, heightInterval, rect.size.width, heightForOneLine);
    [createBranchesScrollView addSubview:label1];
    UITextField * textField1 =  [[UITextField alloc]initWithFrame:CGRectMake(leftInterval + label1.frame.size.width, heightInterval, UISCREENWIDTH-leftInterval*2 - label1.frame.size.width, heightForOneLine)];
    textField1.text = @"请选择";
    textField1.tag = 1;
    textField1.delegate = self;
    textField1.borderStyle = UITextBorderStyleRoundedRect;
    textField1.returnKeyType = UIReturnKeyDone;
    textField1.font = [UIFont systemFontOfSize:selectedfont];
    [createBranchesScrollView addSubview:textField1];
    
    //line2
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(leftInterval, heightInterval*2+heightForOneLine, 65, heightForOneLine)];
    label2.text = @"经营方式:";
    label2.font = [UIFont systemFontOfSize:selectedfont];
    rect = [label2.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, heightForOneLine) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label2.font} context:nil];
    label2.frame = CGRectMake(leftInterval, heightInterval*2+heightForOneLine, rect.size.width, heightForOneLine);

    [createBranchesScrollView addSubview:label2];
    UITextField * textField2 =  [[UITextField alloc]initWithFrame:CGRectMake(leftInterval + label2.frame.size.width, heightInterval*2+heightForOneLine, UISCREENWIDTH/4.7, heightForOneLine)];
    textField2.text = @"请选择";
    textField2.tag = 2;
    textField2.delegate = self;
    textField2.borderStyle = UITextBorderStyleRoundedRect;
    textField2.returnKeyType = UIReturnKeyDone;
    textField2.font = [UIFont systemFontOfSize:selectedfont];
    [createBranchesScrollView addSubview:textField2];
    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(textField2.frame.origin.x + textField2.frame.size.width+leftInterval, heightInterval*2+heightForOneLine, 65, heightForOneLine)];
    label3.text = @"房屋产权:";
    label3.font = [UIFont systemFontOfSize:selectedfont];
    rect = [label3.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, heightForOneLine) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label3.font} context:nil];
    label3.frame = CGRectMake(textField2.frame.origin.x + textField2.frame.size.width+leftInterval, heightInterval*2+heightForOneLine, rect.size.width, heightForOneLine);
    [createBranchesScrollView addSubview:label3];
    UITextField * textField3 =  [[UITextField alloc]initWithFrame:CGRectMake( label3.frame.origin.x + label3.frame.size.width, heightInterval*2+heightForOneLine, UISCREENWIDTH-leftInterval*3-label2.frame.size.width-label3.frame.size.width-textField2.frame.size.width, heightForOneLine)];
    textField3.text = @"请选择";
    textField3.tag = 3;
    textField3.delegate = self;
    textField3.borderStyle = UITextBorderStyleRoundedRect;
    textField3.returnKeyType = UIReturnKeyDone;
    textField3.font = [UIFont systemFontOfSize:selectedfont];
    [createBranchesScrollView addSubview:textField3];
    
    //line3
    UILabel * label4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 65, heightForOneLine)];
    label4.text =@"邮政场所名称:";
    label4.font = [UIFont systemFontOfSize:selectedfont];
    rect = [label4.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, heightForOneLine) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label4.font} context:nil];
    [label4 setFrame:CGRectMake(leftInterval, heightInterval*3+heightForOneLine*2, rect.size.width, heightForOneLine)];
    [createBranchesScrollView addSubview:label4];
    UITextField * textField4 =  [[UITextField alloc]initWithFrame:CGRectMake( label4.frame.origin.x + label4.frame.size.width, heightInterval*3+heightForOneLine*2, UISCREENWIDTH-leftInterval*2-label4.frame.size.width, heightForOneLine)];
    textField4.placeholder = @"请输入邮政场所名称";
    textField4.tag = 4;
    textField4.delegate = self;
    textField4.borderStyle = UITextBorderStyleRoundedRect;
    textField4.returnKeyType = UIReturnKeyDone;
    textField4.font = [UIFont systemFontOfSize:selectedfont];
    [createBranchesScrollView addSubview:textField4];
    //line4
    UILabel * label5 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 65, heightForOneLine)];
    label5.text =@"场所地址:";
    label5.font = [UIFont systemFontOfSize:selectedfont];
    rect = [label5.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, heightForOneLine) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label5.font} context:nil];
    [label5 setFrame:CGRectMake(leftInterval, heightInterval*4+heightForOneLine*3, rect.size.width, heightForOneLine)];
    [createBranchesScrollView addSubview:label5];
    UITextField * textField5 =  [[UITextField alloc]initWithFrame:CGRectMake( label5.frame.origin.x + label5.frame.size.width, heightInterval*4+heightForOneLine*3, UISCREENWIDTH/3.5, heightForOneLine)];
    textField5.placeholder = @"城市";
    textField5.tag = 5;
    textField5.delegate = self;
    textField5.borderStyle = UITextBorderStyleRoundedRect;
    textField5.returnKeyType = UIReturnKeyDone;
    textField5.font = [UIFont systemFontOfSize:selectedfont];
    UILabel * rightViewLabelForTextField5 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, heightForOneLine)];
    rightViewLabelForTextField5.font = [UIFont systemFontOfSize:14];
    rightViewLabelForTextField5.text = @"市";
    textField5.rightView = rightViewLabelForTextField5;
    textField5.rightViewMode = UITextFieldViewModeAlways;
    [createBranchesScrollView addSubview:textField5];
    UITextField * textField6 =  [[UITextField alloc]initWithFrame:CGRectMake( textField5.frame.origin.x + textField5.frame.size.width+leftInterval, heightInterval*4+heightForOneLine*3, UISCREENWIDTH-leftInterval*3-textField5.frame.size.width-label5.frame.size.width, heightForOneLine)];
    textField6.placeholder = @"县/区";
    textField6.tag = 6;
    textField6.delegate = self;
    textField6.borderStyle = UITextBorderStyleRoundedRect;
    textField6.returnKeyType = UIReturnKeyDone;
    textField6.font = [UIFont systemFontOfSize:selectedfont];
    UILabel * rightViewLabelForTextField6 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 45, heightForOneLine)];
    rightViewLabelForTextField6.font = [UIFont systemFontOfSize:14];
    rightViewLabelForTextField6.text = @"县/区";
    textField6.rightView = rightViewLabelForTextField6;
    textField6.rightViewMode = UITextFieldViewModeAlways;
    [createBranchesScrollView addSubview:textField6];
    //line5
    UITextField * textField7 =  [[UITextField alloc]initWithFrame:CGRectMake( leftInterval, heightInterval*5+heightForOneLine*4, UISCREENWIDTH*2/3, heightForOneLine)];
    textField7.placeholder = @"街/乡";
    textField7.tag = 7;
    textField7.delegate = self;
    textField7.borderStyle = UITextBorderStyleRoundedRect;
    textField7.returnKeyType = UIReturnKeyDone;
    textField7.font = [UIFont systemFontOfSize:selectedfont];
    UILabel * rightViewLabelForTextField7 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 45, heightForOneLine)];
    rightViewLabelForTextField7.font = [UIFont systemFontOfSize:14];
    rightViewLabelForTextField7.text = @"街/乡";
    textField7.rightView = rightViewLabelForTextField7;
    textField7.rightViewMode = UITextFieldViewModeAlways;
    [createBranchesScrollView addSubview:textField7];
    UITextField * textField8 =  [[UITextField alloc]initWithFrame:CGRectMake( textField7.frame.origin.x + textField7.frame.size.width+leftInterval, heightInterval*5+heightForOneLine*4, UISCREENWIDTH-textField7.frame.size.width-leftInterval*3, heightForOneLine)];
    textField8.placeholder = @"号";
    textField8.tag = 8;
    textField8.delegate = self;
    textField8.borderStyle = UITextBorderStyleRoundedRect;
    textField8.returnKeyType = UIReturnKeyDone;
    textField8.font = [UIFont systemFontOfSize:selectedfont];
    UILabel * rightViewLabelForTextField8 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, heightForOneLine)];
    rightViewLabelForTextField8.font = [UIFont systemFontOfSize:14];
    rightViewLabelForTextField8.text = @"号";
    textField8.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    textField8.rightView = rightViewLabelForTextField8;
    textField8.rightViewMode = UITextFieldViewModeAlways;
    [createBranchesScrollView addSubview:textField8];
    //line6
    UILabel * label6 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 65, heightForOneLine)];
    label6.text =@"经度:";
    label6.font = [UIFont systemFontOfSize:selectedfont];
    rect = [label6.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, heightForOneLine) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label6.font} context:nil];
    [label6 setFrame:CGRectMake(leftInterval, heightInterval*6+heightForOneLine*5, rect.size.width, heightForOneLine)];
    [createBranchesScrollView addSubview:label6];
    UITextField * textField9 =  [[UITextField alloc]initWithFrame:CGRectMake( label6.frame.origin.x+label6.frame.size.width, heightInterval*6+heightForOneLine*5, UISCREENWIDTH/2-(leftInterval*1.5)-label6.frame.size.width, heightForOneLine)];
    textField9.placeholder = @"经度值";
    textField9.tag = 9;
    textField9.delegate = self;
    textField9.borderStyle = UITextBorderStyleRoundedRect;
    textField9.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    textField9.returnKeyType = UIReturnKeyDone;
    textField9.font = [UIFont systemFontOfSize:selectedfont];
    [createBranchesScrollView addSubview:textField9];
    UILabel * label7 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 65, heightForOneLine)];
    label7.text =@"纬度:";
    label7.font = [UIFont systemFontOfSize:selectedfont];
    rect = [label7.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, heightForOneLine) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label7.font} context:nil];
    [label7 setFrame:CGRectMake((leftInterval+UISCREENWIDTH)/2, heightInterval*6+heightForOneLine*5, rect.size.width, heightForOneLine)];
    [createBranchesScrollView addSubview:label7];
    UITextField * textField10 =  [[UITextField alloc]initWithFrame:CGRectMake( label7.frame.origin.x+label7.frame.size.width, heightInterval*6+heightForOneLine*5, UISCREENWIDTH/2-(leftInterval*1.5)-label7.frame.size.width, heightForOneLine)];
    textField10.placeholder = @"纬度值";
    textField10.tag = 10;
    textField10.delegate = self;
    textField10.borderStyle = UITextBorderStyleRoundedRect;
    textField10.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    textField10.returnKeyType = UIReturnKeyDone;
    textField10.font = [UIFont systemFontOfSize:selectedfont];
    [createBranchesScrollView addSubview:textField10];
    //line7
    UILabel * label8 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 65, heightForOneLine)];
    label8.text =@"邮政编码:";
    label8.font = [UIFont systemFontOfSize:selectedfont];
    rect = [label8.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, heightForOneLine) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label8.font} context:nil];
    [label8 setFrame:CGRectMake(leftInterval, heightInterval*7+heightForOneLine*6, rect.size.width, heightForOneLine)];
    [createBranchesScrollView addSubview:label8];
    UITextField * textField11 =  [[UITextField alloc]initWithFrame:CGRectMake( label8.frame.origin.x+label8.frame.size.width, heightInterval*7+heightForOneLine*6, UISCREENWIDTH/4.6, heightForOneLine)];
    textField11.placeholder = @"邮政编码";
    textField11.tag = 11;
    textField11.delegate = self;
    textField11.borderStyle = UITextBorderStyleRoundedRect;
    textField11.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    textField11.returnKeyType = UIReturnKeyDone;
    textField11.font = [UIFont systemFontOfSize:selectedfont];
    [createBranchesScrollView addSubview:textField11];
    UILabel * label9 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 65, heightForOneLine)];
    label9.text =@"请设置地域:";
    label9.font = [UIFont systemFontOfSize:selectedfont];
    rect = [label9.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, heightForOneLine) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label9.font} context:nil];
    [label9 setFrame:CGRectMake(textField11.frame.origin.x+textField11.frame.size.width+leftInterval, heightInterval*7+heightForOneLine*6, rect.size.width, heightForOneLine)];
    [createBranchesScrollView addSubview:label9];
    UITextField * textField12 =  [[UITextField alloc]initWithFrame:CGRectMake( label9.frame.origin.x+label9.frame.size.width, heightInterval*7+heightForOneLine*6, UISCREENWIDTH-leftInterval*3-label9.frame.size.width-label8.frame.size.width-textField11.frame.size.width, heightForOneLine)];
    textField12.text = @"请选择";
    textField12.tag = 12;
    textField12.delegate = self;
    textField12.borderStyle = UITextBorderStyleRoundedRect;
    textField12.returnKeyType = UIReturnKeyDone;
    textField12.font = [UIFont systemFontOfSize:selectedfont];
    [createBranchesScrollView addSubview:textField12];
    //line8
    UILabel * label10 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 65, heightForOneLine)];
    label10.text =@"上级单位:";
    label10.font = [UIFont systemFontOfSize:selectedfont];
    rect = [label10.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, heightForOneLine) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label10.font} context:nil];
    [label10 setFrame:CGRectMake(leftInterval, heightInterval*8+heightForOneLine*7, rect.size.width, heightForOneLine)];
    [createBranchesScrollView addSubview:label10];
    UITextField * textField13 =  [[UITextField alloc]initWithFrame:CGRectMake( label10.frame.origin.x+label10.frame.size.width, heightInterval*8+heightForOneLine*7, UISCREENWIDTH-leftInterval*2-label10.frame.size.width, heightForOneLine)];
    textField13.placeholder = @"单位名称";
    textField13.tag = 13;
    textField13.delegate = self;
    textField13.borderStyle = UITextBorderStyleRoundedRect;
    textField13.returnKeyType = UIReturnKeyDone;
    textField13.font = [UIFont systemFontOfSize:selectedfont];
    UILabel * rightViewLabelFortextField13 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, heightForOneLine)];
    rightViewLabelFortextField13.font = [UIFont systemFontOfSize:14];
    rightViewLabelFortextField13.text = @"邮政分公司";
    rect = [rightViewLabelFortextField13.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, heightForOneLine) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:rightViewLabelFortextField13.font} context:nil];
    rightViewLabelFortextField13.frame = CGRectMake(0, 0, rect.size.width+10, heightForOneLine);
    textField13.rightView = rightViewLabelFortextField13;
    textField13.rightViewMode = UITextFieldViewModeAlways;
    [createBranchesScrollView addSubview:textField13];
    //line9
    UILabel * label11 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 65, heightForOneLine)];
    label11.text =@"营业场所负责人:";
    label11.font = [UIFont systemFontOfSize:selectedfont];
    rect = [label11.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, heightForOneLine) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label11.font} context:nil];
    [label11 setFrame:CGRectMake(leftInterval, heightInterval*9+heightForOneLine*8, rect.size.width, heightForOneLine)];
    [createBranchesScrollView addSubview:label11];
    UITextField * textField14 =  [[UITextField alloc]initWithFrame:CGRectMake( label11.frame.origin.x+label11.frame.size.width, heightInterval*9+heightForOneLine*8, UISCREENWIDTH-leftInterval*2-label11.frame.size.width, heightForOneLine)];
    textField14.placeholder = @"负责人姓名";
    textField14.tag = 14;
    textField14.delegate = self;
    textField14.borderStyle = UITextBorderStyleRoundedRect;
    textField14.returnKeyType = UIReturnKeyDone;
    textField14.font = [UIFont systemFontOfSize:selectedfont];
    [createBranchesScrollView addSubview:textField14];
    //line10
    UILabel * label12 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 65, heightForOneLine)];
    label12.text =@"联系方式:";
    label12.font = [UIFont systemFontOfSize:selectedfont];
    rect = [label12.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, heightForOneLine) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label12.font} context:nil];
    [label12 setFrame:CGRectMake(leftInterval, heightInterval*10+heightForOneLine*9, rect.size.width, heightForOneLine)];
    [createBranchesScrollView addSubview:label12];
    UITextField * textField15 =  [[UITextField alloc]initWithFrame:CGRectMake( label12.frame.origin.x+label12.frame.size.width, heightInterval*10+heightForOneLine*9, UISCREENWIDTH-leftInterval*2-label12.frame.size.width, heightForOneLine)];
    textField15.placeholder = @"电话号码";
    textField15.tag = 15;
    textField15.delegate = self;
    textField15.borderStyle = UITextBorderStyleRoundedRect;
    textField15.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    textField15.returnKeyType = UIReturnKeyDone;
    textField15.font = [UIFont systemFontOfSize:selectedfont];
    [createBranchesScrollView addSubview:textField15];
    //line11
    UILabel * label13 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 65, heightForOneLine)];
    label13.text =@"开业时间:";
    label13.font = [UIFont systemFontOfSize:selectedfont];
    rect = [label13.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, heightForOneLine) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label13.font} context:nil];
    [label13 setFrame:CGRectMake(leftInterval, heightInterval*11+heightForOneLine*10, rect.size.width, heightForOneLine)];
    [createBranchesScrollView addSubview:label13];
    UITextField * textField16 =  [[UITextField alloc]initWithFrame:CGRectMake( label13.frame.origin.x+label13.frame.size.width, heightInterval*11+heightForOneLine*10, UISCREENWIDTH-leftInterval*2-label13.frame.size.width, heightForOneLine)];
    textField16.text = @"请选择";
    textField16.tag = 16;
    textField16.delegate = self;
    textField16.borderStyle = UITextBorderStyleRoundedRect;
    textField16.returnKeyType = UIReturnKeyDone;
    textField16.font = [UIFont systemFontOfSize:selectedfont];
    [createBranchesScrollView addSubview:textField16];

}



#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textFieldHeight = textField.frame.size.height + textField.frame.origin.y;
    switch (textField.tag) {
        case 1:
            self.dataList = [[NSMutableArray alloc]initWithObjects:@"设置邮政普遍服务营业场所",@"设置其他邮政营业场所", nil];
            [self showTableViewWith:textField];
            selectedTextFieldTag = 1;
            return NO;
            break;
        case 2:
            self.dataList = [[NSMutableArray alloc]initWithObjects:@"自办",@"委办", nil];
            [self showTableViewWith:textField];
            selectedTextFieldTag = 2;
            return NO;
            break;
        case 3:
            self.dataList = [[NSMutableArray alloc]initWithObjects:@"自用",@"租用",@"无偿使用",@"其他", nil];
            [self showTableViewWith:textField];
            selectedTextFieldTag = 3;
            return NO;
            break;
        case 12:
            self.dataList = [[NSMutableArray alloc]initWithObjects:@"城市地区",@"乡镇地区",@"农村地区", nil];
            [self showTableViewWith:textField];
            selectedTextFieldTag = 12;
            return NO;
            break;
        case 16:
            [self showPickerWithTextField:textField];
            selectedTextFieldTag = 16;
            return NO;
            break;
        default:
            return YES;

            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self.dataList objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:selectedfont];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    UITextField * text = (UITextField *)[self.view viewWithTag:selectedTextFieldTag];
    text.text =  [self.dataList objectAtIndex:indexPath.row];
    [self cancelView];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableViewCellHeight;
}

-(void)cancelView
{
    self.selectedTable.hidden = YES;
    datePicker.hidden = YES;
    if ([currentView isKindOfClass:[UIScrollView class]]) {
        UIScrollView * temp = (UIScrollView *)currentView;
        temp.scrollEnabled =YES;
        [UIView animateWithDuration:0.3 animations:^{
        self.blackView.alpha = 0.0;
        temp.contentOffset = tempOffset;
        }];
    }
    self.blackView.alpha = 0.0;
}

- (void)showTableViewWith:(UITextField *) textField{
    [self cancelView];
    self.selectedTable = [[UITableView alloc]initWithFrame:CGRectMake(textField.frame.origin.x, textField.frame.origin.y, textField.frame.size.width, tableViewCellHeight*self.dataList.count)];
    self.selectedTable.dataSource = self;
    self.selectedTable.delegate = self;
    [currentView addSubview:self.blackView];
    [currentView addSubview:self.selectedTable];
    [currentView bringSubviewToFront:self.selectedTable];
    [UIView animateWithDuration:0.3 animations:^{
        self.blackView.alpha = 0.5;
    }];
    if ([currentView isKindOfClass:[UIScrollView class]]) {
        UIScrollView * temp = (UIScrollView *)currentView;
        temp.scrollEnabled =NO;
        //tempOffset = temp.contentOffset;
    }
    
}

#pragma mark - picker

- (void)showPickerWithTextField:(UITextField *)textField{
    datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height*1.5, 0,0)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setCalendar:[NSCalendar currentCalendar]];
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    datePicker.backgroundColor = [UIColor whiteColor];
    float theOffset = self.view.frame.size.height - textField.frame.origin.y - textField.frame.size.height;
    [currentView addSubview:self.blackView];
    [currentView addSubview:datePicker];
    [currentView bringSubviewToFront:datePicker];
    if ([currentView isKindOfClass:[UIScrollView class]]) {
        UIScrollView * temp = (UIScrollView *)currentView;
        temp.scrollEnabled = NO;
        [UIView animateWithDuration:0.3 animations:^{
            tempOffset = temp.contentOffset;
            temp.contentOffset = CGPointMake(0, 216-theOffset); //view.frame.size.high  对于不同手机是不同的
            datePicker.frame = CGRectMake(0, self.view.frame.size.height+temp.contentOffset.y-datePicker.frame.size.height, 0, 0);
            self.blackView.alpha = 0.5;
        }];
    }

}

#pragma mark - touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];   //scrollview捕获了touch事件
    UITouch *touch = [touches anyObject];
    if (touch.view == self.blackView) {
        NSLog(@"black been touched");
    }
    [self cancelView];
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
