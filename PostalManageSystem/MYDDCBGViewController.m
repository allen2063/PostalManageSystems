//
//  MYDDCBGViewController.m
//  PostalManageSystem
//
//  Created by ZengYifei on 15/8/18.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "MYDDCBGViewController.h"

@interface MYDDCBGViewController ()<UIWebViewDelegate,NSXMLParserDelegate>{
    AppDelegate *app;
    NSString * matchingElement;
    BOOL elementFound;
}
@property (strong,nonatomic)UILabel * titleLabel;
@property (strong,nonatomic)UIWebView * webView;
@property (strong, nonatomic) NSXMLParser *xmlParser;

@end

@implementation MYDDCBGViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = UIColorFromRGBValue(0xececec);
        matchingElement = @"img";
        self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, NAVIGATIONHIGHT + UISCREENHEIGHT/7, UISCREENWIDTH, UISCREENHEIGHT*6/7-NAVIGATIONHIGHT)];
        self.webView.backgroundColor = [UIColor clearColor];
        self.webView.scrollView.bounces = NO;
        self.webView.delegate = self;
        [self.view addSubview:self.webView];
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        UILabel * headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, NAVIGATIONHIGHT, UISCREENWIDTH, UISCREENHEIGHT/7)];
        headLabel.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:headLabel];
        
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, headLabel.frame.size.height*2/3)];
        titleLabel.text = @"你要干什么  我是标题！！你要干什么  我是标题！！你要干什么  我是标题！！";
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
        
        NSString * htmlString = [detailDic objectForKey:@"details"];
        [self adjustPicForScreen:htmlString];
        self.webView.scalesPageToFit = NO;
        [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:htmlString]];
    }else{
        UIAlertView * alerts = [[UIAlertView alloc]initWithTitle:@"获取列表失败" message:@"请检查网络后重试！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alerts show];
    }
//    NSData * webData =[htmlString dataUsingEncoding:NSUTF8StringEncoding] ;
//    self.xmlParser = [[NSXMLParser alloc] initWithData: webData];
//    [self.xmlParser setDelegate: self];
//    [self.xmlParser setShouldResolveExternalEntities: YES];
//    [self.xmlParser parse];
    
}

- (void)adjustPicForScreen:(NSString *)htmlString{
    if ([htmlString rangeOfString:@"<img src="].location >0) {
        int countOfPic = [htmlString rangeOfString:@"<img src="].location;
        NSMutableArray * arr = (NSMutableArray *)[htmlString componentsSeparatedByString:@"<img src="];
        NSLog(@"!!!!!!!!!!!%@  %d",arr,countOfPic);
        //NSRange
//        NSString * d = @"1626636456124w46e6r456";
//        NSLog(@"%d  %d",[d rangeOfString:@"6"].length,[d rangeOfString:@"6"].location);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth = 300.0;" // UIWebView中显示的图片宽度
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
  
    

}

#pragma mark XML Parser Delegate Methods

// 开始解析一个元素名
-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
    NSLog(@"%@",elementName);
    if ([elementName isEqualToString:matchingElement]) {
        elementFound = YES;
        }
}

// 追加找到的元素值，一个元素值可能要分几次追加
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string {
    if (elementFound) {
        NSLog(@"%@",string);
    }
}

// 结束解析这个元素名
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    
}

// 解析整个文件结束后
- (void)parserDidEndDocument:(NSXMLParser *)parser {
//    if (self.soapResults) {
//        self.soapResults = nil;
//    }
}

// 出错时，例如强制结束解析
- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
//    if (self.soapResults) {
//        self.soapResults = nil;
//    }
    //NSLog(@"????????????%@",parseError);
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
