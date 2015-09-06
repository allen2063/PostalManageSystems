//
//  GeneralTalbeViewController.h
//  PostalManageSystem
//
//  Created by ZengYifei on 15/8/18.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, eRefreshType){
    eRefreshTypeDefine=0,
    eRefreshTypeProgress=1
};
@interface GeneralTalbeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign)eRefreshType type;

@end
