//
//  AppDelegate.h
//  PostalManageSystem
//
//  Created by ZengYifei on 15/8/18.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionAPI.h"
#import "Pager.h"
#import <BaiduMapAPI/BMapKit.h>//引入所有的头文件

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain,nonatomic)NSString * titleForCurrentPage;
@property BOOL login;
@property (strong,nonatomic) ConnectionAPI * network;
@property (strong,nonatomic) Pager * pager;
@property (strong,nonatomic) NSMutableDictionary * interfaceTransform;
@property (strong,nonatomic) NSMutableDictionary * userData;
@end

