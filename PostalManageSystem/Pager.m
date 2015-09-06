//
//  Pager.m
//  PostalManageSystem
//
//  Created by ZengYifei on 15/9/5.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "Pager.h"

@implementation Pager
- (id)init{
    self = [super init];
    self.indexStep = 3;
    self.pageSize = NUMBEROFTITLEFORPAGE;//每页显示的行数
    self.currentPage = 0;
    self.totalPages = 1;
    return  self;
}
@end
