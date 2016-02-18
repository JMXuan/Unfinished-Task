//
//  IssuessDetailViewController.m
//  ToDoList
//
//  Created by Jack on 16/2/11.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "IssuessDetailViewController.h"
#import "UILabel+ANewLabel.h"
#import "IssuesDetail.h"
#import "DataManager.h"
@interface IssuessDetailViewController ()

@end

@implementation IssuessDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addObserverByNoti];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI:(NSString *)title issuessDetail:(NSString *)detail{
    /** 内容标题*/
    [self.navigationItem setTitle:title];
    
    /** 设置导航栏按钮*/
    UIBarButtonItem *leftBarItem = [UIBarButtonItem new];
    [leftBarItem bk_initWithTitle:@"返回" style:UIBarButtonItemStylePlain handler:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    /** 内容，用textview排版*/
    UITextView *issuesTextView = [UITextView new];
    issuesTextView.editable = NO;
    issuesTextView.text = detail;
    issuesTextView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:issuesTextView];
    [issuesTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(10);
    }];
}

#pragma mark -------------------------- NSNotification ----------------------------

/** 添加观察者：通知*/
- (void)addObserverByNoti{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(issuesDetail:) name:kNewIssuesDetail object:nil];
    NSLog(@"^^^???^^");
}

- (void)issuesDetail:(NSNotification *)noti{
    NSLog(@"^^^^^");
    NSArray *detailArr = [DataManager getIssuessDetail:noti.userInfo];
    NSLog(@"array:%@",detailArr);
    IssuesDetail *issuesDetails = detailArr[0];
    NSLog(@"noti:%@",issuesDetails.issuesTitle);
    [self setupUI:issuesDetails.issuesTitle issuessDetail:issuesDetails.issuesDetail];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
