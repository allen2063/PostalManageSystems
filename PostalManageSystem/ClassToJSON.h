//
//  ClassToJSON.h
//  POST
//
//  Created by QiaoLibo on 15/9/6.
//  Copyright (c) 2015年 Qiaolibo. All rights reserved.
//
#import <objc/runtime.h>
#import <Foundation/Foundation.h>

#ifndef POST_ClassToJSON_h
#define POST_ClassToJSON_h

@interface ClassToJSON: NSObject 
+ (NSDictionary*)getObjectData:(id)obj;
+ (id)getObjectInternal:(id)obj;
@end

#endif
