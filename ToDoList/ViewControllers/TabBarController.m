//
//  TabBarController.m
//  ToDoList
//
//  Created by Jack on 16/2/10.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "TabBarController.h"

#import "MainViewController.h"
@interface TabBarController ()
@property (nonatomic, strong) MainViewController *MainController;

@end

@implementation TabBarController

- (MainViewController *)MainController {
    if(_MainController == nil) {
        _MainController = [[MainViewController alloc] init];
    }
    return _MainController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINavigationController *mainNavi = [[UINavigationController alloc]initWithRootViewController:self.MainController];

    self.viewControllers = @[mainNavi];
    
    [self.MainController.tabBarItem setTitle:@"main"];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
