//
//  ViewController.m
//  JsonWithXml
//
//  Created by ZEROwolf Hwang on 2019/5/30.
//  Copyright © 2019 ZEROwolf Hwang. All rights reserved.
//

#import "XMLViewController.h"

@interface XMLViewController () <NSXMLParserDelegate>
@property(nonatomic, strong) UILabel *label;
@property(nonatomic, strong) UIButton *btn;

@end

@implementation XMLViewController


- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 400, 450)];
        _label.backgroundColor = [UIColor blackColor];
        _label.textColor = [UIColor whiteColor];
        _label.text = @"初始值";
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:24];
        _label.numberOfLines = 0;
    }
    return _label;
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 550, 250, 60)];
        _btn.backgroundColor = [UIColor blueColor];
        _btn.titleLabel.textColor = [UIColor whiteColor];
        _btn.titleLabel.font = [UIFont systemFontOfSize:30];
        [_btn setTitle:@"解析Json" forState:UIControlStateNormal];
        _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.label];
    [self.view addSubview:self.btn];


    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 620, 250, 60)];
    backBtn.backgroundColor = [UIColor blueColor];
    backBtn.titleLabel.textColor = [UIColor whiteColor];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    [backBtn setTitle:@"返回上个界面" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:backBtn];

}

- (void)backClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)btnClick {


//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ZEROwolf title" message:@"ZEROwolf content" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];

//    NSString *jsonXmlStr = @"<user>zerowolf</user>";
//    NSString *jsonXmlStr = @"<user name=\"零\">zerowolf</user>";
//    NSString *jsonXmlStr = @"<user><name>vine</name></user>";
    NSString *jsonXmlStr = @"<user><name>vine</name><name>wolf</name></user>";
    NSData *jsonData = [jsonXmlStr dataUsingEncoding:NSUTF8StringEncoding];

    NSXMLParser *parserXml = [[NSXMLParser alloc] initWithData:jsonData];
    parserXml.delegate = self;
    [parserXml parse];
}

/**
 * 开始解析
 * @param parser
 */
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    _label.text = [NSString stringWithFormat:@"%@ %@ \n", _label.text, @"parserDidStartDocument"];
}


/**
 * 准备解析当前节点
 *
 * @param parser
 * @param elementName
 * @param namespaceUri
 * @param qName
 * @param attributeDict
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceUri qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict {
//    _label.text = [NSString stringWithFormat:@"%@ \n %@ \n", _label.text, @"didStartElement"];

    //第二种类型xml
    _label.text = [NSString stringWithFormat:@"%@  解析节点名: %@ ----- %@\n", _label.text, elementName, attributeDict[@"name"]];

    //第三种类型xml
}

/// 获取首尾间节点内容
/// @param parser
/// @param string
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    _label.text = [NSString stringWithFormat:@"%@  %@ ", _label.text, @"foundCharacters"];
    _label.text = [NSString stringWithFormat:@"%@  %@ \n", _label.text, string];

}

///解析完当前节点
/// @param parser
/// @param elementName
/// @param namespaceUri
/// @param qName
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceUri qualifiedName:(nullable NSString *)qName {
    _label.text = [NSString stringWithFormat:@"%@ %@ \n", _label.text, @"didEndElement"];

}

/**
 * 解析结束
 * @param parser
 */
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    _label.text = [NSString stringWithFormat:@"%@ \n %@ \n", _label.text, @"parserDidEndDocument"];

}

@end
