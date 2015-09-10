//
//  MYDDCBGViewController.m
//  PostalManageSystem
//
//  Created by ZengYifei on 15/8/18.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "MYDDCBGViewController.h"
#import "TFHpple.h"
@interface MYDDCBGViewController ()<UIWebViewDelegate>{
    AppDelegate *app;
    NSString * matchingElement;
    BOOL elementFound;
}
@property (strong,nonatomic)UILabel * titleLabel;
@property (strong,nonatomic)UIWebView * webView;

@end

@implementation MYDDCBGViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];//UIColorFromRGBValue(0xececec);
        matchingElement = @"img";
        int headLabelHieght = UISCREENHEIGHT/7 < 70 ? UISCREENHEIGHT/7: 70;

        self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, NAVIGATIONHEIGHT + headLabelHieght, UISCREENWIDTH, UISCREENHEIGHT-NAVIGATIONHEIGHT - headLabelHieght)];
        self.webView.backgroundColor = [UIColor clearColor];
        self.webView.scrollView.bounces = YES;
        self.webView.delegate = self;
        [self.view addSubview:self.webView];
        self.automaticallyAdjustsScrollViewInsets = NO;
        UILabel * headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, NAVIGATIONHEIGHT, UISCREENWIDTH, headLabelHieght)];
        headLabel.backgroundColor = [UIColor clearColor];
        [self.view addSubview:headLabel];
        
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, headLabel.frame.size.height*2/3)];
        titleLabel.text = @"标题";
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = UIColorFromRGBValue(0x333333);
        titleLabel.numberOfLines = 2;
        titleLabel.tag = 1;
        [headLabel addSubview:titleLabel];
        
        UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH/10, headLabel.frame.size.height*2/3, UISCREENWIDTH*2/5, headLabel.frame.size.height*1/3)];
        timeLabel.text = @"发布时间:";
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.font = [UIFont boldSystemFontOfSize:13];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.textColor = UIColorFromRGBValue(0x9e9e9e);
        timeLabel.tag = 2;
        [headLabel addSubview:timeLabel];
        
        UILabel * writeLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*6/10, headLabel.frame.size.height*2/3, UISCREENWIDTH*2/5, headLabel.frame.size.height*1/3)];
        writeLabel.text = @"作者:";
        writeLabel.backgroundColor = [UIColor clearColor];
        writeLabel.font = [UIFont boldSystemFontOfSize:13];
        writeLabel.textAlignment = NSTextAlignmentLeft;
        writeLabel.textColor = UIColorFromRGBValue(0x9e9e9e);
        writeLabel.tag = 3;
        [headLabel addSubview:writeLabel];
        
    }
    return self;
}

-(NSString *)documentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    //获取单例
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getNewsById:) name:@"getNewsById" object:nil];

    //设置导航栏label
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.textColor = [UIColor yellowColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = app.titleForCurrentPage;
    self.navigationItem.titleView = self.titleLabel;
}

- (void)getNewsById:(NSNotification *)note{
    NSDictionary * noteDic = [note userInfo];
    if ([[noteDic objectForKey:@"result"] isEqualToString:@"1"]) {
        
        NSDictionary * detailDic = [noteDic objectForKey:@"data"];
        
        UILabel * tempLabel = (UILabel *)[self.view viewWithTag:1];
        tempLabel.text = [detailDic objectForKey:@"title"];

        tempLabel = (UILabel *)[self.view viewWithTag:2];
        NSString * pubTime = [[detailDic objectForKey:@"pubTime"]substringWithRange:NSMakeRange(0,10)];
        tempLabel.text = [NSString stringWithFormat:@"%@%@",tempLabel.text,pubTime];
        
        tempLabel = (UILabel *)[self.view viewWithTag:3];
        tempLabel.text = [NSString stringWithFormat:@"%@%@",tempLabel.text,[detailDic objectForKey:@"author"]];
        
        NSMutableString * htmlString =[[NSMutableString alloc]initWithString: [detailDic objectForKey:@"details"]];
        
        htmlString = [self adjustPicForScreen:htmlString];
        
        self.webView.scalesPageToFit = NO;
        [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:htmlString]];
    }else{
        UIAlertView * alerts = [[UIAlertView alloc]initWithTitle:@"获取列表失败" message:@"请检查网络后重试！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alerts show];
    }
}

//在HTML代码中找到图片标签(<img) 并在后面添加图片的长宽标签(@" width=\"100%\" height=\"auto\" ")适应屏幕
- (NSMutableString *)adjustPicForScreen:(NSMutableString *)htmlString{
    htmlString = [[NSMutableString alloc]initWithString:htmlString];
    if ([htmlString rangeOfString:@"<img"].length>0) {
        NSString * tempString = [NSString stringWithFormat:@"%@",htmlString];
        NSMutableArray * tempArray = [[NSMutableArray alloc]init];
        int countOfArray = 0;
        int index = 0;
        NSString * insertString =@" width=\"100%\" height=\"auto\" ";
        while ([tempString rangeOfString:@"<img"].length) {
            [tempArray addObject:[NSString stringWithFormat:@"%d",
                                  (int)([tempString rangeOfString:@"<img"].location+[tempString rangeOfString:@"<img"].length)]];
            tempString = [tempString substringFromIndex:[tempString rangeOfString:@"<img"].location+[tempString rangeOfString:@"<img"].length];
            index = index + [[tempArray objectAtIndex:countOfArray]intValue];
            [htmlString insertString:insertString atIndex:index];
            index = index + (int)[insertString length];
            countOfArray++;
//            NSLog(@"tempString:%@  length:%d",tempString,[tempString length]);
//            NSLog(@"htmlString auto %@   length:%d",htmlString,[htmlString length]);
        }
    }
    
    //第三方库TFHpple解析html并获得图片标签
//    参见博客：http://www.cnblogs.com/YouXianMing/p/3731866.html    及github工程：https://github.com/topfunky/hpple
//    NSData  * data      = [htmlString dataUsingEncoding:NSASCIIStringEncoding];
//    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
//    NSArray * elements  = [doc searchWithXPathQuery:@"//img"];
//    NSMutableArray * newLabel = [[NSMutableArray alloc]init];
//    for (TFHppleElement * element in elements) {
//        NSLog(@"%@",element.raw);
//    }
    
    return  htmlString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [GMDCircleLoader hideFromView:self.view animated:YES];
    //[GMDCircleLoader setOnView:self.view withTitle:@"网页解析中..." animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //[GMDCircleLoader hideFromView:self.view animated:YES];
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
