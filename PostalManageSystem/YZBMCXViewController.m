//
//  YZBMCXViewController.m
//  PostalManageSystem
//
//  Created by ZengYifei on 15/8/18.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "YZBMCXViewController.h"
#import "HZAreaPickerView.h"
#define tableViewCellHeight 35
#define selectedfont 14
#define defualtFont 17
#define FINDPROVINCEID 1
#define FINDCITYID 2
#define FINDAREAID 3
#define FINDZIPCODE 4
#define GETPROVINCENAME 11
#define GETCITYNAME 12
#define GETAREANAME 13
#define GETZIPCODE 14
@interface YZBMCXViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, HZAreaPickerDelegate>{
    AppDelegate *app;
    UIView * blackView;
    UILabel * instructionLabel;
    UILabel * informationLabel;
    UISegmentedControl *segmentControl;
    BOOL stringToInt;
    NSMutableArray *districtArray;
    NSMutableArray * provinceArray;
    NSMutableArray * cityArray;
    NSMutableArray * areaArray;
    
    NSMutableString * DistrictTextFieldString;
    
    int provinceid;
    int cityid;
    int areaid;
    int zipcode;
    int searchState;
}
@property (strong,nonatomic) UILabel * titleLabel;
@property (strong,nonatomic) UILabel * districtLabel;
@property (retain, nonatomic) UITextField *zipCodeText;
@property (strong, nonatomic) NSString *areaValue;
@property (strong, nonatomic) HZAreaPickerView *locatePicker;

@property (nonatomic) BOOL elementFound;
@property (strong, nonatomic) NSString *matchingElement;
@property (strong, nonatomic) NSMutableString *soapResults;
@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) NSMutableArray *dataList;
@end

@implementation YZBMCXViewController
@synthesize xmlParser;
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
        [self.view sendSubviewToBack:blackView];
        _matchingElement = @"RECORD";
        DistrictTextFieldString = [[NSMutableString alloc]init];
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(UISCREENWIDTH/8, UISCREENHEIGHT, UISCREENWIDTH*3/4, _dataList.count * tableViewCellHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
    
    self.zipCodeText = [[UITextField alloc]initWithFrame:CGRectMake(0, 50, UISCREENWIDTH-100, 45)];
    [self.zipCodeText.layer setMasksToBounds:YES];
    [self.zipCodeText.layer setCornerRadius:8.0]; //设置矩形四个圆角半径
    [self.zipCodeText.layer setBorderWidth:2.0];   //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 2/255.0, 142/255.0, 69/255.0, 1 });
    [self.zipCodeText.layer setBorderColor:colorref];//边框颜色
    self.zipCodeText.center = CGPointMake(self.view.center.x, UISCREENHEIGHT/2.5);
    self.zipCodeText.delegate = self;
    self.zipCodeText.font = [UIFont systemFontOfSize:defualtFont];
    self.zipCodeText.placeholder = @"请输入邮政编码";
    self.zipCodeText.textAlignment = NSTextAlignmentCenter;
    self.zipCodeText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.zipCodeText.hidden = YES;
    [self.view addSubview:self.zipCodeText];
    stringToInt = YES;
    
    self.districtLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, UISCREENWIDTH-100, 45)];
    [self.districtLabel.layer setMasksToBounds:YES];
    [self.districtLabel.layer setCornerRadius:8.0]; //设置矩形四个圆角半径
    [self.districtLabel.layer setBorderWidth:2.0];   //边框宽度
     colorSpace = CGColorSpaceCreateDeviceRGB();
     colorref = CGColorCreate(colorSpace,(CGFloat[]){ 2/255.0, 142/255.0, 69/255.0, 1 });
    [self.districtLabel.layer setBorderColor:colorref];//边框颜色
    self.districtLabel.center = CGPointMake(self.view.center.x, UISCREENHEIGHT/2.5);
    self.districtLabel.tag = 30;
    self.districtLabel.numberOfLines = 2;
    self.districtLabel.text = @"请输入要查询的地区";
    self.districtLabel.textAlignment = NSTextAlignmentCenter;
    self.districtLabel.hidden = NO;
    self.districtLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lableTouched)];
    [self.districtLabel addGestureRecognizer:recognizer];
    [self.view addSubview:self.districtLabel];
    
    NSArray *array=@[@"按地区查询",@"按邮政编码查询"];
    segmentControl=[[UISegmentedControl alloc]initWithItems:array];
    //segmentControl.segmentedControlStyle=UISegmentedControlSegment;
    //设置位置 大小
    segmentControl.frame=CGRectMake(0, NAVIGATIONHEIGHT-1, self.view.frame.size.width, 40);
    //默认选择
    segmentControl.selectedSegmentIndex=0;
    //设置背景色
    segmentControl.tintColor=UIColorFromRGBValue(0x028e45);
    //设置监听事件
    [segmentControl addTarget:self action:@selector(change) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentControl];
    [segmentControl.layer setMasksToBounds:YES];
    [segmentControl.layer setCornerRadius:0.0]; //设置矩形四个圆角半径
    [segmentControl.layer setBorderWidth:2.0];   //边框宽度
    colorSpace = CGColorSpaceCreateDeviceRGB();
    colorref = CGColorCreate(colorSpace,(CGFloat[]){ 2/255.0, 142/255.0, 69.0/255.0, 1 });
    [segmentControl.layer setBorderColor:colorref];//边框颜色
    
    instructionLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, NAVIGATIONHEIGHT*2, UISCREENWIDTH-20, 30)];
    instructionLabel.text = @"您选择的查询地区是：";
    [self.view addSubview:instructionLabel];
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    searchBtn.backgroundColor = [UIColor lightGrayColor];
    [searchBtn setTitle:@"查询" forState:UIControlStateNormal];
    searchBtn.frame =CGRectMake(0, 0, UISCREENWIDTH/3, 30);
    searchBtn.center = CGPointMake(self.view.center.x, self.view.center.y +20);;
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
    informationLabel.numberOfLines = 2;
    [self.view addSubview:informationLabel];
    
    districtArray = [[NSMutableArray alloc]init];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [self showPicker];
}

-(void)change{
    self.districtLabel.text= @"请输入要查询的地区";
    self.districtLabel.font= [UIFont systemFontOfSize:17];
    
    if (segmentControl.selectedSegmentIndex == 1) {
        instructionLabel.text = @"请输入邮件编码：";
//        //判断table位置   如若在屏幕上则取消
//        if (_tableView.frame.origin.y < UISCREENHEIGHT) {
//            [self cancelLocatePicker];
//        }
        stringToInt = NO;
        self.districtLabel.hidden = YES;
        self.zipCodeText.hidden = NO;
        self.zipCodeText.placeholder= @"邮件编码";
        informationLabel.text = @"";
    }else{
        stringToInt = YES;
        instructionLabel.text = @"您选择的查询地区是：";
        self.zipCodeText.hidden = YES;
        self.districtLabel.hidden = NO;
        informationLabel.text = @"";
    }
    
}


-(void)setAreaValue:(NSString *)areaValue
{
    if (![_areaValue isEqualToString:areaValue]) {
        //_areaValue = [areaValue retain];
        self.zipCodeText.text = areaValue;
    }
}

//- (void)viewDidUnload
//{
//    [self setAreaText:nil];
//    [self cancelLocatePicker];
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//}

- (CGFloat  )adaptTextFontForString:(NSString *) string AndWidth:(float)width{
    CGFloat font = defualtFont;
    UILabel * adaptLabel = [[UILabel alloc]init];
    adaptLabel.text = string;
    adaptLabel.font = [UIFont systemFontOfSize:font];
    CGRect rect;
    adaptLabel.font = [UIFont systemFontOfSize:font];
    rect = [adaptLabel.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:adaptLabel.font} context:nil];
    //ios7后通过以下方法自动适应文字的长度
    for (font = defualtFont;rect.size.width > width; font--) {
        adaptLabel.font = [UIFont systemFontOfSize:font];
        rect = [adaptLabel.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:adaptLabel.font} context:nil];
    }
    NSLog(@"the font %f  now width %f  target width %f",font,rect.size.width,width);
    return font;
}

- (void)displayTheDistrict{
    [DistrictTextFieldString setString:@""];
    for (int i = (int)districtArray.count -1; i>=0 ;i--) {
    
        [DistrictTextFieldString appendString:[NSString stringWithFormat:@"%@ ",[districtArray objectAtIndex:i]]];
    }
    
    CGFloat font = [self adaptTextFontForString:[NSString stringWithFormat:@"您查询的邮政编码对应的地区是:%@",DistrictTextFieldString] AndWidth:informationLabel.frame.size.width*2];
    informationLabel.font = [UIFont systemFontOfSize:font];
    informationLabel.text = [NSString stringWithFormat:@"您查询的邮政编码对应的地区是:%@",DistrictTextFieldString];
}

#pragma mark - tableView
- (void)showTableView{
//    NSLog(@"tableshow");
    [self.view bringSubviewToFront:blackView];
    [self.view bringSubviewToFront:_tableView];

    [UIView animateWithDuration:0.3 animations:^{
        blackView.alpha = 0.5;
        if (_dataList.count * tableViewCellHeight > UISCREENHEIGHT -NAVIGATIONHEIGHT -30) {
            _tableView.frame = CGRectMake(UISCREENWIDTH/8, NAVIGATIONHEIGHT +50, UISCREENWIDTH*3/4,  UISCREENHEIGHT -NAVIGATIONHEIGHT -50);
            _tableView.center = CGPointMake(self.view.center.x, self.view.center.y + NAVIGATIONHEIGHT/2);
        }else
        _tableView.center = CGPointMake(self.view.center.x, self.view.center.y + NAVIGATIONHEIGHT/2);
    }];
//    NSLog(@"table %@",NSStringFromCGRect(_tableView.frame));
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataList count];
}

//- (NSArray * )sectionIndexTitlesForTableView:(UITableView *)tableView{
//    NSArray * titleForHead = [NSArray arrayWithObjects:@"请选择省份", nil];
//    return titleForHead;
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *  headString ;
    switch (searchState) {
            //省份
        case 11:
            headString = @"请选择省份:";
            break;
            //城市
        case 12:
            headString = @"请选择城市:";
            break;
            //地区
        case 13:
            headString = @"请选择区县:";
            break;
        default:
            break;
    }
    return headString;
}

//设定开头的分类样式
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
//    [sectionView setBackgroundColor:[UIColor brownColor]];
//    
//    //增加UILabel
//    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 18)];
//    [text setTextColor:[UIColor blackColor]];
//    [text setBackgroundColor:[UIColor clearColor]];
//    text.text = @"请选择省份";
//    [text setFont:[UIFont boldSystemFontOfSize:16.0]];
//    
//    [sectionView addSubview:text];
//    return sectionView;  
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    NSArray * str = [[_dataList objectAtIndex:indexPath.row] allKeys];
    cell.textLabel.text = [str objectAtIndex:0];
    cell.textLabel.font = [UIFont systemFontOfSize:selectedfont];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    CGFloat font;
    switch (searchState) {
            //省份
        case 11:
            provinceid = [[[_dataList objectAtIndex:indexPath.row]objectForKey:cell.textLabel.text]intValue];
            [DistrictTextFieldString setString:@""];
            [DistrictTextFieldString appendString:[NSString stringWithFormat:@"%@ ",cell.textLabel.text]];
            self.districtLabel.text = DistrictTextFieldString;
//            NSLog(@"省份 %@",self.areaText.text);
            [self getCityName];
            break;
            //城市
        case 12:
            cityid = [[[_dataList objectAtIndex:indexPath.row]objectForKey:cell.textLabel.text]intValue];
            [DistrictTextFieldString appendString:[NSString stringWithFormat:@"%@ ",cell.textLabel.text]];
            //根据字符长度调整font
            font = [self adaptTextFontForString:DistrictTextFieldString AndWidth:_districtLabel.frame.size.width*2];
            self.districtLabel.text = DistrictTextFieldString;
            self.districtLabel.font = [UIFont systemFontOfSize:font];
            NSLog(@"城市 %@",self.districtLabel.text);
            [self getAreaName];
            break;
            //地区
        case 13:
            areaid = [[[_dataList objectAtIndex:indexPath.row]objectForKey:cell.textLabel.text]intValue];
            [DistrictTextFieldString appendString:[NSString stringWithFormat:@"%@ ",cell.textLabel.text]];
            //根据字符长度调整font
            font = [self adaptTextFontForString:DistrictTextFieldString AndWidth:_districtLabel.frame.size.width*2];
            self.districtLabel.text = DistrictTextFieldString;
            self.districtLabel.font = [UIFont systemFontOfSize:font];
            NSLog(@"地区 %@",self.districtLabel.text);
            [self getZipCode];
            [self cancelLocatePicker];
            break;
        case 14:
            
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableViewCellHeight;
}

- (void)tableTransform{
    [UIView animateWithDuration:0.3 animations:^{
        blackView.alpha = 0.0;
        _tableView.center = CGPointMake(self.view.center.x, -_tableView.frame.size.height);
    }completion:^(BOOL finished){
        _tableView.center = CGPointMake(self.view.center.x, UISCREENHEIGHT + _tableView.frame.size.height);
        [_tableView reloadData];
        [self showTableView];
    }];
}

#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (segmentControl.selectedSegmentIndex == 0) {
        DistrictTextFieldString = [[NSMutableString alloc]initWithString:@"请输入要查询的地区"];
        self.districtLabel.text = DistrictTextFieldString;
        if (_tableView.superview != self.view) {
            [self.view addSubview:_tableView];
        }//else NSLog(@"未添加");
        
        [self.view bringSubviewToFront:_tableView];
        searchState = GETPROVINCENAME;
        [self getProvinceName];
        return NO;
    }else{
        return YES;
    }
}

- (void)lableTouched{
    DistrictTextFieldString = [[NSMutableString alloc]initWithString:@"请输入要查询的地区"];
    self.districtLabel.text = DistrictTextFieldString;
    if (_tableView.superview != self.view) {
        [self.view addSubview:_tableView];
    }//else NSLog(@"未添加");
    
    [self.view bringSubviewToFront:_tableView];
    searchState = GETPROVINCENAME;
    [self getProvinceName];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    if (touch.view == blackView) {
        [self cancelLocatePicker];
    }else if (touch.view == self.districtLabel){
        

    }
    NSLog(@"touch.view.tag%ld",(long)touch.view.tag);
}

// 一般用来隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (segmentControl.selectedSegmentIndex ==1) {
        [textField resignFirstResponder];
    }
    return YES;
}
#pragma mark - XML查询  地区——》邮政编码  ||邮政编码——》地区
- (void)getProvinceName{
    searchState = GETPROVINCENAME;
    provinceArray = [[NSMutableArray alloc]init];
    [self getProvinceInfo];
}

- (void)getCityName{
    searchState = GETCITYNAME;
    cityArray = [[NSMutableArray alloc]init];
    [self getCityInfo];
}

- (void)getAreaName{
    searchState = GETAREANAME;
    areaArray = [[NSMutableArray alloc]init];
    [self getAreaInfo];
}

#pragma mark - XML查询  地区——》邮政编码  ||邮政编码——》地区
- (void)search{
    if (segmentControl.selectedSegmentIndex == 0) {
        CGFloat font = [self adaptTextFontForString:[NSString stringWithFormat:@"您查询的地区的邮政编码为:%d",zipcode] AndWidth:informationLabel.frame.size.width*2];
        informationLabel.font = [UIFont systemFontOfSize:font];
        informationLabel.text = [NSString stringWithFormat:@"您查询的地区的邮政编码为:%d",zipcode];
    }else{
        zipcode = [_zipCodeText.text intValue];
        [self getZipCode];
        
    }
    
//    if (_tableView.superview != self.view) {
//        [self.view addSubview:_tableView];
//    }//else NSLog(@"未添加");
//    
//    [self.view bringSubviewToFront:_tableView];
//    searchState = GETPROVINCENAME;
//    stringToInt = YES;
//    [self getProvinceName];
    
    
//    NSString * districtString =  self.areaText.text ;
//    districtArray = (NSMutableArray *)[districtString componentsSeparatedByString:@" "];
//    for (int i = 0; i < districtArray.count ; i++) {
//        NSString * str = [NSString stringWithFormat:@"%@",[districtArray objectAtIndex:i]];
//        if ([str length] == 0) {
//            [districtArray removeObject:str];
//        }
//    }
//    
//    NSLog(@"%lu   %@",(unsigned long)districtArray.count, [districtArray objectAtIndex:0]);
//    //转换判断  是int—>string 还是 string->int
//    if ([[districtArray objectAtIndex:0]isKindOfClass:[NSString class]]) {
//        stringToInt = YES;
//        //查找省份信息
//        [self getProvinceInfo];
//        //查找城市信息
//        [self getCityInfo];
//        //查找地区信息
//        [self getAreaInfo];
//        //查找邮政编码
//        [self getZipCode];
//    }else{
//        stringToInt = NO;
//    }
}

- (void)getProvinceInfo{
    NSLog(@"getProvinceInfo");
    //获取省份名称列表
    if (searchState == 11) {
        NSString * str = [ConnectionAPI readXMLStringWithFileName:@"provinces"];
        NSData * dataString = [str dataUsingEncoding:NSUTF8StringEncoding ];
        self.xmlParser = [[NSXMLParser alloc] initWithData: dataString];
        self.xmlParser.delegate = self;
        [self.xmlParser setShouldResolveExternalEntities: YES];
        [self.xmlParser parse];
    }else{
        NSString * str = [ConnectionAPI readXMLStringWithFileName:@"provinces"];
        NSData * dataString = [str dataUsingEncoding:NSUTF8StringEncoding ];
        self.xmlParser = [[NSXMLParser alloc] initWithData: dataString];
        self.xmlParser.delegate = self;
        [self.xmlParser setShouldResolveExternalEntities: YES];
        [self.xmlParser parse];
    }
//    if (stringToInt) {
//        //searchState = FINDPROVINCEID;
//        // 使用NSXMLParser解析出我们想要的结果
//        NSString * str = [ConnectionAPI readXMLStringWithFileName:@"provinces"];
//        NSData * dataString = [str dataUsingEncoding:NSUTF8StringEncoding ];
//        self.xmlParser = [[NSXMLParser alloc] initWithData: dataString];
//        self.xmlParser.delegate = self;
//        [self.xmlParser setShouldResolveExternalEntities: YES];
//        [self.xmlParser parse];
//    }
}

- (void)getCityInfo{
    NSLog(@"getCityInfo");

    if (stringToInt) {
        //searchState = FINDCITYID;
        // 使用NSXMLParser解析出我们想要的结果
        NSString * str = [ConnectionAPI readXMLStringWithFileName:@"cities"];
        NSData * dataString = [str dataUsingEncoding:NSUTF8StringEncoding ];
        self.xmlParser = [[NSXMLParser alloc] initWithData: dataString];
        self.xmlParser.delegate = self;
        [self.xmlParser setShouldResolveExternalEntities: YES];
        [self.xmlParser parse];
    }else{
        NSString * str = [ConnectionAPI readXMLStringWithFileName:@"cities"];
        NSData * dataString = [str dataUsingEncoding:NSUTF8StringEncoding ];
        self.xmlParser = [[NSXMLParser alloc] initWithData: dataString];
        self.xmlParser.delegate = self;
        [self.xmlParser setShouldResolveExternalEntities: YES];
        [self.xmlParser parse];
    }
}

- (void)getAreaInfo{
    NSLog(@"getAreaInfo");

    if (stringToInt) {
        //searchState = FINDAREAID;
        // 使用NSXMLParser解析出我们想要的结果
        NSString * str = [ConnectionAPI readXMLStringWithFileName:@"areas"];
        NSData * dataString = [str dataUsingEncoding:NSUTF8StringEncoding ];
        self.xmlParser = [[NSXMLParser alloc] initWithData: dataString];
        self.xmlParser.delegate = self;
        [self.xmlParser setShouldResolveExternalEntities: YES];
        [self.xmlParser parse];
    }else{
        NSString * str = [ConnectionAPI readXMLStringWithFileName:@"areas"];
        NSData * dataString = [str dataUsingEncoding:NSUTF8StringEncoding ];
        self.xmlParser = [[NSXMLParser alloc] initWithData: dataString];
        self.xmlParser.delegate = self;
        [self.xmlParser setShouldResolveExternalEntities: YES];
        [self.xmlParser parse];
    }
    
}

- (void)getZipCode{
    NSLog(@"getZipCodeInfo");
    searchState = GETZIPCODE;
    if (stringToInt) {
        //searchState = FINDZIPCODE;
        // 使用NSXMLParser解析出我们想要的结果
        NSString * str = [ConnectionAPI readXMLStringWithFileName:@"zipcode"];
        NSData * dataString = [str dataUsingEncoding:NSUTF8StringEncoding ];
        self.xmlParser = [[NSXMLParser alloc] initWithData: dataString];
        self.xmlParser.delegate = self;
        [self.xmlParser setShouldResolveExternalEntities: YES];
        [self.xmlParser parse];
    }else{
        NSString * str = [ConnectionAPI readXMLStringWithFileName:@"zipcode"];
        NSData * dataString = [str dataUsingEncoding:NSUTF8StringEncoding ];
        self.xmlParser = [[NSXMLParser alloc] initWithData: dataString];
        self.xmlParser.delegate = self;
        [self.xmlParser setShouldResolveExternalEntities: YES];
        [self.xmlParser parse];
    }
}

#pragma mark XML Parser Delegate Methods

// 开始解析一个元素名
-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
    //节点名称是否匹配
    if ([elementName isEqual:_matchingElement]) {
        //获取数据
        
        
        //通过地名查找邮政编码
        if (stringToInt) {
            NSString * str ;
            NSString * string;
            
            switch (searchState) {
                case 1:    //查找省份ID
                {//找到对应省份名称
                    str = [districtArray objectAtIndex:0];
                    string =[NSString stringWithFormat:@"%@省",str];
                    if([[attributeDict objectForKey:@"province"]isEqual:string]){
                        provinceid = [[attributeDict objectForKey:@"provinceid"]intValue];
                        NSLog(@"provinceid  %d",provinceid);
                    }
                    break;
                }
                case 2:    //查找城市ID
                {   //找到对应城市名称
                    str = [districtArray objectAtIndex:1];
                    string =[NSString stringWithFormat:@"%@市",str];
                    if([[attributeDict objectForKey:@"city"]isEqual:string]){
                        cityid = [[attributeDict objectForKey:@"cityid"]intValue];
                        NSLog(@"cityid  %d",cityid);
                    }
                    break;
                }
                case 3:    //查找区县ID
                {   //找到对应区县名称
                    str = [districtArray objectAtIndex:2];
                    string =[NSString stringWithFormat:@"%@",str];
                    if([[attributeDict objectForKey:@"area"]isEqual:string]){
                        areaid = [[attributeDict objectForKey:@"areaid"]intValue];
                        NSLog(@"areaid  %d",areaid);
                    }
                    break;
                }
                case 4:    //查找邮政编码
                {   //找到对应区县名称
                    if([[attributeDict objectForKey:@"areaid"]intValue ] == areaid){
                        zipcode = [[attributeDict objectForKey:@"zip"]intValue];
                        NSLog(@"zipcode  %d",zipcode);
                    }
                    break;
                }
                case 11:    //获取省份名称
                {   //省份名称做key    省份ID做value
                    NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:[attributeDict objectForKey:@"provinceid"],[attributeDict objectForKey:@"province"], nil];
                    [provinceArray addObject:dic];
//                    NSLog(@"province : %@",[attributeDict objectForKey:@"province"] );
                    break;
                }
                case 12:    //获取城市名称
                {   //通过选定的省份id获取市的名称   并且市名称做key    市ID做value
                    if([[attributeDict objectForKey:@"provinceid"]intValue] == provinceid){
                        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:[attributeDict objectForKey:@"cityid"],[attributeDict objectForKey:@"city"], nil];
                        [cityArray addObject:dic];
//                        NSLog(@"city:  %@",[attributeDict objectForKey:@"city"]);
                    }
                    break;
                }
                case 13:    //获取地区名称
                {   //通过选定的市id获取地区的名称   并且地区名称做key    地区ID做value
                    if([[attributeDict objectForKey:@"cityid"]intValue] == cityid){
                        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:[attributeDict objectForKey:@"areaid"],[attributeDict objectForKey:@"area"], nil];
                        [areaArray addObject:dic];
//                        NSLog(@"area:  %@",[attributeDict objectForKey:@"area"]);
                    }
                    break;
                }
                case 14:    //获取邮政编码
                {   //通过选定的地区id获取邮政编码
                    if([[attributeDict objectForKey:@"areaid"]intValue] == areaid){
                        zipcode = [[attributeDict objectForKey:@"zip"]intValue];
                        NSLog(@"zip:  %@",[attributeDict objectForKey:@"zip"]);
                        
                    }
                    break;
                }
                default:
                    break;
            }
        }
        else{
        switch (searchState) {
        case 11:    //获取省份名称
            {   //省份名称做key    省份ID做value
                if([[attributeDict objectForKey:@"provinceid"]intValue] == provinceid){
                    [districtArray addObject: [attributeDict objectForKey:@"province"]];
                    NSLog(@"provinceid:  %d  %@",provinceid,[attributeDict objectForKey:@"province"]);
                    
                    //显示
                    [self displayTheDistrict];
                }
                break;
            }
        case 12:    //获取城市名称
            {   //通过选定的省份id获取市的名称   并且市名称做key    市ID做value
                if([[attributeDict objectForKey:@"cityid"]intValue] == cityid){
                    provinceid = [[attributeDict objectForKey:@"provinceid"]intValue];
                    [districtArray addObject: [attributeDict objectForKey:@"city"]];
                    NSLog(@"provinceid:  %d  %@",cityid,[attributeDict objectForKey:@"city"]);
                }
                break;
            }
        case 13:    //获取地区名称
            {   //通过选定的市id获取地区的名称   并且地区名称做key    地区ID做value
                if([[attributeDict objectForKey:@"areaid"]intValue] == areaid){
                    cityid = [[attributeDict objectForKey:@"cityid"]intValue];
                                           // NSLog(@"cityid:  %d",cityid);
                    [districtArray addObject: [attributeDict objectForKey:@"area"]];
                    NSLog(@"provinceid:  %d  %@",areaid,[attributeDict objectForKey:@"area"]);
                }
                break;
            }
        case 14:    //获取邮政编码
            {   //通过选定的地区id获取邮政编码
                if([[attributeDict objectForKey:@"zip"]intValue] == zipcode){
                    areaid = [[attributeDict objectForKey:@"areaid"]intValue];
                    NSLog(@"areaid:  %d",areaid);
                }
                break;
            }
        default:
            break;
        }
        }
    }
}

// 追加找到的元素值，一个元素值可能要分几次追加
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string {
    
}

// 结束解析这个元素名
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    _elementFound = FALSE;
    // 强制放弃解析
    
    _soapResults = nil;
    //}
}

// 解析整个文件结束后
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (_soapResults) {
        _soapResults = nil;
    }
    if (stringToInt) {
        switch (searchState) {
            case 11:
                _dataList = [NSMutableArray arrayWithArray:provinceArray];
                //NSLog(@"11tableTransform");
                [_tableView reloadData];
                [self showTableView];
                break;
            case 12:
                _dataList = [NSMutableArray arrayWithArray:cityArray];
                [self tableTransform];
                break;
            case 13:
                _dataList = [NSMutableArray arrayWithArray:areaArray];
                [self tableTransform];
                break;
            default:
                break;
        }
    }else{
        switch (searchState) {
            case 11:
                NSLog(@"finish");
                break;
            case 12:
                [NSThread detachNewThreadSelector:@selector(getProvinceName) toTarget:self withObject:nil];
                break;
            case 13:
                [NSThread detachNewThreadSelector:@selector(getCityName) toTarget:self withObject:nil];
                break;
            case 14:
                [NSThread detachNewThreadSelector:@selector(getAreaName) toTarget:self withObject:nil];
                break;
            default:
                break;
                
        }
    }
    
}

// 出错时，例如强制结束解析
- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    
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
        _tableView.center = CGPointMake(self.view.center.x, -_tableView.frame.size.height);
    }completion:^(BOOL finished){
        [self.view sendSubviewToBack:blackView];
        _tableView.center = CGPointMake(self.view.center.x, UISCREENHEIGHT + _tableView.frame.size.height);
        
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
