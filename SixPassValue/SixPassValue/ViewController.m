//
//  ViewController.m
//  SixPassValue
//
//  Created by ZEROwolf Hwang on 2019-05-30.
//  Copyright © 2019 ZEROwolf. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
#import "DefaultInstance.h"


@interface ViewController ()<passValueDelegate,OutDelegate>

@property(nonatomic, strong) UILabel *label1;
@property(nonatomic, strong) UIButton *btn1;

@end

@implementation ViewController


- (UILabel *)label1 {
    if (_label1 == nil) {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 60)];
        _label1.backgroundColor = [UIColor blackColor];
        _label1.textColor = [UIColor whiteColor];
        _label1.text = @"初始值";
        _label1.textAlignment = NSTextAlignmentCenter;
        _label1.font = [UIFont systemFontOfSize:24];
    }
    return _label1;
}

- (UIButton *)btn1 {
    if (_btn1 == nil) {
        _btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 60)];
        _btn1.backgroundColor = [UIColor blueColor];
        _btn1.titleLabel.textColor = [UIColor whiteColor];
        _btn1.titleLabel.font = [UIFont systemFontOfSize:30];
        [_btn1 setTitle:@"跳转至界面2" forState:UIControlStateNormal];
        _btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_btn1 addTarget:self action:@selector(btnClick  ) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
}

- (void)btnClick {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ZEROwolf title" message:@"ZEROwolf content" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];

    NextViewController *nextVc = [[NextViewController alloc] init];

    nextVc.str = @"属性传值";

    [DefaultInstance sharedInstance].str = @"单例传值";

    [[NSUserDefaults standardUserDefaults] setObject:@"NSUserDefaults传值" forKey:@"zero"];
    [[NSUserDefaults standardUserDefaults] synchronize];


    //代理传值 --- 设置代理关系
    nextVc.passDelegate = self;
    nextVc.outDelegate = self;

    //block传值 --- 实现block --- 接收来自页面2的值
    nextVc.block = ^(NSString *str){
        self.label1.text = str;
    };


    //通知传值 --- 添加监听 --- 等待其他页面的传值
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyHandle:) name:@"notify" object:nil];

    [self presentViewController:nextVc animated:YES completion:nil];

}

//接收到通知之后的处理 --- notyfication:通知
- (void)notifyHandle:(NSNotification *)notification {
    self.label1.text = notification.userInfo[@"doc"];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.label1];
    [self.view addSubview:self.btn1];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

//    _label.text = self.str;
    NSLog(@"viewWillAppear");
//    //单例传值 --- 反向接收
//    _label.text = [DefaultInstance sharedInstance].str;
//    //NSUserDefaults传值 --- 反向接收
//    int wolf = [[[NSUserDefaults standardUserDefaults] objectForKey:@"wolf"] intValue];
//    _label.text = [NSString stringWithFormat:@"%d", wolf];

}

//代理传值  --  实现协议方法
- (void)passValue:(NSString *)string {
    _label1.text = string;
    NSLog(@"%@", string);
    NSLog(@"string = %@", string);
}

//代理传值  --  实现协议方法(单独外部创建的代理)
-(void)outPassValue:(NSString *)str {
    _label1.text = str;
    NSLog(@"string = %@", str);
}

@end
