//
//  WKWebViewViewController.h
//  WebViewJS
//
//  Created by Jakey on 16/4/10.
//  Copyright © 2016年 www.skyfox.org All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface WKWebViewJSViewController : UIViewController<WKUIDelegate>
@property (strong, nonatomic)  WKWebView *myWebView;

@property (strong, nonatomic) NSString  *someString;

- (IBAction)loadTouched:(id)sender;
- (IBAction)exeFuncTouched:(id)sender;
- (IBAction)insertHtmTouched:(id)sender;
- (IBAction)inputButtonTouched:(id)sender;
- (IBAction)insertJSTouched:(id)sender;
- (IBAction)insertDivHtml:(id)sender;
- (IBAction)submitTouched:(id)sender;
- (IBAction)replaceImgSrc:(id)sender;
- (IBAction)fontTouched:(id)sender;
- (IBAction)locationTouched:(id)sender;
- (IBAction)uploadTouched:(id)sender;
@end
