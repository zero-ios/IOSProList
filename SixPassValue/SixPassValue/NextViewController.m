#import "NextViewController.h"
#import "ViewController.h"
#import "DefaultInstance.h"
#import "OutDelegate.h"

@interface NextViewController ()

@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UIButton *btn;

@end

@implementation NextViewController


- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 60)];
        _textField.backgroundColor = [UIColor blackColor];
        _textField.textColor = [UIColor whiteColor];
        _textField.font = [UIFont systemFontOfSize:24];
    }
    return _textField;
}



- (UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 60)];
        _btn.backgroundColor = [UIColor blueColor];
        _btn.titleLabel.textColor = [UIColor whiteColor];
        _btn.titleLabel.font = [UIFont systemFontOfSize:30];
        [_btn setTitle:@"跳转返回界面1" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)btnClick {
    [[ViewController alloc] init].str = @"属性传值返回";

    [DefaultInstance sharedInstance].str = @"单例传值--反向";

    [[NSUserDefaults standardUserDefaults] setInteger:34 forKey:@"wolf"];
    [[NSUserDefaults standardUserDefaults] synchronize];


    [self.passDelegate passValue:@"代理传值 -- 反向"];
    [self.outDelegate outPassValue:self.textField.text];

    self.block(@"block返回的值");

    //通知传值 --- 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notify" object:nil userInfo:@{@"doc": @"界面2发送的通知"}];

    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.textField];

    [self.view addSubview:self.btn];

    //属性传值 --- 正向
    _textField.text = self.str;

    //单例传值 --- 正向
    _textField.text = [DefaultInstance sharedInstance].str;

    //NSUserDefaults传值 --- 正向
    NSString *zero = [[NSUserDefaults standardUserDefaults] objectForKey:@"zero"];
    _textField.text = zero;
}


@end
