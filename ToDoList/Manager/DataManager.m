//
//  DataManager.m
//  ToDoList
//
//  Created by Jack on 16/2/11.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "DataManager.h"
#import "IssuesDetail.h"

@interface DataManager ()

@end

@implementation DataManager


+ (NSArray *)getIssuessDetail:(NSDictionary *)dic{
    NSMutableArray *mutableArr = [NSMutableArray new];
    [mutableArr addObject:dic];
    NSLog(@"manager:%lu",mutableArr.count);
    return [[self alloc]getIssues:mutableArr];
}

- (NSArray*)getIssues:(NSMutableArray *)arr{
    NSMutableArray *mutableArr = [NSMutableArray array];
    for (NSDictionary *dics in arr) {
        IssuesDetail *detail = [IssuesDetail new];
        [detail setValuesForKeysWithDictionary:dics];
//TODO:将数据写入数据库
        [mutableArr addObject:detail];
        NSLog(@"manager:%@",detail.issuesTitle);
    }
    return [mutableArr copy];

}

+ (void)dealWithDataWhereDeleted:(id)data {
    return [[self alloc]issuesTitleWhichHasDeleted:data];
}

- (void)issuesTitleWhichHasDeleted:(id)data {
    IssuesDetail *detail = data;
    NSString *issuesTitle = [NSString stringWithFormat:@"%@", detail.issuesTitle];
    [[NSNotificationCenter defaultCenter]postNotificationName:kTitleHasDeleted object:nil userInfo:@{@"issuesTitle" : issuesTitle}];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
