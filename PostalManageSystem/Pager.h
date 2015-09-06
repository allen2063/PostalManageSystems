//
//  Pager.h
//  PostalManageSystem
//
//  Created by ZengYifei on 15/9/5.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pager : NSObject

@property ( nonatomic) int totalRows; //总行数
@property ( nonatomic) int pageSize ; //每页显示的行数
@property ( nonatomic) int currentPage; //当前页号
@property ( nonatomic) int totalPages; //总页数
@property ( nonatomic) int startRow; //当前页在数据库中的起始行
@property ( nonatomic) int firstIndex;
@property ( nonatomic) int endIndex;
@property ( nonatomic) int indexStep ;

@end
