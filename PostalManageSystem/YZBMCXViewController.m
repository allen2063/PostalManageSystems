//
//  YZBMCXViewController.m
//  PostalManageSystem
//
//  Created by ZengYifei on 15/8/18.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "YZBMCXViewController.h"
#import "HZAreaPickerView.h"

@interface YZBMCXViewController ()<UITextFieldDelegate, HZAreaPickerDelegate>{
    AppDelegate *app;
    UIView * blackView;
    UILabel * instructionLabel;
    UILabel * informationLabel;
    UISegmentedControl *segmentControl;
}
@property (strong,nonatomic) UILabel * titleLabel;
@property (retain, nonatomic) UITextField *areaText;
@property (strong, nonatomic) NSString *areaValue;
@property (strong, nonatomic) HZAreaPickerView *locatePicker;
@end

@implementation YZBMCXViewController
@synthesize areaText;
@synthesize areaValue=_areaValue;
@synthesize locatePicker=_locatePicker;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        blackView = [[UIView alloc]initWithFrame:self.view.bounds];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 0.0;
        [self.view addSubview:blackView];
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
    
    self.areaText = [[UITextField alloc]initWithFrame:CGRectMake(0, NAVIGATIONHIGHT*2.5, UISCREENWIDTH/2, 45)];
    [self.areaText.layer setMasksToBounds:YES];
    [self.areaText.layer setCornerRadius:8.0]; //设置矩形四个圆角半径
    [self.areaText.layer setBorderWidth:2.0];   //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 2/255.0, 142/255.0, 69/255.0, 1 });
    [self.areaText.layer setBorderColor:colorref];//边框颜色
    self.areaText.center = CGPointMake(self.view.center.x, NAVIGATIONHIGHT*3.7);
    self.areaText.delegate = self;
    self.areaText.text = @" 北京 通州";
    self.areaText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self.view addSubview:self.areaText];
    
    NSArray *array=@[@"按地区查询",@"按邮政编码查询"];
    segmentControl=[[UISegmentedControl alloc]initWithItems:array];
    //segmentControl.segmentedControlStyle=UISegmentedControlSegment;
    //设置位置 大小
    segmentControl.frame=CGRectMake(0, NAVIGATIONHIGHT, self.view.frame.size.width, 40);
    //默认选择
    segmentControl.selectedSegmentIndex=0;
    //设置背景色
    segmentControl.tintColor=UIColorFromRGBValue(0x028e45);
    //设置监听事件
    [segmentControl addTarget:self action:@selector(change) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentControl];
    
    instructionLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, NAVIGATIONHIGHT*2, UISCREENWIDTH-20, 30)];
    instructionLabel.text = @"您选择的查询地区是：";
    [self.view addSubview:instructionLabel];
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    searchBtn.backgroundColor = [UIColor lightGrayColor];
    [searchBtn setTitle:@"查询" forState:UIControlStateNormal];
    searchBtn.frame =CGRectMake(0, 0, UISCREENWIDTH/3, 30);
    searchBtn.center = self.view.center;
    searchBtn.backgroundColor = UIColorFromRGBValue(0x028e45);
    [searchBtn setTintColor:[UIColor yellowColor]];
    [searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    informationLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH-100, UISCREENHEIGHT/8)];
    informationLabel.center = CGPointMake(self.view.center.x, self.view.center.y+informationLabel.frame.size.height*1.8);
    informationLabel.text = @"";
    informationLabel.textAlignment = NSTextAlignmentCenter;
    [informationLabel.layer setMasksToBounds:YES];
    [informationLabel.layer setCornerRadius:8.0]; //设置矩形四个圆角半径
    [informationLabel.layer setBorderWidth:2.0];   //边框宽度
     colorSpace = CGColorSpaceCreateDeviceRGB();
     colorref = CGColorCreate(colorSpace,(CGFloat[]){ 2/255.0, 142/255.0, 69.0/255.0, 1 });
    [informationLabel.layer setBorderColor:colorref];//边框颜色
    [self.view addSubview:informationLabel];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self showPicker];
}

-(void)change{
    if (segmentControl.selectedSegmentIndex == 1) {
        instructionLabel.text = @"请输入邮件编码：";
        [self cancelLocatePicker];
        self.areaText.text= @"";
    }else{
        instructionLabel.text = @"您选择的查询地区是：";
        [self showPicker];
        self.areaText.text = @" 北京 通州";
    }
}

- (void)search{
    
}

-(void)setAreaValue:(NSString *)areaValue
{
    if (![_areaValue isEqualToString:areaValue]) {
        //_areaValue = [areaValue retain];
        self.areaText.text = areaValue;
    }
}

- (void)viewDidUnload
{
    [self setAreaText:nil];
    [self cancelLocatePicker];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        self.areaValue = [NSString stringWithFormat:@" %@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
    }
}

-(void)cancelLocatePicker
{
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
    [UIView animateWithDuration:0.3 animations:^{
        blackView.alpha = 0.0;
    }];
}

- (void)showPicker{
    [self cancelLocatePicker];
    self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self];
    [self.locatePicker showInView:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        blackView.alpha = 0.5;
    }];
}


#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (segmentControl.selectedSegmentIndex == 0) {
        [self showPicker];
        return NO;
    }else{
        return YES;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self cancelLocatePicker];
}

// 一般用来隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (segmentControl.selectedSegmentIndex ==1) {
        [textField resignFirstResponder];
    }
    return YES;
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
