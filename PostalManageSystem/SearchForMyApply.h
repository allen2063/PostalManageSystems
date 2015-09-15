//
//  SearchForMyApply.h
//  PostalManageSystem
//
//  Created by ZengYifei on 15/9/14.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, eRefreshType){
    eRefreshTypeDefine=0,
    eRefreshTypeProgress=1
};

//// 1、添加按键代理
//@protocol scrollViewBackDelegate <NSObject>
//// 2、代理的协议方法
//- (void)scrollViewBack;
//@end

@interface SearchForMyApply : UIViewController
@property (nonatomic,assign)eRefreshType type;
//@property (nonatomic, weak) id<scrollViewBackDelegate> delegate;
@end
