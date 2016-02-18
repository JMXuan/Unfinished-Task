//
//  IssuesDetail.h
//  ToDoList
//
//  Created by Jack on 16/2/11.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IssuesDetail : NSObject

/** 事件标题*/
@property (nonatomic, strong) NSString *issuesTitle;
/** 事件详细*/
@property (nonatomic, strong) NSString *issuesDetail;

@end
