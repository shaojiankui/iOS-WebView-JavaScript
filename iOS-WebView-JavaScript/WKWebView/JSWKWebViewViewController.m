//
//  JSWKWebViewViewController.m
//  WebViewJS
//
//  Created by Jakey on 16/4/10.
//  Copyright © 2016年 www.skyfox.org All rights reserved.
//

#import "JSWKWebViewViewController.h"

@interface JSWKWebViewViewController ()

@end

@implementation JSWKWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"JS调用WKWebView";
    // Do any additional setup after loading the view from its nib.
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = [[WKUserContentController alloc] init];
    // 注入JS对象Native，
    // 声明WKScriptMessageHandler 协议
    [config.userContentController addScriptMessageHandler:self name:@"Native"];
    //本人喜欢只定义一个MessageHandler协议 当然可以定义其他MessageHandler协议
    [config.userContentController addScriptMessageHandler:self name:@"Pay"];

    self.myWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    self.myWebView.UIDelegate = self;
    [self.view addSubview:self.myWebView];
    [self loadTouched:nil];
}

- (IBAction)loadTouched:(id)sender {
    [self loadHtml:@"JSWKWebView"];
}
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSDictionary *bodyParam = (NSDictionary*)message.body;
    NSString *func = [bodyParam objectForKey:@"function"];
    
    NSLog(@"MessageHandler Name:%@", message.name);
    NSLog(@"MessageHandler Body:%@", message.body);
    NSLog(@"MessageHandler Function:%@",func);

    //本人喜欢只定义一个MessageHandler协议 当然可以定义其他MessageHandler协议
    
    if ([message.name isEqualToString:@"Native"])
    {
        NSDictionary *parameters = [bodyParam objectForKey:@"parameters"];
        //调用本地函数1
        if([func isEqualToString:@"addSubView"])
        {
            Class tempClass =  NSClassFromString([parameters objectForKey:@"view"]);
            CGRect frame = CGRectFromString([parameters objectForKey:@"frame"]);
            
            if(tempClass && [tempClass isSubclassOfClass:[UIWebView class]])
            {
                UIWebView *tempObj = [[tempClass alloc] initWithFrame:frame];
                tempObj.tag = [[parameters objectForKey:@"tag"] integerValue];
                
                NSURL *url = [NSURL URLWithString:[parameters objectForKey:@"urlstring"]];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                [tempObj loadRequest:request];
                [self.myWebView addSubview:tempObj];
            }
        }
        //调用本地函数2
        else if([func isEqualToString:@"alert"])
        {
            [self showMessage:@"来自网页的提示" message:[parameters description]];
            
        }
        //调用本地函数3
        else if([func isEqualToString:@"callFunc"])
        {
            
        }
        //调用本地函数4
        else if([func isEqualToString:@"testFunc"])
        {
           
            
        }
     
    }
    else if ([message.name isEqualToString:@"Pay"]) {
        //如果是自己定义的协议, 再截取协议中的方法和参数, 判断无误后在这里进行逻辑处理
        
    } else if ([message.name isEqualToString:@"dosomething"]) {
        //........
        
        
    }

}



-(void)loadHtml:(NSString*)name{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:name ofType:@"html"];
    
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.myWebView loadRequest:request];
}

-(void)showMessage:(NSString *)title message:(NSString *)message;
{
    if (message == nil)
    {
        return;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:[message description]
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
    
}

#pragma mark - WKUIDelegate
- (void)webViewDidClose:(WKWebView *)webView {
    NSLog(@"%s", __FUNCTION__);
}
//uiwebview 中这个方法是私有方法 通过category可以拦截alert
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {

    NSLog(@"%s", __FUNCTION__);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}



@end
