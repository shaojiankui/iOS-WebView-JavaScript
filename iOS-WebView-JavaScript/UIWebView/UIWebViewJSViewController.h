//
//  ViewController.h
//  WebViewJS
//
//  Created by jakey on 14-5-27.
//  Copyright (c) 2014年 www.skyfox.org All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebViewJSViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *myWeb;

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
