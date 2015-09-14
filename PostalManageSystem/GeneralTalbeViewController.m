//
//  GeneralTalbeViewController.m
//  PostalManageSystem
//
//  Created by ZengYifei on 15/8/18.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "GeneralTalbeViewController.h"
#import "MYDDCBGViewController.h"
#import "GeneralTableViewCell.h"
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"
@interface GeneralTalbeViewController ()<DJRefreshDelegate>{
    AppDelegate *app;
    DJRefreshDirection directionForNow;
    BOOL isLoading;              //  加载状态
    int threadBackCount;
    BOOL shouldUpdateCacheForTitle;
    NSString * titleID;
    BOOL shouldUpdateCacheForPic;
}
@property (strong,nonatomic)UILabel * titleLabel;
@property (strong,nonatomic)UITableView * tableView;
@property (strong,nonatomic)NSMutableArray * dataList;
@property (strong,nonatomic)NSMutableArray * tempDataList;

@property (nonatomic,strong)DJRefresh *refresh;
@property (nonatomic,strong)NSMutableDictionary * cachaDic;
@end

@implementation GeneralTalbeViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = UIColorFromRGBValue(0xececec);
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    isLoading = NO;
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
    self.automaticallyAdjustsScrollViewInsets = NO;         //  解决视图偏移  默认YES  这样控制器可以自动调整  设置为NO后即可自己调整
    app.pager = [app.pager init];
    shouldUpdateCacheForTitle = NO;
    shouldUpdateCacheForPic =NO;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getNewsByType:) name:@"getNewsByType" object:nil];
    //读取缓存数据
    self.cachaDic = [ConnectionAPI readFileDic];
    if (self.cachaDic == nil) {
        self.cachaDic = [[NSMutableDictionary alloc]init];
    }
#warning 貌似不需要interface这个参数
    NSString * interface = [app.interfaceTransform objectForKey:app.titleForCurrentPage];
    if ([[self.cachaDic objectForKey:[NSString stringWithFormat:@"%@%@",interface,app.titleForCurrentPage]] isKindOfClass:[NSMutableDictionary class]]) {
        self.dataList = [[self.cachaDic objectForKey:[NSString stringWithFormat:@"%@%@",interface,app.titleForCurrentPage]]objectForKey:@"data"];
        //如果读取的数据大于每页请求数
        while (self.dataList.count >NUMBEROFTITLEFORPAGE) {
            [self.dataList removeLastObject];
        }
    }else self.dataList = [[NSMutableArray alloc]init];
    
    self.tempDataList = [[NSMutableArray alloc]init];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATIONHEIGHT , UISCREENWIDTH, UISCREENHEIGHT - NAVIGATIONHEIGHT)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    
    _refresh=[[DJRefresh alloc] initWithScrollView:self.tableView delegate:self];
    _refresh.topEnabled=YES;
    _refresh.bottomEnabled=YES;
    
    if (_type==eRefreshTypeProgress) {
        [_refresh registerClassForTopView:[DJRefreshProgressView class]];
    }
    [_refresh startRefreshingDirection:DJRefreshDirectionTop animation:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.titleLabel.text = app.titleForCurrentPage;
}

//服务器返回
- (void)getNewsByType:(NSNotification *)note{
    NSDictionary * noteDic = [note userInfo];
    //将要用的属性更新
    app.pager.currentPage = [[[noteDic objectForKey:@"listPager"]objectForKey:@"currentPage"]intValue];
    app.pager.totalPages = [[[noteDic objectForKey:@"listPager"]objectForKey:@"totalPages"]intValue];
    NSString * getNewsByType = [noteDic objectForKey:@"result"];
    //验证返回是否正确
    if ([getNewsByType isEqualToString:@"1"]) {
        [self.tempDataList removeAllObjects];
        self.tempDataList = [noteDic objectForKey:@"data"];
    }else if ([getNewsByType isEqualToString:@"1"]){
        UIAlertView * alerts = [[UIAlertView alloc]initWithTitle:@"获取列表失败" message:@"请检查网络后重试！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alerts show];
    }
    //通过md5值判断缓存是否需要更新
#warning 貌似不需要interface这个参数
    NSString * interface = [app.interfaceTransform objectForKey:app.titleForCurrentPage];
    NSString * serverMD5 = [ConnectionAPI md5:[NSString stringWithFormat:@"%@",noteDic]];
    NSString * cacheMD5 = [ConnectionAPI md5:[NSString stringWithFormat:@"%@",[self.cachaDic objectForKey:[NSString stringWithFormat:@"%@%@",interface,app.titleForCurrentPage]]]];
    if(shouldUpdateCacheForTitle && ![serverMD5 isEqualToString:cacheMD5]){
        [self.cachaDic setObject:noteDic forKey:[NSString stringWithFormat:@"%@%@",interface,app.titleForCurrentPage]];
        [NSThread detachNewThreadSelector:@selector(writeFileDic:) toTarget:self withObject:self.cachaDic];
        shouldUpdateCacheForTitle = NO;
        NSLog(@"Title缓存已更新");
    }
    
    int threadCount = 0;
    threadBackCount = 0;
    for (id obj in self.tempDataList) {     //计算出有多少条新闻有图片
        if ([obj isKindOfClass:[NSDictionary class]]
            && [[(NSDictionary * )obj objectForKey:@"imageUrl"]isKindOfClass:[NSString class]]
            && [(NSString *)[(NSDictionary * )obj objectForKey:@"imageUrl"] length]!=0) {
            threadCount ++;
        }
    }
    
    for (id obj in self.tempDataList) {     //加载新闻图片
        if ([obj isKindOfClass:[NSDictionary class]]
            && [[(NSDictionary * )obj objectForKey:@"imageUrl"]isKindOfClass:[NSString class]]
            && [(NSString *)[(NSDictionary * )obj objectForKey:@"imageUrl"] length]!=0) {
            NSString * url = [(NSDictionary * )obj objectForKey:@"imageUrl"];
            NSLog(@"线程%d已抛出",threadCount);
            NSString * threadCountString = [NSString stringWithFormat:@"%d",threadCount];
            NSMutableArray * tempArrays = [[NSMutableArray alloc]initWithObjects:url,threadCountString, nil];
            [NSThread detachNewThreadSelector:@selector(loadData:) toTarget:self withObject:tempArrays];
        }
    }
    isLoading = NO;
}

- (void) loadData:(NSMutableArray *) tempArrays
{
    NSString * url = (NSString*)[tempArrays objectAtIndex:0];
    if ([self.cachaDic objectForKey:url]==NULL) {
        NSData* imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:url]];
        UIImage* image = [[UIImage alloc] initWithData:imageData];
        UIImageView * ImgView = [[UIImageView alloc]initWithImage:image];
        NSLog(@"图片已下载");
        if ([ImgView respondsToSelector:@selector(setFrame:)]  && [image respondsToSelector:@selector(imageOrientation)]) {
            [self.cachaDic setObject:ImgView forKey:url];
            shouldUpdateCacheForPic =YES;
            NSLog(@"图片已加入字典");
        }
    }
    threadBackCount ++;
    //所有进程都已返回
    if (threadBackCount == [(NSString *)[tempArrays objectAtIndex:1]intValue]) {
        NSLog(@"threadBackCount:%d",threadBackCount);
        if (shouldUpdateCacheForPic) {
            [NSThread detachNewThreadSelector:@selector(writeFileDic:) toTarget:self withObject:self.cachaDic];
            shouldUpdateCacheForPic = NO;
        }
        if(self.refresh.refreshingDirection==DJRefreshingDirectionTop){
            [self.dataList removeAllObjects];
        }
        for (id dic in self.tempDataList) {
            [self.dataList addObject:dic];
        }
        
        [self addDataWithDirection:directionForNow];
    }
}

//网络请求
- (void)getDataFromServerForGeneralTableView{
    if (isLoading == NO) {
        isLoading = YES;
        if ([app.titleForCurrentPage isEqualToString:@"满意度调查结果通告"]) {
            [app.network getListWithToken:@"jiou" AndType:@"myddc" AndListPager:app.pager];
        }else if([app.titleForCurrentPage isEqualToString:@"信息公告"]){
            [app.network getListWithToken:@"jiou" AndType:@"xxgg" AndListPager:app.pager];
        }else if([app.titleForCurrentPage isEqualToString:@"行业统计"]){
            [app.network getListWithToken:@"jiou" AndType:@"hytj" AndListPager:app.pager];
        }else if([app.titleForCurrentPage isEqualToString:@"领导讲话"]){
            [app.network getListWithToken:@"jiou" AndType:@"ldjh" AndListPager:app.pager];
        }else if([app.titleForCurrentPage isEqualToString:@"行业动态"]){
            [app.network getListWithToken:@"jiou" AndType:@"hydt" AndListPager:app.pager];
        }else if([app.titleForCurrentPage isEqualToString:@"政策法规"]){
            [app.network getListWithToken:@"jiou" AndType:@"zcfg" AndListPager:app.pager];
        }
    }
}

#pragma mark - DJrefresh df
- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    directionForNow = direction;
    //isLoading = YES;
    //if ([app.titleForCurrentPage isEqualToString:@"满意度调查结果通告"]) {
        if (self.refresh.refreshingDirection==DJRefreshingDirectionBottom){
            if (app.pager.currentPage < app.pager.totalPages) {
                //数据返回太快   影响动画效果  顾延迟请求
                [NSTimer scheduledTimerWithTimeInterval:0.4 target: self selector: @selector(getDataFromServerForGeneralTableView) userInfo:nil repeats:NO];
                app.pager.currentPage ++;
            }else{
                UIAlertView * alerts = [[UIAlertView alloc]initWithTitle:nil message:@"所有信息已加载完毕！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alerts show];
                [self addDataWithDirection:directionForNow];
            }
        }else if(self.refresh.refreshingDirection==DJRefreshingDirectionTop){
            app.pager = [app.pager init];
            //下拉更新时将第一页数据缓存
            shouldUpdateCacheForTitle = YES;
            //数据返回太快   影响动画效果  顾延迟请求
            [NSTimer scheduledTimerWithTimeInterval:0.4 target: self selector: @selector(getDataFromServerForGeneralTableView) userInfo:nil repeats:NO];
            
        }
   // }
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    [self.tableView reloadData];
    [_refresh finishRefreshingDirection:direction animation:YES];
    isLoading =NO;
}


#pragma mark - tableView delegate&dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GeneralTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell == nil) {
        cell = [[GeneralTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    //无图片布局
    if([[[self.dataList objectAtIndex:indexPath.row]objectForKey:@"imageUrl"] isKindOfClass:[NSString class]]
       && [(NSString *)[[self.dataList objectAtIndex:indexPath.row]objectForKey:@"imageUrl"] length]==0){
        cell.titleLabel.text = [[self.dataList objectAtIndex:indexPath.row]objectForKey:@"title"];
        cell.writerLabel.text = [[self.dataList objectAtIndex:indexPath.row]objectForKey:@"author"];
        NSString * pubTime = [[[self.dataList objectAtIndex:indexPath.row]objectForKey:@"pubTime"]substringWithRange:NSMakeRange(0,10)];
        pubTime = [NSString stringWithFormat:@"发布时间:%@",pubTime];
        cell.timeLabel.text = pubTime;
    }
    //有图片布局
    else{
        [cell addPicLayout];
        cell.titleLabel.text = [[self.dataList objectAtIndex:indexPath.row]objectForKey:@"title"];
        cell.writerLabel.text = [[self.dataList objectAtIndex:indexPath.row]objectForKey:@"author"];
        NSString * pubTime = [[[self.dataList objectAtIndex:indexPath.row]objectForKey:@"pubTime"]substringWithRange:NSMakeRange(0,10)];
        pubTime = [NSString stringWithFormat:@"发布时间:%@",pubTime];
        cell.timeLabel.text = pubTime;
        UIImageView * temp = (UIImageView *)[self.cachaDic objectForKey:[[self.dataList objectAtIndex:indexPath.row]objectForKey:@"imageUrl"]];
        cell.picImageView.image = temp.image;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    if (isLoading == NO) {
        titleID = [[self.dataList objectAtIndex:indexPath.row]objectForKey:@"id"];
        [GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];
        [app.network getDetailViewWithToken:@"jiou" AndID:titleID];
        MYDDCBGViewController * myddcbg = [[MYDDCBGViewController alloc]init];
        [self.navigationController pushViewController:myddcbg animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

#pragma mark - 写入缓存
- (void)writeFileDic:(NSMutableDictionary *)dic{
    //写入对应位置
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:@"cacheDic.archiver"];//拓展名可以自己随便取
    
    BOOL writeResult =[NSKeyedArchiver archiveRootObject:dic toFile:path];
    NSLog(@"%@",writeResult ? @"写入缓存成功table":@"写入缓存失败table");
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
