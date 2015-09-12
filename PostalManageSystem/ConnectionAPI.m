//
//  ConnectionAPI.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-3.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "ConnectionAPI.h"
//md5
#import <CommonCrypto/CommonDigest.h>
//json化
#import <objc/runtime.h>

@interface ConnectionAPI ()



@end



@implementation ConnectionAPI

@synthesize webData;
@synthesize conn;
@synthesize getXMLResults;
@synthesize resultArray,cacheDic;

- (id)init{
    self = [super init];
    urlToServer = @"http://222.85.149.6:88/GuiYangPost/";//@"chisifang.imwork.net:11246/GuiYangPost/";    communicatingInterface = @"off";
    alerts = [[UIAlertView alloc]init];
    isback =NO;
    requestCount = 0;
    timeout = 25;
    self.cacheDic = [ConnectionAPI readFileDic];
    if (self.cacheDic == nil) {
        self.cacheDic = [[NSMutableDictionary alloc]init];
    }
    

    return self;
}

#pragma md5
+ (NSString *)md5:(NSString *)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

#pragma 对象json化
+ (NSDictionary*)getObjectData:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil)
        {
            value = [NSNull null];
        }
        else
        {
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    return dic;
}

+ (id)getObjectInternal:(id)obj
{
    if([obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]])
    {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}

#pragma 接口
//0参数
- (void)withInterface:(NSString *)interface{
    NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"",@"", nil];
    NSString *soapMsg =[NSString stringWithFormat:@"%@",dic];
    NSLog(@"soapMsg %@",soapMsg);
    NSString * ur = [NSString stringWithFormat:@"%@%@",urlToServer,interface];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMsg length]];
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];

    
    //自定义时间超时
    requestCount ++;
    NSDictionary * threadInfo = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",requestCount],@"threadInfo", nil];
    [NSTimer scheduledTimerWithTimeInterval:timeout target: self selector: @selector(handleTimer:) userInfo:threadInfo repeats:NO];
    isback =NO;
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [NSMutableData data];
    }else NSLog(@"con为假  %@",webData);
}
//1参数
- (void)withInterface:(NSString *)interface andArgument1Name:(NSString *)argument1Name andArgument1Value:(NSString *)argument1Value {
    NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:argument1Value,argument1Name,nil];
    NSString *soapMsg =[NSString stringWithFormat:@"%@",dic];
    NSLog(@"soapMsg %@",soapMsg);
    NSString * ur = [NSString stringWithFormat:@"%@%@",urlToServer,interface];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMsg length]];
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];

    
    //自定义时间超时
    requestCount ++;
    NSDictionary * threadInfo = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",requestCount],@"threadInfo", nil];
    [NSTimer scheduledTimerWithTimeInterval:timeout target: self selector: @selector(handleTimer:) userInfo:threadInfo repeats:NO];
    isback =NO;
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [NSMutableData data];
    }else NSLog(@"con为假  %@",webData);
}

//2参数
- (void)withInterface:(NSString *)interface andArgument1Name:(NSString *)argument1Name andArgument1Value:(NSString *)argument1Value andArgument2Name:(NSString *)argument2Name andArgument2Value:(id)argument2Value{
    NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:argument1Value,argument1Name,argument2Value,argument2Name, nil];
    NSString *soapMsg = [NSString stringWithFormat:@"%@",dic];
    
    NSLog(@"soapMsg %@",soapMsg);
    NSString * ur = [NSString stringWithFormat:@"%@%@",urlToServer,interface];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMsg length]];
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    //自定义时间超时
    requestCount ++;
    NSDictionary * threadInfo = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",requestCount],@"threadInfo", nil];
    [NSTimer scheduledTimerWithTimeInterval:timeout target: self selector: @selector(handleTimer:) userInfo:threadInfo repeats:NO];
    isback =NO;

    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [NSMutableData data];
    }else NSLog(@"con为假  %@",webData);
}
//3参数
- (void)withInterface:(NSString *)interface andArgument1Name:(NSString *)argument1Name andArgument1Value:(NSString *)argument1Value andArgument2Name:(NSString *)argument2Name andArgument2Value:(NSString *)argument2Value andArgument3Name:(NSString *)argument3Name andArgument3Value:(id)argument3Value{
    NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:argument1Value,argument1Name,argument2Value,argument2Name,argument3Value,argument3Name, nil];
    NSString *soapMsg =[NSString stringWithFormat:@"%@",dic];
    NSLog(@"soapMsg %@",soapMsg);
    NSString * ur = [NSString stringWithFormat:@"%@%@",urlToServer,interface];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMsg length]];
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];

    //自定义时间超时
    requestCount ++;
    NSDictionary * threadInfo = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",requestCount],@"threadInfo", nil];
    [NSTimer scheduledTimerWithTimeInterval:timeout target: self selector: @selector(handleTimer:) userInfo:threadInfo repeats:NO];
    isback =NO;
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [NSMutableData data];
    }else NSLog(@"con为假  %@",webData);
}

//4参数
- (void)withInterface:(NSString *)interface andArgument1Name:(NSString *)argument1Name andArgument1Value:(NSString *)argument1Value andArgument2Name:(NSString *)argument2Name andArgument2Value:(NSString *)argument2Value andArgument3Name:(NSString *)argument3Name andArgument3Value:(NSString *)argument3Value andArgument4Name:(NSString *)argument4Name andArgument4Value:(NSString *)argument4Value{
    
    NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:argument1Value,argument1Name,argument2Value,argument2Name,argument3Value,argument3Name,argument4Value,argument4Name, nil];
    NSString *soapMsg =[NSString stringWithFormat:@"%@",dic];
    NSLog(@"soapMsg %@",soapMsg);
    NSString * ur = [NSString stringWithFormat:@"%@%@",urlToServer,interface];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMsg length]];
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    //自定义时间超时
    requestCount ++;
    NSDictionary * threadInfo = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",requestCount],@"threadInfo", nil];
    [NSTimer scheduledTimerWithTimeInterval:timeout target: self selector: @selector(handleTimer:) userInfo:threadInfo repeats:NO];
    isback =NO;

    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [NSMutableData data];
    }else NSLog(@"con为假  %@",webData);
}

- (void)loginWithToken:(NSString *)token AndUserName:(NSString *)userName AndUserPassword:(NSString *)userPassword{
    userPassword = [ConnectionAPI md5:userPassword ];
    communicatingInterface = @"manageApi/doLogin";
    [self withInterface:@"manageApi/doLogin" andArgument1Name:@"token" andArgument1Value:token andArgument2Name:@"userName" andArgument2Value:userName andArgument3Name:@"userPass" andArgument3Value:userPassword];
}

- (void)getListWithToken:(NSString *)token AndType:(NSString *)type AndListPager:(Pager *)listPager{
    NSDictionary * listPagerJson = [ConnectionAPI getObjectData:listPager];
    communicatingInterface = @"baseNewsApi/getNewsByType";
    [self withInterface:@"baseNewsApi/getNewsByType" andArgument1Name:@"token" andArgument1Value:token andArgument2Name:@"type" andArgument2Value:type andArgument3Name:@"listPager" andArgument3Value:listPagerJson];
}

- (void)getDetailViewWithToken:(NSString *)token AndID:(NSString *)ID{
    communicatingInterface = @"baseNewsApi/getNewsById";
    [self withInterface:@"baseNewsApi/getNewsById" andArgument1Name:@"token" andArgument1Value:token andArgument2Name:@"id" andArgument2Value:ID];
}


//连接

#pragma mark URL Connection Data Delegate Methods

// 刚开始接受响应时调用
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *) response{
    [self.webData setLength: 0];
}

// 每接收到一部分数据就追加到webData中
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *) data {
    [self.webData appendData:data];
}

// 出现错误时
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *) error {
    self.conn = nil;
    self.webData = nil;
    NSLog(@"!!!!!!!!!!!!%@",error);
    //alerts = [[UIAlertView alloc] initWithTitle:@"错误" message:[error localizedDescription]  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];

    if (alerts.visible != YES) {
        alerts = [alerts initWithTitle:@"错误" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
         [alerts show];
    }
   
    NSDictionary * d = [[NSDictionary alloc]initWithObjectsAndKeys:error,@"error" ,nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fault" object:self userInfo:d];
}


//时间超时定义
-(void) handleTimer:(NSTimer *)timer
{
    int threadInfo = 0;
    //[[timer userInfo] isKindOfClass:[NSDictionary class]]?NSLog(@"yes"):NSLog(@"no");
    if ([[timer userInfo] isKindOfClass:[NSDictionary class]]) {
        threadInfo =[[[timer userInfo]objectForKey:@"threadInfo"] intValue];
    }
    if(!isback &&(threadInfo == requestCount)){  //时间到后未返回或者当前的线程标识不是设置计时器的线程标识 也就是说只有状态为未返回并且当前进程就是设置计时器的进程时成立
        [[NSNotificationCenter defaultCenter] postNotificationName:@"fault" object:self userInfo:nil];
        //alerts = [[UIAlertView alloc]initWithTitle:@"网络请求超时" message:@"请检查您的网络！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        if (alerts.visible != YES) {
            alerts = [alerts initWithTitle:@"网络请求超时" message:@"请检查您的网络！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alerts show];
        }
    }
}

// 完成接收数据时调用
-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
    NSString *theXML = [[NSString alloc] initWithBytes:[self.webData mutableBytes]
                                                length:[self.webData length]
                                              encoding:NSUTF8StringEncoding];
    // 打印出得到的XML
    NSLog(@"得到的返回数据：%@", theXML);
    self.getXMLResults = [[ NSMutableString alloc ]initWithString:theXML];
    //服务器报错
    isfault = NO;
    //json解析
    NSData *aData = [theXML dataUsingEncoding: NSUTF8StringEncoding];
    NSDictionary * resultDic =  [NSJSONSerialization JSONObjectWithData:aData options:NSJSONReadingMutableContainers error:nil];
        isback = YES;
    [self analysisTheResult:resultDic];

}

- (void)analysisTheResult:(NSDictionary *)resultDic{
    
    if ([[resultDic objectForKey:@"result"] isEqualToString:@"0"]) {
        NSLog(@"网络返回报错");
    }
    //目前不考虑所有网络返回都缓存
//    NSDictionary * tempDic = [self.cacheDic objectForKey:communicatingInterface];
//    NSString * tempDicMD5 = [ConnectionAPI md5:[NSString stringWithFormat:@"%@",tempDic]];
//    NSString * resultDicMD5 = [ConnectionAPI md5:[NSString stringWithFormat:@"%@",resultDic]];
//    else if ((tempDic == nil)||(![tempDicMD5 isEqualToString:resultDicMD5]) ) {          //没有此项数据 或缓存和刚从服务器获取的数据不一样  需要缓存
//        [self.cacheDic setObject:resultDic forKey:communicatingInterface];
//        [NSThread detachNewThreadSelector:@selector(writeFileDic) toTarget:self withObject:nil];
//    }else if(![tempDicMD5 isEqualToString:resultDicMD5]){       //缓存和最新的数据不一样  需要缓存
//        [self.cacheDic setObject:resultDic forKey:communicatingInterface];
//        [NSThread detachNewThreadSelector:@selector(writeFileDic) toTarget:self withObject:nil];
//    }
    //登录
    if ([communicatingInterface isEqualToString:@"manageApi/doLogin"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"doLogin" object:self userInfo:resultDic];
    }
    //启动公告list
    else if ([communicatingInterface isEqualToString:@"baseNewsApi/getNewsByType"] && [self.getXMLResults rangeOfString:@"启动公告"].length !=0 && [self.getXMLResults rangeOfString:@"listPager"].length !=0){
        NSString * ID = [[[resultDic objectForKey:@"data"]objectAtIndex:0]objectForKey:@"id"];
        [self getDetailViewWithToken:@"jiou" AndID:ID];
    }
    //启动公告detail
    else if ([communicatingInterface isEqualToString:@"baseNewsApi/getNewsById"] && [self.getXMLResults rangeOfString:@"启动公告"].length !=0){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"qdgg" object:self userInfo:resultDic];
    }
    //获取新闻列表
    else if([communicatingInterface isEqualToString:@"baseNewsApi/getNewsByType"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getNewsByType" object:self userInfo:resultDic];
    }
    //获取新闻详情
    else if([communicatingInterface isEqualToString:@"baseNewsApi/getNewsById" ]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getNewsById" object:self userInfo:resultDic];
    }
}

//uinicode转UNT8
+(NSString *)replaceUnicode:(NSString *)unicodeStr {
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

#pragma mark - read&write File
//读取缓存
+(NSMutableDictionary *)readFileDic{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:@"cacheDic.archiver"];
    
    if ([[NSKeyedUnarchiver unarchiveObjectWithFile:path]isKindOfClass:[NSMutableDictionary class]]) {
        NSLog( @"read file successfully!");
        return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }else{
        NSLog( @"ERROR FROM READ FILE");
        return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
}

//读取XML
+(NSString *)readXMLStringWithFileName:(NSString *)name
{
    NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:@"xml"];

    //dataPath 表示当前目录下指定的一个文件 data.plist
    //NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    //filePath 表示程序目录下指定文件
    //NSString *filePath = [self documentsPath:@"provinces.xml"];
    //NSLog(@"path:%@",filePath);
    //从filePath 这个指定的文件里读
    NSError * error;
    NSString * str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    //NSLog(@"XML:%@",str);
    return str;
}

+(NSString *)documentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

- (void)writeFileDic{
    //写入对应位置
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:@"cacheDic.archiver"];//拓展名可以自己随便取
    
    BOOL writeResult =[NSKeyedArchiver archiveRootObject:self.cacheDic toFile:path];
    NSLog(@"%@",writeResult ? @"写入缓存成功ConnectionAPI":@"写入缓存失败ConnectionAPI");
}

//图片转二进制
+ (NSData *)picToStringWithImage:(UIImage *)image{
    NSData *data;
    if (UIImagePNGRepresentation(image)==nil) {
        data = UIImageJPEGRepresentation(image, 1.0);
    }else{
        data = UIImagePNGRepresentation(image);
    }
    return data;
}

#pragma mark - 图片上传
+(NSString *)PostImagesToServer:(NSString *) strUrl dicPostParams:(NSMutableDictionary *)params dicImages:(NSMutableDictionary *) dicImages{
    NSString * res;
    
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //根据url初始化request
    //NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //要上传的图片
    UIImage *image;//=[params objectForKey:@"pic"];
    //得到图片的data
    //NSData* data = UIImagePNGRepresentation(image);
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合        我们这里这个不重要  表单用的。。。
    NSArray *keys= [params allKeys];
    
    //遍历keys
    for(int i=0;i<[keys count];i++) {
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        //如果key不是pic，说明value是字符类型，比如name：Boris
        //if(![key isEqualToString:@"pic"]) {
        //添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        //添加字段名称，换2行
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
        //[body appendString:@"Content-Transfer-Encoding: 8bit"];
        //添加字段的值
        [body appendFormat:@"%@\r\n",[params objectForKey:key]];
        //}
    }
    ////添加分界线，换行
    //[body appendFormat:@"%@\r\n",MPboundary];
    
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    //循环加入上传图片          这个是放要上传的图片的
    keys = [dicImages allKeys];
    for(int i = 0; i< [keys count] ; i++){
        //要上传的图片
        image = [dicImages objectForKey:[keys objectAtIndex:i ]];
        //得到图片的data
        NSData* data =  UIImageJPEGRepresentation(image, 0.0);
        NSMutableString *imgbody = [[NSMutableString alloc] init];
        //此处循环添加图片文件
        //添加图片信息字段
        //声明pic字段，文件名为boris.png
        //[body appendFormat:[NSString stringWithFormat: @"Content-Disposition: form-data; name=\"File\"; filename=\"%@\"\r\n", [keys objectAtIndex:i]]];
        
        ////添加分界线，换行
        [imgbody appendFormat:@"%@\r\n",MPboundary];
        [imgbody appendFormat:@"Content-Disposition: form-data; name=\"File%d\"; filename=\"%@.jpg\"\r\n", i, [keys objectAtIndex:i]];
        //声明上传文件的格式
        [imgbody appendFormat:@"Content-Type: application/octet-stream; charset=utf-8\r\n\r\n"];
        
        NSLog(@"上传的图片：%d  %@", i, [keys objectAtIndex:i]);
        
        //将body字符串转化为UTF8格式的二进制
        //[myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData appendData:[imgbody dataUsingEncoding:NSUTF8StringEncoding]];
        //将image的data加入
        [myRequestData appendData:data];
        [myRequestData appendData:[ @"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"%@\r\n",endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"keep-alive" forHTTPHeaderField:@"connection"];
    //[request setValue:@"UTF-8" forHTTPHeaderField:@"Charsert"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    
    //建立连接，设置代理
    //NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //设置接受response的data
    NSData *mResponseData;
    NSError *err = nil;
    mResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
    
    if(mResponseData == nil){
        NSLog(@"err code : %@", [err localizedDescription]);
    }
    res = [[NSString alloc] initWithData:mResponseData encoding:NSUTF8StringEncoding];
    /*
     if (conn) {
     mResponseData = [NSMutableData data];
     mResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
     
     if(mResponseData == nil){
     NSLog(@"err code : %@", [err localizedDescription]);
     }
     res = [[NSString alloc] initWithData:mResponseData encoding:NSUTF8StringEncoding];
     }else{
     res = [[NSString alloc] init];
     }*/
    NSLog(@"服务器返回：%@", res);
    return res;
}

@end
