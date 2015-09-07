//
//  ConnectionAPI.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-3.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pager.h"
@interface ConnectionAPI : NSObject<NSXMLParserDelegate, NSURLConnectionDelegate >{
    //UIAlertView * alerts;
    float timeout;
    BOOL isback;
    BOOL isfault;
    int requestCount;
    NSString * communicatingInterface;
    NSNotificationCenter *nc;
    NSMutableDictionary * UserInfo;
    NSString * urlToServer;
    UIAlertView * alerts;
}
+(NSMutableDictionary *)readFileDic;
+ (NSString *)md5:(NSString *)str;  //md5加密
- (void)loginWithToken:(NSString *)token AndUserName:(NSString *)userName AndUserPassword:(NSString *)userPassword;                     //获取首页热点新闻的图片、标题、内容
- (void)getListWithToken:(NSString *)token AndType:(NSString *)type AndListPager:(Pager *)listPager;
- (void)getDetailViewWithToken:(NSString *)token AndID:(NSString *)ID;
@property (strong, nonatomic) NSMutableData *webData;
@property (strong, nonatomic) NSURLConnection *conn;
@property (strong, nonatomic) NSMutableString *getXMLResults;

@property (strong, nonatomic) NSMutableDictionary * cacheDic;
@property (strong, nonatomic) NSArray *resultArray;


@end
