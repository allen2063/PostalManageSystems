//
//  JXJWPMLCXViewController.m
//  PostalManageSystem
//
//  Created by ZengYifei on 15/8/20.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "JXJWPMLCXViewController.h"

@interface JXJWPMLCXViewController ()<UIWebViewDelegate>{
    AppDelegate *app;
}
@property (strong,nonatomic) UILabel * titleLabel;

@end

@implementation JXJWPMLCXViewController
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
    [GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];
    //获取单例
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //设置导航栏label
    Pager * pager ;
    [app.network getListWithToken:@"jiou" AndType:@"jxjwp" AndListPager:pager];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.textColor = [UIColor yellowColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = app.titleForCurrentPage;
    self.navigationItem.titleView = self.titleLabel;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jxjwp:) name:@"jxjwp" object:nil];
    
    
//    NSString * webCode =@"禁寄物品指导目录及处理办法（试行）\n"
//    "　一、禁寄物品是指国家法律、法规禁止寄递的物品，主要包括：\n"
//     "\n"
//    "　（一）各类武器、弹药。如枪支、子弹、炮弹、手榴弹、地雷、炸弹等。\n"
//     "\n"
//    "　（二）各类易爆炸性物品。如雷管、炸药、火药、鞭炮等。\n"
//     "\n"
//    "　（三）各类易燃烧性物品，包括液体、气体和固体。如汽油、煤油、桐油、酒精、生漆、柴油、气雾剂、气体打火机、瓦斯气瓶、磷、硫磺、火柴等。\n"
//     "\n"
//    "　（四）各类易腐蚀性物品。如火硫酸、盐酸、硝酸、有机溶剂、农药、双氧水、危险化学品等。\n"
//     "\n"
//    "  （五）各类放射性元素及容器。如铀、钴、镭、钚等。\n"
//     "\n"
//    "　（六）各类烈性毒药。如铊、氰化物、砒霜等。\n"
//     "\n"
//    "　（七）各类麻醉药物。如鸦片（包括罂粟壳、花、苞、叶）、吗啡、可卡因、海洛因、大麻、冰毒、麻黄素及其它制品等。\n"
//     "\n"
//    "　（八）各类生化制品和传染性物品。如炭疽、危险性病菌、医药用废弃物等。\n"
//     "\n"
//    "　（九）各种危害国家安全和社会政治稳定以及淫秽的出版物、宣传品、印刷品等。\n"
//     "\n"
//    "　（十）各种妨害公共卫生的物品。如尸骨、动物器官、肢体、未经硝制的兽皮、未经药制的兽骨等。\n"
//     "\n"
//    "　（十一）国家法律、法规、行政规章明令禁止流通、寄递或进出境的物品，如国家秘密文件和资料、国家货币及伪造的货币和有价证券、仿真武器、管制刀具、珍贵文物、濒危野生动物及其制品等。\n"
//     "\n"
//    "　（十二）包装不妥，可能危害人身安全、污染或者损毁其他寄递件、设备的物品等。\n"
//     "\n"
//    "　（十三）各寄达国（地区）禁止寄递进口的物品等。\n"
//     "\n"
//    "　（十四）其他禁止寄递的物品。\n"
//     "\n"
//    "　二、寄递服务企业对禁寄物品处理办法：\n"
//     "\n"
//    "　（一）企业发现各类武器、弹药等物品，应立即通知公安部门处理，疏散人员，维护现场。同时通报国家安全机关。\n"
//     "\n"
//    "　（二）企业发现各类放射性物品、生化制品、麻醉药物、传染性物品和烈性毒药，应立即通知防化及公安部门按应急预案处理。同时通报国家安全机关。\n"
//     "\n"
//    "　（三）企业发现各类易燃易爆等危险物品，收寄环节发现的，不予收寄；经转环节发现的，应停止转发；投递环节发现的，不予投递。对危险品要隔离存放。对其中易发生危害的危险品，应通知公安部门，同时通报国家安全机关，采取措施进行销毁。需要消除污染的，应报请卫生防疫部门处理。其他危险品，可通知寄件人限期领回。对内件中其他非危险品，应当整理重封，随附证明发寄或通知收件人到投递环节领取。\n"
//    "\n"
//    "　（四）企业发现各种危害国家安全和社会政治稳定以及淫秽的出版物、宣传品、印刷品，应及时通知公安、国家安全和新闻出版部门处理。\n"
//     "\n"
//    "　（五）企业发现妨害公共卫生的物品和容易腐烂的物品，应视情况通知寄件人限期领回，无法通知寄件人领回的可就地销毁。\n"
//     "\n"
//    "　（六）企业对包装不妥，可能危害人身安全，污染或损毁其他寄递物品和设备的，收寄环节发现后，应通知寄件人限期领回。经转或投递中发现的，应根据具体情况妥善处理。\n"
//     "\n"
//    "　（七）企业发现禁止进出境的物品，应移交海关处理。\n"
//    "\n"
//    "　（八）其他情形，可通知相关政府监管部门处理。\n"
//    
//    ;
//    
//    UITextView * text = [[UITextView alloc]initWithFrame:self.view.frame];
//    text.text = webCode;
//    text.font = [UIFont systemFontOfSize:15];
//    text.editable = NO;
//    [self.view addSubview:text];
}

- (void)jxjwp:(NSNotification *)note{
    NSDictionary * dic = [note userInfo];
    if ([[dic objectForKey:@"result"] isEqualToString:@"1"]) {
        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, NAVIGATIONHEIGHT, UISCREENWIDTH, UISCREENHEIGHT - NAVIGATIONHEIGHT)];
        webView.delegate = self;
        webView.scrollView.bounces = NO;
        [self.view addSubview:webView];
        NSDictionary * data = [dic objectForKey:@"data"];
        NSString * htmlString = [data objectForKey:@"details"];

        [webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:htmlString]];
    }else{
        UIAlertView * alerts = [[UIAlertView alloc]initWithTitle:@"获取信息失败" message:@"请检查网络，并退出本页面后重试！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alerts show];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [GMDCircleLoader hideFromView:self.view animated:YES];
    [GMDCircleLoader setOnView:self.view withTitle:@"解析中..." animated:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [GMDCircleLoader hideFromView:self.view animated:YES];
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
