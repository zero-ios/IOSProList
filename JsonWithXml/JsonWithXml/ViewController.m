//
//  ViewController.m
//  JsonWithXml
//
//  Created by ZEROwolf Hwang on 2019/5/30.
//  Copyright © 2019 ZEROwolf Hwang. All rights reserved.
//

#import "ViewController.h"
#import "XMLViewController.h"

@interface ViewController ()
@property(nonatomic, strong) UIButton *fileBtn1;
@property(nonatomic, strong) UIButton *webJsonBtn1;
@property(nonatomic, strong) UILabel *label1;
@property(nonatomic, strong) UIButton *btn1;

@end

@implementation ViewController


- (UILabel *)label1 {
    if (!_label1) {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 250, 250)];
        _label1.backgroundColor = [UIColor blackColor];
        _label1.textColor = [UIColor whiteColor];
        _label1.text = @"初始值";
        _label1.textAlignment = NSTextAlignmentCenter;
        _label1.font = [UIFont systemFontOfSize:24];
        _label1.numberOfLines = 0;
    }
    return _label1;
}

- (UIButton *)btn1 {
    if (!_btn1) {
        _btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 350, 250, 60)];
        _btn1.backgroundColor = [UIColor blueColor];
        _btn1.titleLabel.textColor = [UIColor whiteColor];
        _btn1.titleLabel.font = [UIFont systemFontOfSize:30];
        [_btn1 setTitle:@"解析Json" forState:UIControlStateNormal];
        _btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_btn1 addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
}


- (UIButton *)fileBtn1 {
    if (_fileBtn1 == nil) {
        _fileBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 450, 250, 60)];
        _fileBtn1.backgroundColor = [UIColor blueColor];
        _fileBtn1.titleLabel.textColor = [UIColor whiteColor];
        _fileBtn1.titleLabel.font = [UIFont systemFontOfSize:30];
        [_fileBtn1 setTitle:@"解析本地的Json文件" forState:UIControlStateNormal];
        [_fileBtn1 addTarget:self action:@selector(fileBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fileBtn1;
}

- (UIButton *)webJsonBtn1 {
    if (_webJsonBtn1 == nil) {
        _webJsonBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 550, 250, 60)];
        _webJsonBtn1.backgroundColor = [UIColor blueColor];
        _webJsonBtn1.titleLabel.textColor = [UIColor whiteColor];
        _webJsonBtn1.titleLabel.font = [UIFont systemFontOfSize:30];
        [_webJsonBtn1 setTitle:@"解析url的json" forState:UIControlStateNormal];
        [_webJsonBtn1 addTarget:self action:@selector(webBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _webJsonBtn1;
}

/**
 * 从网络加载Json
 */
- (void)webBtnClick {

    NSString *urlStr = @"https://suggest.taobao.com/sug?code=utf-8&q=weiyi";
    NSURL *url = [NSURL URLWithString:urlStr];

    //加载方式1
    NSString *jsonStr1 = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSData *webJson = [jsonStr1 dataUsingEncoding:NSUTF8StringEncoding];

    //加载方式2
    NSData *webJson2 = [NSData dataWithContentsOfURL:url];

    //加载方式3
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSData *webJson3 = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

    id jsonObj = [NSJSONSerialization JSONObjectWithData:webJson3 options:NSJSONReadingAllowFragments error:nil];

    NSArray *arrayInfo = jsonObj[@"result"];

    for (NSArray *item in arrayInfo) {
        _label1.text = [NSString stringWithFormat:@"%@ \n %@ \n %@", _label1.text, item[0], item[1]];
    }
}

/**
 * 从json文件中读取
 */
- (void)fileBtnClick {
    NSString *fileStr = nil;
//    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"User" ofType:@"json"];
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"User.json" ofType:nil];

    NSFileManager *manager = [NSFileManager defaultManager];

    if ([manager fileExistsAtPath:jsonPath]) {
        fileStr = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
        NSData *jsonData = [fileStr dataUsingEncoding:NSUTF8StringEncoding];
        id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];

        NSDictionary *userInfo = jsonObj[@"userInfo"];
        _label1.text = [NSString stringWithFormat:@"%@ \n %@ \n %d \n %@ \n %@ ", jsonObj[@"date"], userInfo[@"name"], [userInfo[@"age"] intValue],
                                                 userInfo[@"sex"], userInfo[@"hobby"]];


    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ZEROwolf title" message:@"该路径下不存在User.json文件" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (void)btnClick {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ZEROwolf title" message:@"ZEROwolf content" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];

    NSString *jsonStr = @"{\"name\":\"ZEROwolf\",\"age\":\"27\"}";

    NSString *jsonTreeStr = @"{\"user\":{\"name\":\"ZEROwolf\",\"age\":\"27\"}}";

    NSString *jsonArrStr = @"[{\"name\":\"zero\"},{\"name\":\"wolf\"}]";

    NSData *jsonData = [jsonArrStr dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];

    if ([jsonObj isKindOfClass:[NSDictionary class]]) {

        NSDictionary *user = [jsonObj objectForKey:@"user"];

        NSString *name = user[@"name"];
        NSString *age = user[@"age"];

        _label1.text = [NSString stringWithFormat:@"%@ \n %@ \n %d", name, age, 10];

    } else if ([jsonObj isKindOfClass:[NSArray class]]) {
        NSArray *array = jsonObj;
        for (NSDictionary *dic in array) {
            _label1.text = [NSString stringWithFormat:@"%@ \n %@", _label1.text, dic[@"name"]];
        }
    }

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.fileBtn1];
    [self.view addSubview:self.webJsonBtn1];
    [self.view addSubview:self.label1];
    [self.view addSubview:self.btn1];


    UIButton *xmlBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 650, 250, 60)];
    xmlBtn.backgroundColor = [UIColor blueColor];
    xmlBtn.titleLabel.textColor = [UIColor whiteColor];
    xmlBtn.titleLabel.font = [UIFont systemFontOfSize:30];
            [xmlBtn setTitle:@"跳转至界面2" forState:UIControlStateNormal];
            [xmlBtn addTarget:self action:@selector(xmlBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:xmlBtn];

}

- (void)xmlBtnClick:(id)xmlBtnClick {
    XMLViewController *xmlVc = [XMLViewController new];
    [self presentViewController:xmlVc animated:YES completion:nil];
}


@end
