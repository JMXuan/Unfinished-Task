//
//  FMDBTool.m
//  ToDoList
//
//  Created by Jack on 16/2/13.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "FMDBTool.h"
#import "FMDB.h"
#import "DataManager.h"

@interface FMDBTool ()
@property (nonatomic, strong) FMDatabase *fmdbDatabase;
/** 存储遍历过后的标题数据 */
@property (nonatomic, strong) NSMutableArray *titleMutableArr;
/** 存储遍历过后的内容数据 */
@property (nonatomic, strong) NSMutableArray *issuesMutableArr;
/** 被删除的那行的标题 */
@property (nonatomic, strong) NSString *titleStr;
@end

@implementation FMDBTool

- (NSMutableArray *)issuesMutableArr {
    if(_issuesMutableArr == nil) {
        _issuesMutableArr = [[NSMutableArray alloc] init];
    }
    return _issuesMutableArr;
}

- (NSMutableArray *)titleMutableArr {
    if(_titleMutableArr == nil) {
        _titleMutableArr = [[NSMutableArray alloc] init];
    }
    return _titleMutableArr;
}


/** 创建表格*/
- (void)createDataBaseTable:(NSString *)tableName {
    /** 获取document文件路径*/
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    /**数据库的路径*/
    NSString *dbPath = [documentPath stringByAppendingPathComponent:@"dbPath.sqlite"];
    /** 数据库文件*/
    self.fmdbDatabase = [FMDatabase databaseWithPath:dbPath];
    NSString *table = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key, title text, issues text)",tableName];
    if ([self.fmdbDatabase open]) {
        //创建表
        BOOL isSuccess = [self.fmdbDatabase executeUpdate:table];
        if (!isSuccess) {
            NSLog(@"create table faild:%@", [self.fmdbDatabase lastError]);
        }
    }
    [self.fmdbDatabase close];
}

/** 插入数据*/
- (void)insertData:(NSString *)tableName title:(NSString *)issuesTitle detail:(NSString *)issuesDetail {
    if ([self.fmdbDatabase open]) {
        //带有参数的插入SQL语句
        BOOL isSuccess = [self.fmdbDatabase executeUpdateWithFormat:@"insert into %@ (title, issues) values (%@, %@)", tableName, issuesTitle, issuesDetail];
        if (!isSuccess) {
            NSLog(@"insert into faild:%@", [self.fmdbDatabase lastError]);
        }
    }
    [self.fmdbDatabase close];
}


/** 查询数据*/
- (void)queryData:(NSString *)tableName {
    if ([self.fmdbDatabase open]) {
        //查询（executeQuery)
        FMResultSet *resultSet = [self.fmdbDatabase executeQueryWithFormat:@"select * from %@", tableName];
        //可以轮询query回来的资料，每一次的next可以得到一个row裡对应的数值
        while ([resultSet next]) {
            //选择方法
            NSString *title = [resultSet stringForColumn:@"title"];
            NSString *issues = [resultSet stringForColumn:@"issues"];
            [self.titleMutableArr addObject:title];
            [self.issuesMutableArr addObject:issues];
        }
        NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
        mutableDic[@"issuesTitle"] = self.titleMutableArr;
        mutableDic[@"issuesDetail"] = self.issuesMutableArr;
        [self sendNotification:[mutableDic copy]];
    }
    [self.fmdbDatabase close];
}

- (void)deleteData:(NSString *)tableName title:(NSString *)issuesTitle{
    if ([self.fmdbDatabase open]) {
        BOOL isSuccess = [self.fmdbDatabase executeUpdateWithFormat:@"delete from %@ where %@ = '%@'", tableName, issuesTitle, self.titleStr];
        if (!isSuccess) {
            NSLog(@"delete data failed :%@", [self.fmdbDatabase lastError]);
        }
    }
}

#pragma mark ------------将表格数据发送到绘制统计图的方法-------------

- (void)sendNotification:(NSDictionary *)dic {
    [[NSNotificationCenter defaultCenter]postNotificationName:kDataFromTable object:nil userInfo:dic];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/** 将删除的数据赋值给titlestr */
- (void)addobserver{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(titleHasDeleted:) name:kTitleHasDeleted object:nil];
}

- (void)titleHasDeleted:(NSNotification *)notification {
    self.titleStr = [NSString stringWithFormat:@"%@", notification.userInfo[@"issuesTitle"]];
}
@end
