//
//  BaiduMapSearch.m
//  PostalManageSystem
//
//  Created by ZengYifei on 15/9/13.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "BaiduMapSearch.h"

@interface BaiduMapSearch ()<BMKMapViewDelegate,BMKLocationServiceDelegate>{
    AppDelegate *app;
}
@property (strong,nonatomic) BMKLocationService* locService;
@property (strong,nonatomic) BMKMapView* mapView;

@property (strong,nonatomic) UILabel * titleLabel;
@property (strong,nonatomic) UIButton * locationBtn;
@property (strong,nonatomic) UIButton * searchBtn;
@property (strong,nonatomic) UIButton * zoomInBtn;  //+
@property (strong,nonatomic) UIButton * zoomOutBtn; //-

@end

@implementation BaiduMapSearch
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        
        UILabel * locationSearchLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH - 100, UISCREENHEIGHT - 60, 90, 44)];
        locationSearchLabel.backgroundColor = [UIColor whiteColor];
        
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_locationBtn setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
        _locationBtn.frame = CGRectMake(UISCREENWIDTH - 100, UISCREENHEIGHT - 60, 30, 30);
        [_locationBtn addTarget:self action:@selector(location) forControlEvents:UIControlEventTouchUpInside];
        [_locationBtn.layer setMasksToBounds:YES];
        [_locationBtn.layer setCornerRadius:0.0]; //设置矩形四个圆角半径
        [_locationBtn.layer setBorderWidth:1.0];   //边框宽度
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0/255.0, 0/255.0, 0/255.0, 1 });
        [_locationBtn.layer setBorderColor:colorref];//边框颜色
        _locationBtn.backgroundColor = [UIColor whiteColor];
        _locationBtn.alpha = 0.9;
        [self.view addSubview:_locationBtn];
        
//        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_searchBtn setImage:[UIImage imageNamed:@"chazhao"] forState:UIControlStateNormal];
//        _searchBtn.frame = CGRectMake(57, 11, 33, 33);
//        [_searchBtn addTarget:self action:@selector(location) forControlEvents:UIControlEventTouchUpInside];
//        [locationSearchLabel addSubview:_searchBtn];
        
//        [self.view addSubview:locationSearchLabel];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //获取单例
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //设置导航栏label
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    _titleLabel.textColor = [UIColor yellowColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = app.titleForCurrentPage;
    self.navigationItem.titleView = _titleLabel;
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, NAVIGATIONHEIGHT, UISCREENWIDTH, UISCREENHEIGHT - NAVIGATIONHEIGHT)];
    [self.view addSubview: _mapView];
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];

}

- (void)location{
    NSLog(@"location");
    [_locService startUserLocationService];
}

#pragma -mark 处理位置信息更新
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    BMKCoordinateRegion region;
    region.center.latitude  = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta  = 0.2;
    region.span.longitudeDelta = 0.2;
    if (_mapView)
    {
        _mapView.region = region;
        NSLog(@"当前的坐标是: %f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        [_locService stopUserLocationService];
    }
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    _mapView.showsUserLocation = YES;//显示定位图层
    [_mapView updateLocationData:userLocation];
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}

- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}


@end
