//
//  FMDBTool.h
//  ToDoList
//
//  Created by Jack on 16/2/13.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBTool : NSObject
/**
 *  创建表格
 *
 *  @param tableName 表格的名字
 */
- (void)createDataBaseTable:(NSString *)tableName;

/**
 *  插入数据
 *
 *  @param tableName    表格名字
 *  @param issuesTitle  待办事项的标题
 *  @param issuesDetail 待办事项的详细内容
 */
- (void)insertData:(NSString *)tableName title:(NSString *)issuesTitle detail:(NSString *)issuesDetail;


/** 查询数据*/
- (void)queryData:(NSString *)tableName;
/**
 *  删除数据
 *
 *  @param tableName   表格名字
 *  @param issuesTitle 待办事项的标题
 */
- (void)deleteData:(NSString *)tableName title:(NSString *)issuesTitle;

@end
