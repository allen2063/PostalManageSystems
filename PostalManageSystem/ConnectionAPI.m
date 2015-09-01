//
//  ConnectionAPI.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-3.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "ConnectionAPI.h"
#import <CommonCrypto/CommonDigest.h>

@implementation ConnectionAPI

@synthesize webData;
@synthesize conn;
@synthesize getXMLResults;
@synthesize resultArray,cacheDic;




- (id)init{
    self = [super init];
    urlToServer = @"http://222.85.149.6:88/GuiYangPost/";
    communicatingInterface = @"off";
    alerts = [[UIAlertView alloc]init];
    isback =NO;
    requestCount = 0;
    timeout = 5;
    self.cacheDic = [self readFileDic];
    if (self.cacheDic == nil) {
        self.cacheDic = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (NSString *)md5:(NSString *)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

//0参数
- (void)withInterface:(NSString *)interface{
    NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"",@"", nil];
    NSString *soapMsg =[NSString stringWithFormat:@"%@",dic];
    NSLog(@"%@",soapMsg);
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
    NSLog(@"%@",soapMsg);
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
    NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:argument1Name,argument1Value,argument1Name,argument2Name,argument2Value,argument2Name, nil];
    NSString *soapMsg = [NSString stringWithFormat:@"%@",dic];
    
    NSLog(@"%@",soapMsg);
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
- (void)withInterface:(NSString *)interface andArgument1Name:(NSString *)argument1Name andArgument1Value:(NSString *)argument1Value andArgument2Name:(NSString *)argument2Name andArgument2Value:(NSString *)argument2Value andArgument3Name:(NSString *)argument3Name andArgument3Value:(NSString *)argument3Value{
    NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:argument1Value,argument1Name,argument2Value,argument2Name,argument3Value,argument3Name, nil];
    NSString *soapMsg =[NSString stringWithFormat:@"%@",dic];
    NSLog(@"%@",soapMsg);
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
    NSLog(@"%@",soapMsg);
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
    userPassword = [self md5:userPassword ];
    communicatingInterface = @"manageApi/doLogin";
    [self withInterface:@"manageApi/doLogin" andArgument1Name:@"token" andArgument1Value:token andArgument2Name:@"userName" andArgument2Value:userName andArgument3Name:@"userPass" andArgument3Value:userPassword];
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
    //BOOL isAbleToJSON =[NSJSONSerialization isValidJSONObject: theXML];
    //if (isAbleToJSON) {
        NSData *aData = [theXML dataUsingEncoding: NSUTF8StringEncoding];
        NSDictionary * resultDic =  [NSJSONSerialization JSONObjectWithData:aData options:NSJSONReadingMutableContainers error:nil];
        isback = YES;
    if ([[resultDic objectForKey:@"result"] isEqualToString:@"1"]) {
        [self analysisTheResult:resultDic];
    }else{
        isfault = YES;
    }
}

- (void)analysisTheResult:(NSDictionary *)resultDic{
    NSDictionary * tempDic = [self.cacheDic objectForKey:communicatingInterface];
    NSString * tempDicMD5 = [self md5:[NSString stringWithFormat:@"%@",tempDic]];
    NSString * resultDicMD5 = [self md5:[NSString stringWithFormat:@"%@",resultDic]];
    
    if (tempDic == nil ) {          //没有此项数据
        [self.cacheDic setObject:resultDic forKey:communicatingInterface];
        [NSThread detachNewThreadSelector:@selector(writeFileDic) toTarget:self withObject:nil];

    }else if(![tempDicMD5 isEqualToString:resultDicMD5]){       //缓存和最新的数据不一样  需要缓存
        [self.cacheDic setObject:resultDic forKey:communicatingInterface];
        [NSThread detachNewThreadSelector:@selector(writeFileDic) toTarget:self withObject:nil];
    }
    if ([communicatingInterface isEqualToString:@"manageApi/doLogin"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"doLogin" object:self userInfo:nil];
    }
}

#pragma mark - read&write FileDic

//读取图片缓存
-(NSMutableDictionary *)readFileDic{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:@"cacheDic.archiver"];
    if ([[NSKeyedUnarchiver unarchiveObjectWithFile:path]isKindOfClass:[NSMutableDictionary class]]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }else return NO;
}

- (void)writeFileDic{
    //写入对应位置
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:@"cacheDic.archiver"];//拓展名可以自己随便取
    
    BOOL writeResult =[NSKeyedArchiver archiveRootObject:self.cacheDic toFile:path];
    NSLog(@"%@",writeResult ? @"写入缓存成功":@"写入缓存失败");
}

-(NSString *)documentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}



@end
