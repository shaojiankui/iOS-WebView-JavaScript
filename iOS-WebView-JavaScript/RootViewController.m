//
//  RootViewController.m
//  WebViewJS
//
//  Created by Jakey on 16/4/10.
//  Copyright © 2016年 www.skyfox.org All rights reserved.
//

#import "RootViewController.h"
#import "UIWebViewJSViewController.h"
#import "WKWebViewJSViewController.h"

#import "JSUIWebViewViewController.h"
#import "JSWKWebViewViewController.h"

#import "JSCallOCViewController.h"
#import "OCCallJSViewController.h"
#import "HighchartsWebViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"WebView&JavaScript的交互通信";
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

- (IBAction)UIWebviewToJS:(id)sender {
    UIWebViewJSViewController *webView = [[UIWebViewJSViewController alloc]initWithNibName:@"UIWebViewJSViewController" bundle:nil];
    [self.navigationController pushViewController:webView animated:YES];
}

- (IBAction)JSToUIWebview:(id)sender {
    JSUIWebViewViewController *js = [[JSUIWebViewViewController alloc]init];
    [self.navigationController pushViewController:js animated:YES];
}

- (IBAction)WKWebViewToJS:(id)sender {
    WKWebViewJSViewController *webView = [[WKWebViewJSViewController alloc]initWithNibName:@"WKWebViewJSViewController" bundle:nil];
    [self.navigationController pushViewController:webView animated:YES];
}

- (IBAction)JSToWKWebView:(id)sender {
    JSWKWebViewViewController *js = [[JSWKWebViewViewController alloc]init];
    [self.navigationController pushViewController:js animated:YES];
}



- (IBAction)JSCallOC:(id)sender {
    JSCallOCViewController *jsCallOC = [[JSCallOCViewController alloc]init];
    [self.navigationController pushViewController:jsCallOC animated:YES];
}

- (IBAction)OCCallJS:(id)sender {
    OCCallJSViewController *ocCallJS = [[OCCallJSViewController alloc]init];
    [self.navigationController pushViewController:ocCallJS animated:YES];
}

- (IBAction)HighchartsWeb:(id)sender {
    HighchartsWebViewController *highchartsWeb =[[HighchartsWebViewController alloc]init];
    [self.navigationController pushViewController:highchartsWeb animated:YES];
}
@end
