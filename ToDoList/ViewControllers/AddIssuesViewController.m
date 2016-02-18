//
//  AddIssuesViewController.m
//  ToDoList
//
//  Created by Jack on 16/2/11.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "AddIssuesViewController.h"
#import "DatePickerView.h"
@interface AddIssuesViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UITextField *titleTextFiled;
@property (nonatomic, strong) UITextView *issuesTextView;

@end

@implementation AddIssuesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    [self setupNavi];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 设置输入的文本框：textView
    确定按钮；
 */

- (void)setupUI{
    //TODO:设置输入的标题和内容不能为空
    /** 标题*/
    UILabel *titleLabel = [[UILabel alloc]init];
//    titleLabel.backgroundColor = [UIColor blackColor];
    titleLabel.text = @"标题";
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(74);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(30);
    }];
    
    UITextField *titleTextField = [[UITextField alloc]init];
    titleTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:titleTextField];
    [titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel);
        make.left.mas_equalTo(titleLabel.mas_right).mas_equalTo(5);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 60, 30));
    }];
    self.titleTextFiled = titleTextField;
    
    UILabel *textLabel = [UILabel new];
    textLabel.text = @"事项";
    [self.view addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleTextField.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(titleLabel);
        make.height.mas_equalTo(30);
    }];
    /** 编辑内容的textView*/
    UITextView *issuesTextView = [[UITextView alloc]init];
    [self.view addSubview:issuesTextView];
    [issuesTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleTextField.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(textLabel.mas_right).mas_equalTo(0);
        make.right.mas_equalTo(titleTextField);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_equalTo(-290);
    }];
    
    issuesTextView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    issuesTextView.textColor = [UIColor blackColor];
    issuesTextView.font = [UIFont systemFontOfSize:18];
    issuesTextView.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.issuesTextView = issuesTextView;
    
    /** 添加时间选择器 */
    UIView *pickerView = [DatePickerView new];
    [self.view addSubview:pickerView];
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(issuesTextView.mas_bottom).mas_equalTo(2);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 50));
    }];
    
    
    /** 确定添加内容并返回上页*/
    UIButton *confirmBtn = [UIButton new];
    [confirmBtn setTintColor:[UIColor blueColor]];
    [self.view addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pickerView.mas_bottom).mas_equalTo(10);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    pickerView.backgroundColor = [UIColor lightGrayColor];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    /** 点击按钮后返回上一页，并将输入的内容反馈给上页
     返回上页的时候，发送通知，告知输入的标题及内容；
     */
    [confirmBtn bk_addEventHandler:^(id sender) {
        /** 判断有否输入内容 */
        if ([self.titleTextFiled.text isEqualToString:@""]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入待办事项" message:@"请输入标题" preferredStyle:UIAlertControllerStyleAlert]
            ;
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            [self sendNotification];
            [self.view endEditing:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }

    } forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)sendNotification{
    [[NSNotificationCenter defaultCenter]postNotificationName:kCofirmNewIssues object:nil userInfo:@{@"issuesTitle" : self.titleTextFiled.text, @"issuesDetail" : self.issuesTextView.text}];
}


- (void)setupNavi{
    [self.navigationItem setTitle:@"添加待办事项"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backToMainViewController)];
}

- (void)backToMainViewController{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
