//
//  MainViewController.m
//  ToDoList
//
//  Created by Jack on 16/2/10.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "MainViewController.h"
#import "AddIssuesViewController.h"
#import "IssuessDetailViewController.h"
#import "IssuesDetail.h"
#import "DataManager.h"
@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
/** 用于存储待办事项数据的数组*/
@property (nonatomic, strong) NSMutableArray *issuesArr;
/** 显示是否有待办事项*/
@property (nonatomic) BOOL ifBackLog;
/** 无待办事项时显示的标签*/
@property (nonatomic, strong) UILabel *noneLabel;

@end

@implementation MainViewController

- (NSMutableArray *)issuesArr {
    if(_issuesArr == nil) {
        _issuesArr = [[NSMutableArray alloc] init];
    }
    return _issuesArr;
}

- (UILabel *)noneLabel {
    if(_noneLabel == nil) {
        _noneLabel = [[UILabel alloc] init];
        _noneLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1];
        _noneLabel.text = @"点击右上角 ➕ 添加待办事项";
        _noneLabel.textAlignment = NSTextAlignmentCenter;
        _noneLabel.font = [UIFont systemFontOfSize:20];
        [self.view addSubview:_noneLabel];
        [_noneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.view);
        }];
    }
    return _noneLabel;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.opaque = YES;
        _tableView.tableFooterView = [UIView new];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(64);
            make.left.right.bottom.mas_equalTo(self.view);
        }];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObserverByNotification];;
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.issuesArr.count != 0) {
        self.ifBackLog = YES;
        self.tableView.hidden = NO;
    }else{
        [self noneLabel];
    }
    [self setupNavi];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -------------UITableView Delegate / DataSource--------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return self.issuesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    IssuesDetail *detail = self.issuesArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"cellTags"];
    cell.textLabel.text = detail.issuesTitle;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[IssuessDetailViewController new] animated:YES];
    /** 将选中的事件传递至下一个界面*/
    IssuesDetail *detail = self.issuesArr[indexPath.row];
    [[NSNotificationCenter defaultCenter]postNotificationName:kNewIssuesDetail object:nil userInfo:@{@"issuesTitle" : detail.issuesTitle, @"issuesDetail" : detail.issuesDetail}];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.issuesArr.count != 0) {
        /** 将被删除的数据传输给 Manager*/
        [DataManager dealWithDataWhereDeleted:self.issuesArr[indexPath.row]];
        [self.issuesArr removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationFade];
        if (self.issuesArr.count == 0) {
            self.tableView.hidden = YES;
            [self noneLabel];
        }
    }
    NSLog(@"%lu",(unsigned long)self.issuesArr.count);
}

#pragma mark ------------------------ NSNotification ------------------------
    /** 添加观察者，接收通知*/
- (void)addObserverByNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didAddNewIssues:) name:kCofirmNewIssues object:nil];
}

- (void)didAddNewIssues:(NSNotification *)notification{
    [self.issuesArr addObjectsFromArray:[DataManager getIssuessDetail:notification.userInfo]];
    NSLog(@"self.arr:%lu",self.issuesArr.count);
    self.tableView.hidden = NO;
    [self.tableView reloadData];
                                 
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -------------------NavigationController-----------------------

- (void)setupNavi{
    self.navigationItem.title = @"待办事项";
    /** 点击按钮添加事项*/
    UIBarButtonItem *addIssuesItem = [UIBarButtonItem new];
    [addIssuesItem bk_initWithBarButtonSystemItem:UIBarButtonSystemItemAdd handler:^(id sender) {
        [self.navigationController pushViewController:[AddIssuesViewController new] animated:YES];
    }];
    self.navigationItem.rightBarButtonItem = addIssuesItem;
    
//    /** 点击按钮表格进入编辑模式*/
//    UIBarButtonItem *editItem = [UIBarButtonItem new];
//    [editItem bk_initWithBarButtonSystemItem:UIBarButtonSystemItemEdit handler:^(id sender) {
//        if (self.issuesArr.count != 0) {
//            self.tableView.editing = !self.tableView.editing;
//        }
//    }];
////TODO:修改左上侧的图片样式，添加图片
//    self.navigationItem.leftBarButtonItem = editItem;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}




@end
