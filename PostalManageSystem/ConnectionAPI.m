//
//  ConnectionAPI.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-3.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "ConnectionAPI.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>

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
- (void)withInterface:(NSString *)interface andArgument1Name:(NSString *)argument1Name andArgument1Value:(NSString *)argument1Value andArgument2Name:(NSString *)argument2Name andArgument2Value:(NSString *)argument2Value{
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
    NSLog(@"%@", theXML);
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
    if ([communicatingInterface isEqualToString:@"manageApi/doLogin"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"doLogin" object:self userInfo:resultDic];
    }else if([communicatingInterface isEqualToString:@"baseNewsApi/getNewsByType"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getNewsByType" object:self userInfo:resultDic];
    }else if([communicatingInterface isEqualToString:@"baseNewsApi/getNewsById" ]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getNewsById" object:self userInfo:resultDic];
    }
}

#pragma mark - read&write FileDic

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





@end
