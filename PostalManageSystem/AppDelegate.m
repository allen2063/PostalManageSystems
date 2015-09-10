//
//  AppDelegate.m
//  PostalManageSystem
//
//  Created by ZengYifei on 15/8/18.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "GDataXMLNode.h"

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGBValue(0x028e45)];//邮政的绿色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [[UINavigationBar appearance] setTintColor:[UIColor yellowColor]];    //导航栏按钮颜色
    self.titleForCurrentPage = @"邮政普遍服务信息管理系统";
    self.login = NO;
    self.network = [[ConnectionAPI alloc]init];
    self.pager = [[Pager alloc]init];
    MainViewController * mainViewController = [[MainViewController alloc] initWithNibName:nil bundle:nil];
    self.interfaceTransform = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"baseNewsApi/getNewsByType",@"满意度调查结果通告", nil];
    UINavigationController * navCon = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    self.window.rootViewController = navCon;
    [self.window makeKeyAndVisible];
    
    

//    NSError * error;
//    GDataXMLDocument * gdataXml =[[GDataXMLDocument alloc]initWithData:dataString options:0 error:&error];
//    NSMutableString * string = [[NSMutableString alloc]init];
//    GDataXMLElement * rootElement = [gdataXml rootElement];
//    NSArray * arrProvince = [rootElement elementsForName:@"RECORD"];
//    for (GDataXMLElement * nodeElement in arrProvince) {
//        [string appendFormat:@"======province=======/n" ];
//        GDataXMLNode * node = [nodeElement attributeForName:@"province"];
//        NSLog(@"node%@   %@   nodecount:%lu  node%@",nodeElement,[node.children class],(unsigned long)node.childCount,node);
//        ;
//    
//        NSDictionary * dic = (NSDictionary *)[node.children objectAtIndex:0];
//        NSLog(@"dic%@",[[node.children objectAtIndex:0] class]);
//        for (int k =0; k<[node childCount]; k++) {
//            GDataXMLNode * pro_node = [node childAtIndex:k];
//            switch (k) {
//                case 0:
//                    [string appendFormat:@"provice1=%@/r/n",[pro_node stringValue]];
//                    break;
//                case 1:
//                    [string appendFormat:@"provice2=%@/r/n",[pro_node stringValue]];
//                    break;
//                case 2:
//                    [string appendFormat:@"provice3=%@/r/n",[pro_node stringValue]];
//                    break;
//                    
//                default:
//                    break;
//            }
//        }
    //}
    
    
    //上传图片
//    NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[UIImage imageNamed:@"banshidating"],@"pic", nil];
//    [ConnectionAPI PostImagesToServer:@"http://222.85.149.6:88/GuiYangPost/uploadpicture/upload" dicPostParams:dic dicImages:dic];
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
