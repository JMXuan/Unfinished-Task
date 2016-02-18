//
//  DataManager.h
//  ToDoList
//
//  Created by Jack on 16/2/11.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
/** 获取待办事项的详细内容 */
+ (NSArray *)getIssuessDetail:(NSDictionary *)dic;
/** 获取被删除项的标题 */
+ (void)dealWithDataWhereDeleted:(id)data;
@end
