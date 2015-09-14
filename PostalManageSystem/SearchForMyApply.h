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
@interface SearchForMyApply : UIViewController
@property (nonatomic,assign)eRefreshType type;
@end
