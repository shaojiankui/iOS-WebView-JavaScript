//
//  RootViewController.h
//  WebViewJS
//
//  Created by Jakey on 16/4/10.
//  Copyright © 2016年 www.skyfox.org All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
- (IBAction)UIWebviewToJS:(id)sender;
- (IBAction)JSToUIWebview:(id)sender;


- (IBAction)WKWebViewToJS:(id)sender;
- (IBAction)JSToWKWebView:(id)sender;

- (IBAction)JSCallOC:(id)sender;
- (IBAction)OCCallJS:(id)sender;
- (IBAction)HighchartsWeb:(id)sender;
@end
