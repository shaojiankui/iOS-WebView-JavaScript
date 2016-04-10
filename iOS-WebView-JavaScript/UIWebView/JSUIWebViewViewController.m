//
//  JSUIWebViewViewController.m
//  WebViewJS
//
//  Created by Jakey on 16/4/10.
//  Copyright © 2016年 www.skyfox.org All rights reserved.
//

#import "JSUIWebViewViewController.h"

@interface JSUIWebViewViewController ()

@end

@implementation JSUIWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"JS调用UIWebView";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self loadTouched:nil];

}
- (IBAction)loadTouched:(id)sender {
    [self loadHtml:@"JSUIWebView"];
    for (UIView *view in self.view.subviews) {
        if (view.tag == 11111) {
            [view removeFromSuperview];
        }
    }
    //  [[self.view viewWithTag:11111] removeFromSuperview];

}
- (void)webViewDidFinishLoad: (UIWebView *) webView
{
    //重定义web的alert方法,捕获webview弹出的原生alert  可以修改标题和内容等等
    [webView stringByEvaluatingJavaScriptFromString:@"window.alert = function(message) { window.location = \"myapp:&func=alert&message=\" + message; }"];
}
#pragma mark --
#pragma mark UIWebViewDelegate
/*
 * 方法的返回值是BOOL值。
 * 返回YES：表示让浏览器执行默认操作，比如某个a链接跳转
 * 返回NO：表示不执行浏览器的默认操作，这里因为通过url协议来判断js执行native的操作，肯定不是浏览器默认操作，故返回NO
 *
 */

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *requestString = [[[request URL]  absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    if ([requestString hasPrefix:@"myapp:"]) {
        NSLog(@"requestString:%@",requestString);
        //如果是自己定义的协议, 再截取协议中的方法和参数, 判断无误后在这里手动调用oc方法
        NSMutableDictionary *param = [self queryStringToDictionary:requestString];
        NSLog(@"get param:%@",[param description]);
        
        NSString *func = [param objectForKey:@"func"];
        
        //调用本地函数1
        if([func isEqualToString:@"addSubView"])
        {
            Class tempClass =  NSClassFromString([param objectForKey:@"view"]);
            CGRect frame = CGRectFromString([param objectForKey:@"frame"]);
            
            if(tempClass && [tempClass isSubclassOfClass:[UIWebView class]])
            {
                UIWebView *tempObj = [[tempClass alloc] initWithFrame:frame];
                tempObj.tag = [[param objectForKey:@"tag"] integerValue];
                
                NSURL *url = [NSURL URLWithString:[param objectForKey:@"urlstring"]];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                [tempObj loadRequest:request];
                [self.myWebView addSubview:tempObj];
            }
        }
        //调用本地函数2
        else if([func isEqualToString:@"alert"])
        {
            [self showMessage:@"来自网页的提示" message:[param objectForKey:@"message"]];
            
        }
        //调用本地函数3
        else if([func isEqualToString:@"callFunc"])
        {
            [self testFunc:[param objectForKey:@"first"] withParam2:[param objectForKey:@"second"]  andParam3:[param objectForKey:@"third"] ];
            
        }
        //调用本地函数4
        else if([func isEqualToString:@"testFunc"])
        {
            [self testFunc:[param objectForKey:@"param1"] withParam2:[param objectForKey:@"param2"]  andParam3:[param objectForKey:@"param3"] ];
            
        }
        
        return NO;
        
        
    }
    return YES;
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
    [elements removeObjectAtIndex:0];
    NSMutableDictionary *retval = [NSMutableDictionary dictionaryWithCapacity:[elements count]];
    for(NSString *e in elements) {
        NSArray *pair = [e componentsSeparatedByString:@"="];
        [retval setObject:[pair objectAtIndex:1] forKey:[pair objectAtIndex:0]];
    }
    return retval;
}
@end
