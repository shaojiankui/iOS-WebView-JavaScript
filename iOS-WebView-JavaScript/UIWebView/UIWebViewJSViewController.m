//
//  ViewController.m
//  WebViewJS
//
//  Created by jakey on 14-5-27.
//  Copyright (c) 2014年 www.skyfox.org All rights reserved.
//

#import "UIWebViewJSViewController.h"
@interface UIWebViewJSViewController ()

@end

@implementation UIWebViewJSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"UIWebView调用JS";

    self.view.backgroundColor = [UIColor grayColor];
    self.someString = @"UIWebView是iOS最常用的SDK之一，它有一个stringByEvaluatingJavaScriptFromString方法可以将javascript嵌入页面中，通过这个方法我们可以在iOS中与UIWebView中的网页元素交互";
  

    [self loadTouched:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadTouched:(id)sender {
    [self loadHtml:@"UIWebViewJS"];
}
//执行已经存在的js方法
- (IBAction)exeFuncTouched:(id)sender {
    [self.myWeb stringByEvaluatingJavaScriptFromString:@"showAlert(\"hahahha\");"];  
}

//插入html    getElementsByTagName 根据html自带标签定位元素
- (IBAction)insertHtmTouched:(id)sender {
    //插入整个页面内容
    // document.getElementsByTagName('body')[0];"
    
    //替换第一个P元素内容
    NSString *tempString = [NSString stringWithFormat:@"document.getElementsByTagName('p')[0].innerHTML ='%@';",self.someString];
    [self.myWeb stringByEvaluatingJavaScriptFromString:tempString];
    
}


// 插入html       根据getElementById 定位元素
- (IBAction)insertDivHtml:(id)sender {
    
    //替换第id为idtest的DIV元素内容
    NSString *tempString2 = [NSString stringWithFormat:@"document.getElementById('idTest').innerHTML ='%@';",self.someString];
    [self.myWeb stringByEvaluatingJavaScriptFromString:tempString2];
    
}


//修改input值      getElementsByName根据标签名称获取定位元素
- (IBAction)inputButtonTouched:(id)sender {
    NSString *tempString = [NSString stringWithFormat:@"document.getElementsByName('wd')[0].value='%@';",self.someString];
    [self.myWeb stringByEvaluatingJavaScriptFromString:tempString];
}

//插入js 并且执行传值
- (IBAction)insertJSTouched:(id)sender {
    NSString *insertString = [NSString stringWithFormat:
                              @"var script = document.createElement('script');"
                              "script.type = 'text/javascript';"
                              "script.text = \"function jsFunc() { "
                              "var a=document.getElementsByTagName('body')[0];"
                              "alert('%@');"
                              "}\";"
                              "document.getElementsByTagName('head')[0].appendChild(script);", self.someString];
    
    NSLog(@"insert string %@",insertString);
    [self.myWeb stringByEvaluatingJavaScriptFromString:insertString];
    [self.myWeb  stringByEvaluatingJavaScriptFromString:@"jsFunc();"];
}

- (IBAction)submitTouched:(id)sender {
    
    [self.myWeb stringByEvaluatingJavaScriptFromString:@"document.forms[0].submit(); "];
}
//替换图片地址
- (IBAction)replaceImgSrc:(id)sender {
    NSString *tempString2 = [NSString stringWithFormat:@"document.getElementsByTagName('img')[0].src ='%@';",@"light_advice.png"];
    [self.myWeb stringByEvaluatingJavaScriptFromString:tempString2];
}
//修改标签字体
- (IBAction)fontTouched:(id)sender {
     NSString *tempString2 = [NSString stringWithFormat:@"document.getElementsByTagName('p')[0].style.fontSize='%@';",@"19px"];
    [self.myWeb stringByEvaluatingJavaScriptFromString:tempString2];

}
//定位
- (IBAction)locationTouched:(id)sender {
    [self loadHtml:@"UIWebViewJS_location"];
}
//浏览文件
- (IBAction)uploadTouched:(id)sender {
    [self loadHtml:@"UIWebViewJS_file"];
}

-(void)loadHtml:(NSString*)name{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:name ofType:@"html"];
    
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.myWeb loadRequest:request];
}

@end
