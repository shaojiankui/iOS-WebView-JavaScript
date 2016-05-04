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
    if ([message.name isEqualToString:@"Native"]) {
        NSLog(@"message.body:%@", message.body);
        //如果是自己定义的协议, 再截取协议中的方法和参数, 判断无误后在这里手动调用oc方法
        NSMutableDictionary *param = [self queryStringToDictionary:message.body];
        NSLog(@"get param:%@",[param description]);
        
        NSString *func = [param objectForKey:@"func"];
        
        //调用本地函数
        if([func isEqualToString:@"alert"])
        {
            [self showMessage:@"来自网页的提示" message:[param objectForKey:@"message"]];
        }
     
    }
}
-(void)testFunc:(NSString*)param1 withParam2:(NSString*)param2 andParam3:(NSString*)param3{
    NSLog(@"%@ %@ %@",param1,param2,param3);
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
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
    
}
//get参数转字典
- (NSMutableDictionary*)queryStringToDictionary:(NSString*)string {
    NSMutableArray *elements = (NSMutableArray*)[string componentsSeparatedByString:@"&"];
    NSMutableDictionary *retval = [NSMutableDictionary dictionaryWithCapacity:[elements count]];
    for(NSString *e in elements) {
        NSArray *pair = [e componentsSeparatedByString:@"="];
        [retval setObject:[pair objectAtIndex:1] forKey:[pair objectAtIndex:0]];
    }
    return retval;
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






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
