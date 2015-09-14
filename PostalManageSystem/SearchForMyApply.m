//
//  SearchForMyApply.m
//  PostalManageSystem
//
//  Created by ZengYifei on 15/9/14.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "SearchForMyApply.h"
#import "CustomTableViewCell.h"
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"
#define tableViewCellHeight 35
#define selectedfont 14
#define defualtFont 17
@interface SearchForMyApply()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,DJRefreshDelegate>{
    AppDelegate *app;
    UISegmentedControl *segmentControl;
    UIView * allApplySearch;
    UIView * myApplySearch;
    BOOL isLoading;              //  加载状态
    int selectedTextFieldTag;
    int textFieldHeight;
    NSMutableDictionary * tableViewCacheDictionary;
    BOOL isInitState;
    NSString * segmentStateString;
    DJRefreshDirection directionForNow;
    NSDictionary * interfaceTransform;
    UIAlertView * alerts;
    //搜索的选项是否发生改变  yes为改变了   no为没改变   点击一次didselect设置为yes   点击一次submit设置为no
    BOOL searchStateChange;
}
@property (strong,nonatomic) UILabel * titleLabel;
@property (strong,nonatomic) UITableView * selectedTable;
@property (strong,nonatomic) NSMutableArray * dataList;
@property (strong,nonatomic) NSMutableArray * tempList;
@property (strong,nonatomic) UIView * blackView;
@property (strong,nonatomic) UITableView * tableViewForDisplay;
@property (strong,nonatomic) NSMutableArray * dataListForDisplay;
@property (strong,nonatomic) NSMutableDictionary * pagerDci;
@property (nonatomic,strong)DJRefresh *refresh;

@end
@implementation SearchForMyApply

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        interfaceTransform = [[NSDictionary alloc]initWithObjectsAndKeys:@"Szxwd",@"设置新网点",@"Cxpbfwwd",@"撤销普遍服务网点",@"Cxfpbfwwd",@"撤销非普遍服务网点",@"Baxxbg",@"备案信息变更",@"Jjqz",@"就近迁址",@"Txyw",@"停限业务",@"Ztxyw",@"暂停限业务",@"Hfyw",@"恢复业务",@"0",@"未审核",@"1",@"审核未上传照片",@"2",@"审核已上传照片",@"3",@"审核未通过", nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    //监听通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userList:) name:@"userList" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getApplyList:) name:@"getApplyList" object:nil];
    isInitState =YES;
    //获取单例  userList
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    //设置导航栏label
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.textColor = [UIColor yellowColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = app.titleForCurrentPage;
    self.navigationItem.titleView = self.titleLabel;

    NSArray *array=@[@"全部申请查询",@"我的申请查询"];
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
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 2/255.0, 142/255.0, 69/255.0, 1 });
    [segmentControl.layer setBorderColor:colorref];//边框颜色
    
    allApplySearch = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATIONHEIGHT + segmentControl.frame.size.height, UISCREENWIDTH, 150)];
    [self.view addSubview: allApplySearch];
    
    UILabel * placeNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, UISCREENWIDTH/4, 30)];
    placeNameLabel.text = @"场所名称:";
    placeNameLabel.font = [UIFont systemFontOfSize:defualtFont];
    placeNameLabel.textAlignment = NSTextAlignmentCenter;
    [allApplySearch addSubview:placeNameLabel];
    UITextField * placeNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(10 + UISCREENWIDTH/4, 5, UISCREENWIDTH*3/4-20, 30)];
    placeNameTextField.delegate = self;
    placeNameTextField.tag = 1;
    placeNameTextField.userInteractionEnabled = YES;
    placeNameTextField.font = [UIFont systemFontOfSize:defualtFont];
    [placeNameTextField setBorderStyle:UITextBorderStyleLine];
    placeNameTextField.returnKeyType = UIReturnKeyDone;
    [allApplySearch addSubview:placeNameTextField];
    
    UILabel * loginNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 , 10 + 30, UISCREENWIDTH/4, 30)];
    loginNameLabel.text = @"登录名:";
    loginNameLabel.font = [UIFont systemFontOfSize:defualtFont];
    loginNameLabel.textAlignment = NSTextAlignmentCenter;
    [allApplySearch addSubview:loginNameLabel];
    UITextField * loginNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(10 + UISCREENWIDTH/4, 10+ 30, UISCREENWIDTH*3/4-20, 30)];
    loginNameTextField.delegate = self;
    loginNameTextField.tag = 2;
    loginNameTextField.font = [UIFont systemFontOfSize:defualtFont];
    [loginNameTextField setBorderStyle:UITextBorderStyleLine];
    loginNameTextField.text = @"全部登录名";
    loginNameTextField.returnKeyType = UIReturnKeyDone;
    [allApplySearch addSubview:loginNameTextField];
    
    UILabel * serviceTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 , 15 + 60, UISCREENWIDTH/4, 30)];
    serviceTypeLabel.text = @"业务类型:";
    serviceTypeLabel.font = [UIFont systemFontOfSize:defualtFont];
    serviceTypeLabel.textAlignment = NSTextAlignmentCenter;
    [allApplySearch addSubview:serviceTypeLabel];
    UITextField * serviceTypeTextField = [[UITextField alloc]initWithFrame:CGRectMake(10 + UISCREENWIDTH/4, 15+ 60, UISCREENWIDTH*3/4-20, 30)];
    serviceTypeTextField.delegate = self;
    serviceTypeTextField.tag = 3;
    serviceTypeTextField.font = [UIFont systemFontOfSize:defualtFont];
    [serviceTypeTextField setBorderStyle:UITextBorderStyleLine];
    serviceTypeTextField.text = @"全部申请类型";
    serviceTypeTextField.returnKeyType = UIReturnKeyDone;
    [allApplySearch addSubview:serviceTypeTextField];
    
    UILabel * stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 , 20 + 90, UISCREENWIDTH/4, 30)];
    stateLabel.text = @"流程状态:";
    stateLabel.font = [UIFont systemFontOfSize:defualtFont];
    stateLabel.textAlignment = NSTextAlignmentCenter;
    [allApplySearch addSubview:stateLabel];
    UITextField * stateTextField = [[UITextField alloc]initWithFrame:CGRectMake(10 + UISCREENWIDTH/4, 20+ 90, UISCREENWIDTH*3/4-30 - UISCREENWIDTH/5, 30)];
    stateTextField.delegate = self;
    stateTextField.tag = 4;
    stateTextField.font = [UIFont systemFontOfSize:defualtFont];
    [stateTextField setBorderStyle:UITextBorderStyleLine];
    stateTextField.text = @"全部";
    stateTextField.returnKeyType = UIReturnKeyDone;
    [allApplySearch addSubview:stateTextField];
    
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitBtn.frame = CGRectMake(10 + stateTextField.frame.origin.x + stateTextField.frame.size.width, 20+ 90, UISCREENWIDTH/5, 30);
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.backgroundColor = UIColorFromRGBValue(0x028e45);
    [submitBtn setTitleColor:[UIColor yellowColor]forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [allApplySearch addSubview:submitBtn];
    
    //我的申请查询
    myApplySearch = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATIONHEIGHT + segmentControl.frame.size.height, UISCREENWIDTH, 120)];
    [self.view addSubview: myApplySearch];
    myApplySearch.hidden = YES;
    
    UILabel * placeNameLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, UISCREENWIDTH/4, 30)];
    placeNameLabel2.text = @"场所名称:";
    placeNameLabel2.font = [UIFont systemFontOfSize:defualtFont];
    placeNameLabel2.textAlignment = NSTextAlignmentCenter;
    [myApplySearch addSubview:placeNameLabel2];
    UITextField * placeNameTextField2 = [[UITextField alloc]initWithFrame:CGRectMake(10 + UISCREENWIDTH/4, 5, UISCREENWIDTH*3/4-20, 30)];
    placeNameTextField2.delegate = self;
    placeNameTextField2.tag = 5;
    placeNameTextField2.font = [UIFont systemFontOfSize:defualtFont];
    [placeNameTextField2 setBorderStyle:UITextBorderStyleLine];
    placeNameTextField2.returnKeyType = UIReturnKeyDone;
    [myApplySearch addSubview:placeNameTextField2];

    UILabel * serviceTypeLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(10 , 10 + 30, UISCREENWIDTH/4, 30)];
    serviceTypeLabel2.text = @"业务类型:";
    serviceTypeLabel2.font = [UIFont systemFontOfSize:defualtFont];
    serviceTypeLabel2.textAlignment = NSTextAlignmentCenter;
    [myApplySearch addSubview:serviceTypeLabel2];
    UITextField * serviceTypeTextField2 = [[UITextField alloc]initWithFrame:CGRectMake(10 + UISCREENWIDTH/4, 10+ 30, UISCREENWIDTH*3/4-20, 30)];
    serviceTypeTextField2.delegate = self;
    serviceTypeTextField2.tag = 6;
    serviceTypeTextField2.font = [UIFont systemFontOfSize:defualtFont];
    [serviceTypeTextField2 setBorderStyle:UITextBorderStyleLine];
    serviceTypeTextField2.text = @"请选择";
    serviceTypeTextField2.returnKeyType = UIReturnKeyDone;
    [myApplySearch addSubview:serviceTypeTextField2];
    
    UILabel * stateLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(10 , 15 + 60, UISCREENWIDTH/4, 30)];
    stateLabel2.text = @"流程状态:";
    stateLabel2.font = [UIFont systemFontOfSize:defualtFont];
    stateLabel2.textAlignment = NSTextAlignmentCenter;
    [myApplySearch addSubview:stateLabel2];
    UITextField * stateTextField2 = [[UITextField alloc]initWithFrame:CGRectMake(10 + UISCREENWIDTH/4, 15+ 60, UISCREENWIDTH*3/4-30 - UISCREENWIDTH/5, 30)];
    stateTextField2.delegate = self;
    stateTextField2.tag = 7;
    stateTextField2.font = [UIFont systemFontOfSize:defualtFont];
    [stateTextField2 setBorderStyle:UITextBorderStyleLine];
    stateTextField2.text = @"请选择";
    stateTextField2.returnKeyType = UIReturnKeyDone;
    [myApplySearch addSubview:stateTextField2];
    
    UIButton * submitBtn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitBtn2.frame = CGRectMake(10 + stateTextField.frame.origin.x + stateTextField.frame.size.width, 15+ 60, UISCREENWIDTH/5, 30);
    [submitBtn2 setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn2.backgroundColor = UIColorFromRGBValue(0x028e45);
    [submitBtn2 setTitleColor:[UIColor yellowColor]forState:UIControlStateNormal];
    [submitBtn2 addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [myApplySearch addSubview:submitBtn2];
    
    _tempList = [[NSMutableArray alloc]init];
    _dataList = [[NSMutableArray alloc]init];
    _pagerDci = [[NSMutableDictionary alloc]init];
    _selectedTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) ];
    _selectedTable.center = self.view.center;
    _selectedTable.delegate = self;
    _selectedTable.dataSource = self;
    
    tableViewCacheDictionary = [[NSMutableDictionary alloc]init];
    
    self.blackView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.blackView.backgroundColor = [UIColor blackColor];
    self.blackView.alpha = 0.0;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelView)];
    [self.blackView addGestureRecognizer:recognizer];

    _dataListForDisplay = [[NSMutableArray alloc]init];//WithObjects:@"1",@"2", nil];
    _tableViewForDisplay = [[UITableView alloc]initWithFrame:CGRectMake(0, allApplySearch.frame.origin.y +allApplySearch.frame.size.height  , UISCREENWIDTH, UISCREENHEIGHT - NAVIGATIONHEIGHT - segmentControl.frame.size.height -allApplySearch.frame.size.height) ];
    _tableViewForDisplay.delegate = self;
    _tableViewForDisplay.dataSource = self;
    [self.view addSubview:_tableViewForDisplay];
    
    app.pager = [app.pager init];

    _refresh=[[DJRefresh alloc] initWithScrollView:_tableViewForDisplay delegate:self];
    _refresh.topEnabled=YES;
    _refresh.bottomEnabled=YES;
    
    if (_type==eRefreshTypeProgress) {
        [_refresh registerClassForTopView:[DJRefreshProgressView class]];
    }
}


-(void)cancelView
{
    [UIView animateWithDuration:0.3 animations:^{
        _blackView.alpha = 0.0;
        [_selectedTable removeFromSuperview];
        [_blackView removeFromSuperview];
    }];
    [tableViewCacheDictionary setObject:_selectedTable forKey:[NSString stringWithFormat:@"%ld",(long)selectedTextFieldTag]];
    
}

-(void)change{
    [(UITextField *)[self.view viewWithTag:1] resignFirstResponder];
    if (segmentControl.selectedSegmentIndex == 0) {
        allApplySearch.hidden = NO;
        myApplySearch.hidden = YES;
        _tableViewForDisplay.frame = CGRectMake(0, allApplySearch.frame.origin.y +allApplySearch.frame.size.height  , UISCREENWIDTH, UISCREENHEIGHT - NAVIGATIONHEIGHT - segmentControl.frame.size.height -allApplySearch.frame.size.height);

    }else{
        allApplySearch.hidden = YES;
        myApplySearch.hidden = NO;
        _tableViewForDisplay.frame = CGRectMake(0, myApplySearch.frame.origin.y +myApplySearch.frame.size.height  , UISCREENWIDTH, UISCREENHEIGHT - NAVIGATIONHEIGHT - segmentControl.frame.size.height -myApplySearch.frame.size.height) ;
    }
}

- (void)submit{
    searchStateChange = NO;
    [_refresh startRefreshingDirection:DJRefreshDirectionTop animation:YES];
    if (segmentControl.selectedSegmentIndex == 0) {
        segmentStateString = [NSString stringWithFormat:@"0"];
//         UITextField * placeText = (UITextField *)[self.view viewWithTag:1];
//        UITextField * loginNameText = (UITextField *)[self.view viewWithTag:2];
//        NSString * loginName = loginNameText.text;
//        if ([loginName rangeOfString:@"全部"].length != 0) {
//            loginName = @"";
//        }
//        UITextField * typeNameText = (UITextField *)[self.view viewWithTag:3];
//        NSString * typeName = typeNameText.text;
//        if ([typeName rangeOfString:@"全部"].length != 0) {
//            typeName = @"";
//        }
//        UITextField * stateNameText = (UITextField *)[self.view viewWithTag:4];
//        NSString * stateName = stateNameText.text;
//        if ([stateName rangeOfString:@"全部"].length != 0) {
//            stateName = @"";
//        }
//        Pager * pager = [[Pager alloc]init];
//        [app.network getAllApplyListWithToken:@"jiou" AndType:typeName AndUserName:loginName AndPlaceName:placeText.text AndState:stateName AndPager:pager];
    }else{
        segmentStateString = [NSString stringWithFormat:@"1"];    }
}

//网络请求
- (void)getDataFromServerForSearchMyApply{
    if (isLoading == NO) {
        isLoading = YES;
        if (segmentControl.selectedSegmentIndex == 0) {
            segmentStateString = [NSString stringWithFormat:@"0"];
            UITextField * placeText = (UITextField *)[self.view viewWithTag:1];
            UITextField * loginNameText = (UITextField *)[self.view viewWithTag:2];
            NSString * loginName = loginNameText.text;
            if ([loginName rangeOfString:@"全部"].length != 0) {
                loginName = @"";
            }
            UITextField * typeNameText = (UITextField *)[self.view viewWithTag:3];
            NSString * typeName = typeNameText.text;
            if ([typeName rangeOfString:@"全部"].length != 0) {
                typeName = @"";
            }else{
                typeName = [interfaceTransform objectForKey:typeName];
            }
            
            UITextField * stateNameText = (UITextField *)[self.view viewWithTag:4];
            NSString * stateName = stateNameText.text;
            if ([stateName rangeOfString:@"全部"].length != 0) {
                stateName = @"";
            }else{
                stateName = [interfaceTransform objectForKey:stateName];
            }
            [app.network getAllApplyListWithToken:@"jiou" AndType:typeName AndUserName:loginName AndPlaceName:placeText.text AndState:stateName AndPager:app.pager];
        }
    }
}


#pragma  -mark 网络返回
- (void)userList:(NSNotification *)note{
    [GMDCircleLoader hideFromView:self.view animated:YES];
    NSDictionary * dic = [note userInfo];
    if ([[dic objectForKey:@"result"] isEqualToString:@"1"]) {
        NSArray * data = [dic objectForKey:@"data"];
        for (NSDictionary * dics in data) {
            [_tempList addObject: [dics objectForKey:@"userName"]];
        }
        [_tempList insertObject:@"全部登录名" atIndex:0];
    }
}

- (void)getApplyList:(NSNotification *)note{
    NSDictionary * dic = [note userInfo];
    if ([[dic objectForKey:@"result"] isEqualToString:@"1"]) {
        //填充对应页面下方list的页面信息
        [_pagerDci setObject:[dic objectForKey:@"listPager"] forKey:segmentStateString];
        app.pager.currentPage = [[[dic objectForKey:@"listPager"]objectForKey:@"currentPage"]intValue];
        app.pager.totalPages = [[[dic objectForKey:@"listPager"]objectForKey:@"totalPages"]intValue];
        NSArray * data = [dic objectForKey:@"list"];
        for (NSDictionary * dics in data) {
            [_dataListForDisplay addObject: dics];
        }
    }
     [self addDataWithDirection:directionForNow];
}



#pragma mark - DJrefresh df
- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    directionForNow = direction;
    //isLoading = YES;
    //if ([app.titleForCurrentPage isEqualToString:@"满意度调查结果通告"]) {
    if (searchStateChange) {
        [self submit];
        return;
    }
    
    if (self.refresh.refreshingDirection==DJRefreshingDirectionBottom){
        if (app.pager.currentPage < app.pager.totalPages) {
            //数据返回太快   影响动画效果  顾延迟请求
            [NSTimer scheduledTimerWithTimeInterval:0.4 target: self selector: @selector(getDataFromServerForSearchMyApply) userInfo:nil repeats:NO];
            app.pager.currentPage ++;
        }else{
            if (![alerts isVisible]) {
                alerts = [[UIAlertView alloc]initWithTitle:nil message:@"所有信息已加载完毕！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alerts show];
            }
            
            [self addDataWithDirection:directionForNow];
        }
    }else if(self.refresh.refreshingDirection==DJRefreshingDirectionTop){
        app.pager = [app.pager init];
        [_dataListForDisplay removeAllObjects];
        //下拉更新时将第一页数据缓存
//        shouldUpdateCacheForTitle = YES;
        //数据返回太快   影响动画效果  顾延迟请求
        [NSTimer scheduledTimerWithTimeInterval:0.4 target: self selector: @selector(getDataFromServerForSearchMyApply) userInfo:nil repeats:NO];
    }
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    [_tableViewForDisplay reloadData];
    [_refresh finishRefreshingDirection:direction animation:YES];
    isLoading =NO;
}

#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textFieldHeight = textField.frame.size.height + textField.frame.origin.y;
    switch (textField.tag) {
//        case 1:
//            self.dataList = [[NSMutableArray alloc]initWithObjects:@"设置邮政普遍服务营业场所",@"设置其他邮政营业场所", nil];
//            selectedTextFieldTag = 1;
//            [self showTableViewWith:textField];
//            return NO;
//            break;
        case 2:
//            self.dataList = [[NSMutableArray alloc]initWithObjects:@"自办",@"委办", nil];
            [(UITextField *)[self.view viewWithTag:1] resignFirstResponder];
            _dataList = _tempList;
            selectedTextFieldTag = 2;
            [self showTableViewWith:textField];
            return NO;
            break;
        case 3:
            [(UITextField *)[self.view viewWithTag:1] resignFirstResponder];
            _dataList = [[NSMutableArray alloc]initWithObjects:@"全部申请类型",@"设置新网点",@"撤销普遍服务网点",@"撤销非普遍服务网点",@"备案信息变更",@"就近迁址",@"停限业务",@"暂停限业务",@"恢复业务", nil];
            selectedTextFieldTag = 3;
            [self showTableViewWith:textField];
            return NO;
            break;
        case 4:
            [(UITextField *)[self.view viewWithTag:1] resignFirstResponder];
            _dataList = [[NSMutableArray alloc]initWithObjects:@"全部",@"未审核",@"审核未通过",@"已审核未上传照片",@"已审核以上传照片", nil];
            selectedTextFieldTag = 4;
            [self showTableViewWith:textField];
            return NO;
            break;
        case 5:
            [(UITextField *)[self.view viewWithTag:1] resignFirstResponder];
            selectedTextFieldTag = 5;
            return NO;
            break;
        case 6:
            [(UITextField *)[self.view viewWithTag:1] resignFirstResponder];
            self.dataList = [[NSMutableArray alloc]initWithObjects:@"有",@"无", nil];
            selectedTextFieldTag = 6;
            [self showTableViewWith:textField];
            return NO;
            break;
        case 7:
            [(UITextField *)[self.view viewWithTag:1] resignFirstResponder];
            self.dataList = [[NSMutableArray alloc]initWithObjects:@"信件",@"物流",@"集邮",@"包裹",@"印刷品",@"报刊零售",@"邮政储蓄",@"盲人读物",@"特快专递",@"报刊订阅",@"邮政汇兑",@"义务兵信函",@"烈士遗物包裹",@"其他", nil];
            selectedTextFieldTag = 7;
            [self showTableViewWith:textField];
            return NO;
            break;
        default:
            return YES;
            
            break;
    }
//    if (segmentControl.selectedSegmentIndex == 0) {
//        return NO;
//    }else{
        return YES;
//    }
}

// 一般用来隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (segmentControl.selectedSegmentIndex ==1) {
        
    }
    return YES;
}


#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _selectedTable) {
        return [_dataList count];
    }else{
        return [_dataListForDisplay count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _selectedTable) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" ];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = [self.dataList objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:selectedfont];
//        if (indexPath.row == 0  && isInitState) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        }
        return cell;
    }
    else{
        CustomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" ];
        if (cell == nil) {
            cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        }
        cell.placeNameLabel.text = [[_dataListForDisplay objectAtIndex:indexPath.row]objectForKey:@"wdxx"];
        cell.serviceTypeLabel.text = [[_dataListForDisplay objectAtIndex:indexPath.row]objectForKey:@"typeName"];
        
        NSMutableString * timeAndApllyPersonString = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"申请时间:%@",[[_dataListForDisplay objectAtIndex:indexPath.row]objectForKey:@"startTime"]]];
        [timeAndApllyPersonString setString:[timeAndApllyPersonString substringToIndex:15]];
        [timeAndApllyPersonString appendString:[NSString stringWithFormat:@"       申请人:%@",[[NSMutableString alloc]initWithString:[[_dataListForDisplay objectAtIndex:indexPath.row]objectForKey:@"applyUserName"]]]];
        cell.timeAndApllyPersonLabel.text = timeAndApllyPersonString;
        
        //    cell.accessoryType = UITableViewCellAccessoryCheckmark;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    searchStateChange = YES;
    if (tableView == _selectedTable) {
        UITextField * text = (UITextField *)[self.view viewWithTag:selectedTextFieldTag];
        text.text =  [self.dataList objectAtIndex:indexPath.row];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            for (int i = 0; i < self.dataList.count; i++) {
                NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:index];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [_selectedTable reloadData];
        }
        [self cancelView];
        [tableViewCacheDictionary setObject:tableView forKey:[NSString stringWithFormat:@"%ld",(long)selectedTextFieldTag]];
    }else{
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _selectedTable) {
        return tableViewCellHeight;
    }else{
        return 80;
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)showTableViewWith:(UITextField *) textField{
    if ([tableViewCacheDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)selectedTextFieldTag]] != NULL) {
        _selectedTable = [tableViewCacheDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)selectedTextFieldTag]];
        NSLog(@"buweikong");
    }else  {
        _selectedTable = [[UITableView alloc]init];
        _selectedTable.tag = 100+ selectedTextFieldTag;
        self.selectedTable.dataSource = self;
        self.selectedTable.delegate = self;
    }
    
    _selectedTable.frame = CGRectMake(textField.frame.origin.x, textField.frame.origin.y+NAVIGATIONHEIGHT + segmentControl.frame.size.height, textField.frame.size.width, tableViewCellHeight*self.dataList.count);
    if (_selectedTable.frame.size.height+ _selectedTable.frame.origin.y> UISCREENHEIGHT -20) {
        self.selectedTable.frame = CGRectMake(textField.frame.origin.x, textField.frame.origin.y+NAVIGATIONHEIGHT + segmentControl.frame.size.height, textField.frame.size.width, UISCREENHEIGHT -20 - (textField.frame.origin.y + NAVIGATIONHEIGHT + segmentControl.frame.size.height));
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self.view addSubview:_blackView];
        [self.view addSubview:_selectedTable];
        _blackView.alpha = 0.5;
    }];
    [tableViewCacheDictionary setObject:self.selectedTable forKey:[NSString stringWithFormat:@"%ld",(long)selectedTextFieldTag]];
}

#pragma mark - touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];   //scrollview捕获了touch事件
    UITouch *touch = [touches anyObject];
    if (touch.view != [self.view viewWithTag:1]) {
        [(UITextField *)[self.view viewWithTag:1] resignFirstResponder];
    }
    
}

@end
