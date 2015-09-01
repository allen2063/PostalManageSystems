//
//  AppDelegate.h
//  PostalManageSystem
//
//  Created by ZengYifei on 15/8/18.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionAPI.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain,nonatomic)NSString * titleForCurrentPage;
@property BOOL login;
@property (strong,nonatomic) ConnectionAPI * network;
@end

