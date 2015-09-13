//
//  ViewController.m
//  PostalManageSystem
//
//  Created by ZengYifei on 15/8/18.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "MainViewController.h"
#import "GeneralTalbeViewController.h"
#import "YZBMCXViewController.h"
#import "JXJWPMLCXViewController.h"
#import "BSDTViewController.h"
#import "BaiduMapSearch.h"
@interface MainViewController (){
    AppDelegate * app;
}
@property (strong,nonatomic)UILabel * titleLabel;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = UIColorFromRGBValue(0xececec);

        self.automaticallyAdjustsScrollViewInsets = NO;         //  解决视图偏移  默认YES  这样控制器可以自动调整  设置为NO后即可自己调整
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    //获取单例
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //设置导航栏label
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.textColor = [UIColor yellowColor];   //UIColorFromRGBValue(0xfbcf02);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = app.titleForCurrentPage;
    self.navigationItem.titleView = self.titleLabel;
    
    if ([app.titleForCurrentPage isEqualToString:@"邮政普遍服务信息管理系统"]) {
        [self initForMain];
    }else if ([app.titleForCurrentPage isEqualToString:@"便民服务"]){
        [self initForBMFW];
    }else if ([app.titleForCurrentPage isEqualToString:@"邮政资讯"]){
        [self initForYZZX];
    }
}

# pragma UI
//便民服务、邮政资讯、政策法规、办事大厅                       tag：1-4
//周边网点查询、满意度调查结果通告、邮政编码查询、禁限寄物品名录   tag：5-8
//信息公告、行业动态、领导讲话、行业统计                       tage:9-12
- (void)jumpPage:(UIButton *)btn{
    switch (btn.tag) {
        case 1:
        {
            app.titleForCurrentPage = @"便民服务";
            MainViewController * bmfwViewCotntroller = [[MainViewController alloc]init];
            [self.navigationController pushViewController:bmfwViewCotntroller animated:YES];
        }
            break;
        case 2:
        {
            app.titleForCurrentPage = @"邮政资讯";
            MainViewController * yzzxViewCotntroller = [[MainViewController alloc]init];
            [self.navigationController pushViewController:yzzxViewCotntroller animated:YES];
        }
            break;
        case 3:
        {
            app.titleForCurrentPage = @"政策法规";
            GeneralTalbeViewController * myddcjgggViewCotntroller = [[GeneralTalbeViewController alloc]init];
            [self.navigationController pushViewController:myddcjgggViewCotntroller animated:YES];
        }
            break;
        case 4:
        {
            app.titleForCurrentPage = @"办事大厅";
            BSDTViewController * bsdtViewCotntroller = [[BSDTViewController alloc]init];
            [self.navigationController pushViewController:bsdtViewCotntroller animated:YES];
        }
            break;case 5:
        {
            app.titleForCurrentPage = @"周边网点查询";
            BaiduMapSearch * mapCotntroller = [[BaiduMapSearch alloc]init];
            [self.navigationController pushViewController:mapCotntroller animated:YES];
        }
            break;
        case 6:
        {
            app.titleForCurrentPage = @"满意度调查结果通告";
            GeneralTalbeViewController * myddcjgggViewCotntroller = [[GeneralTalbeViewController alloc]init];
            [self.navigationController pushViewController:myddcjgggViewCotntroller animated:YES];
        }
            break;
        case 7:
        {
            app.titleForCurrentPage = @"邮政编码查询";
            YZBMCXViewController * yzbmcxViewCotntroller = [[YZBMCXViewController alloc]init];
            [self.navigationController pushViewController:yzbmcxViewCotntroller animated:YES];
        }
            break;
        case 8:
        {
            app.titleForCurrentPage = @"禁限寄物品名录";
            JXJWPMLCXViewController * jxjwpmlViewCotntroller = [[JXJWPMLCXViewController alloc]init];
            [self.navigationController pushViewController:jxjwpmlViewCotntroller animated:YES];
        }
            break;
        case 9:
        {
            app.titleForCurrentPage = @"信息公告";
            GeneralTalbeViewController * xxggViewCotntroller = [[GeneralTalbeViewController alloc]init];
            [self.navigationController pushViewController:xxggViewCotntroller animated:YES];
        }
            break;
        case 10:
        {
            app.titleForCurrentPage = @"行业动态";
            GeneralTalbeViewController * xxggViewCotntroller = [[GeneralTalbeViewController alloc]init];
            [self.navigationController pushViewController:xxggViewCotntroller animated:YES];
        }
            break;
        case 11:
        {
            app.titleForCurrentPage = @"领导讲话";
            GeneralTalbeViewController * xxggViewCotntroller = [[GeneralTalbeViewController alloc]init];
            [self.navigationController pushViewController:xxggViewCotntroller animated:YES];
        }
            break;
        case 12:
        {
            app.titleForCurrentPage = @"行业统计";
            GeneralTalbeViewController * xxggViewCotntroller = [[GeneralTalbeViewController alloc]init];
            [self.navigationController pushViewController:xxggViewCotntroller animated:YES];
        }
            break;
        default:
            break;
    }

}

- (void)initForYZZX{
    UIImage * img;
    self.view.backgroundColor = [UIColor grayColor];
    //信息公告
    UIButton * xxggBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    xxggBtn.frame = CGRectMake(0, NAVIGATIONHEIGHT, self.view.frame.size.width/2-1,(self.view.frame.size.height-NAVIGATIONHEIGHT)/2-1 );
    xxggBtn.backgroundColor = [UIColor whiteColor];
    xxggBtn.tag = 9;
    [xxggBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
    img = [UIImage imageNamed:@"xinxigonggao"];
//    
//    
//    CGFloat top = (xxggBtn.frame.size.height - UISCREENWIDTH/3*1.64*1.15)/2; // 顶端盖高度
//    
//    CGFloat bottom = (xxggBtn.frame.size.height - UISCREENWIDTH/3*1.64*1.15)/2 ; // 底端盖高度
//    
//    CGFloat left = UISCREENWIDTH/12; // 左端盖宽度
//    
//    CGFloat right = UISCREENWIDTH/12; // 右端盖宽度
//    
//    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
//    //img = [img stretchableImageWithLeftCapWidth:100 topCapHeight:100*1.64*1.95];
//    img = [img resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
//    
//    //    UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
//    
//    //    UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图片
//    
//    NSLog( @"%@   %@",NSStringFromCGRect(self.view.bounds) ,NSStringFromCGRect(xxggBtn.frame) );
    
    //[xxggBtn setBackgroundImage:img forState:UIControlStateNormal];
    [xxggBtn setImage:[UIImage imageNamed:@"xinxigonggao"] forState:UIControlStateNormal];
    [self.view addSubview:xxggBtn];
    
    //行业动态
    UIButton * hydtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hydtBtn.frame = CGRectMake(self.view.frame.size.width/2+1, NAVIGATIONHEIGHT, self.view.frame.size.width/2-1,(self.view.frame.size.height-NAVIGATIONHEIGHT)/2-1);
    hydtBtn.backgroundColor = [UIColor whiteColor];
    hydtBtn.tag = 10;
    [hydtBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
    [hydtBtn setBackgroundImage:[UIImage imageNamed:@"hangyedongtai"] forState:UIControlStateNormal];
    [self.view addSubview:hydtBtn];
    
    //领导讲话
    UIButton * ldjhBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ldjhBtn.frame = CGRectMake(0, (self.view.frame.size.height-NAVIGATIONHEIGHT)/2+1+NAVIGATIONHEIGHT, self.view.frame.size.width/2-1,(self.view.frame.size.height-NAVIGATIONHEIGHT)/2-1);
    ldjhBtn.backgroundColor = [UIColor whiteColor];
    ldjhBtn.tag = 11;
    [ldjhBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
    [ldjhBtn setBackgroundImage:[UIImage imageNamed:@"lingdaojianghua"] forState:UIControlStateNormal];
    [self.view addSubview:ldjhBtn];
    
    //行业统计
    UIButton * hytjBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hytjBtn.frame = CGRectMake(self.view.frame.size.width/2+1, (self.view.frame.size.height-NAVIGATIONHEIGHT)/2+1+NAVIGATIONHEIGHT, self.view.frame.size.width/2-1,(self.view.frame.size.height-NAVIGATIONHEIGHT)/2-1 );
    hytjBtn.backgroundColor = [UIColor whiteColor];
    hytjBtn.tag = 12;
    [hytjBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
    [hytjBtn setBackgroundImage:[UIImage imageNamed:@"hangyetongji"] forState:UIControlStateNormal];
    [self.view addSubview:hytjBtn];
    
}


- (void)initForBMFW{
    self.view.backgroundColor = [UIColor grayColor];
    //周边网点查询
    UIButton * zbwdcxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zbwdcxBtn.frame = CGRectMake(0, NAVIGATIONHEIGHT, self.view.frame.size.width/2-1,(self.view.frame.size.height-NAVIGATIONHEIGHT)/2-1 );
    zbwdcxBtn.backgroundColor = [UIColor whiteColor];
    zbwdcxBtn.tag = 5;
    [zbwdcxBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
    [zbwdcxBtn setBackgroundImage:[UIImage imageNamed:@"zhoubianwangdianchaxun"] forState:UIControlStateNormal];
    [self.view addSubview:zbwdcxBtn];
    
    //满意度调查结果通告
    UIButton * myddcjgtgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myddcjgtgBtn.frame = CGRectMake(self.view.frame.size.width/2+1, NAVIGATIONHEIGHT, self.view.frame.size.width/2-1,(self.view.frame.size.height-NAVIGATIONHEIGHT)/2-1);
    myddcjgtgBtn.backgroundColor = [UIColor whiteColor];
    myddcjgtgBtn.tag = 6;
    [myddcjgtgBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
    [myddcjgtgBtn setBackgroundImage:[UIImage imageNamed:@"manyidudiaochajieguotonggao"] forState:UIControlStateNormal];
    [self.view addSubview:myddcjgtgBtn];
    
    //邮政编码查询
    UIButton * yzbmcxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yzbmcxBtn.frame = CGRectMake(0, (self.view.frame.size.height-NAVIGATIONHEIGHT)/2+1+NAVIGATIONHEIGHT, self.view.frame.size.width/2-1,(self.view.frame.size.height-NAVIGATIONHEIGHT)/2-1);
    yzbmcxBtn.backgroundColor = [UIColor whiteColor];
    yzbmcxBtn.tag = 7;
    [yzbmcxBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
    [yzbmcxBtn setBackgroundImage:[UIImage imageNamed:@"youzhengbianmachaxun"] forState:UIControlStateNormal];
    [self.view addSubview:yzbmcxBtn];
    
    //禁限寄物品名录
    UIButton * jxjwpmlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jxjwpmlBtn.frame = CGRectMake(self.view.frame.size.width/2+1, (self.view.frame.size.height-NAVIGATIONHEIGHT)/2+1+NAVIGATIONHEIGHT, self.view.frame.size.width/2-1,(self.view.frame.size.height-NAVIGATIONHEIGHT)/2-1 );
    jxjwpmlBtn.backgroundColor = [UIColor whiteColor];
    jxjwpmlBtn.tag = 8;
    [jxjwpmlBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
    [jxjwpmlBtn setBackgroundImage:[UIImage imageNamed:@"jinjiwupinminglu"] forState:UIControlStateNormal];
    [self.view addSubview:jxjwpmlBtn];
}

- (void)initForMain{
    self.view.backgroundColor = [UIColor grayColor];
    //便民服务
    UIButton * bmfwBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bmfwBtn.frame = CGRectMake(0, NAVIGATIONHEIGHT, self.view.frame.size.width/2-1,(self.view.frame.size.height-NAVIGATIONHEIGHT)/2-1 );
    bmfwBtn.backgroundColor = [UIColor whiteColor];
    bmfwBtn.tag = 1;
    [bmfwBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
    //[bmfwBtn setBackgroundImage:[UIImage imageNamed:@"bianminfuwu"] forState:UIControlStateNormal];
    [bmfwBtn setImage:[UIImage imageNamed:@"bianminfuwu"] forState:UIControlStateNormal];
    [self.view addSubview:bmfwBtn];
    
    //邮政资讯
    UIButton * yzzxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yzzxBtn.frame = CGRectMake(self.view.frame.size.width/2+1, NAVIGATIONHEIGHT, self.view.frame.size.width/2-1,(self.view.frame.size.height-NAVIGATIONHEIGHT)/2-1);
    yzzxBtn.backgroundColor = [UIColor whiteColor];
    yzzxBtn.tag = 2;
    [yzzxBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
    [yzzxBtn setBackgroundImage:[UIImage imageNamed:@"youzhengzixun"] forState:UIControlStateNormal];
    [self.view addSubview:yzzxBtn];
    
    //政策法规
    UIButton * zcfgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zcfgBtn.frame = CGRectMake(0, (self.view.frame.size.height-NAVIGATIONHEIGHT)/2+1+NAVIGATIONHEIGHT, self.view.frame.size.width/2-1,(self.view.frame.size.height-NAVIGATIONHEIGHT)/2-1);
    zcfgBtn.backgroundColor = [UIColor whiteColor];
    zcfgBtn.tag = 3;
    [zcfgBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
    [zcfgBtn setBackgroundImage:[UIImage imageNamed:@"zhengcefagui"] forState:UIControlStateNormal];
    [self.view addSubview:zcfgBtn];
    
    //办事大厅
    UIButton * bsdtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bsdtBtn.frame = CGRectMake(self.view.frame.size.width/2+1, (self.view.frame.size.height-NAVIGATIONHEIGHT)/2+1+NAVIGATIONHEIGHT, self.view.frame.size.width/2-1,(self.view.frame.size.height-NAVIGATIONHEIGHT)/2-1 );
    bsdtBtn.backgroundColor = [UIColor whiteColor];
    bsdtBtn.tag = 4;
    [bsdtBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
    [bsdtBtn setBackgroundImage:[UIImage imageNamed:@"banshidating"] forState:UIControlStateNormal];
    [self.view addSubview:bsdtBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
