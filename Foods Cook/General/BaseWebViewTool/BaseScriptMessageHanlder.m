//
//  BaseScriptMessageHanlder.m
//  Foods Cook
//
//  Created by 邓莎 on 2018/3/22.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import "BaseScriptMessageHanlder.h"
#import <WebKit/WebKit.h>

@interface BaseScriptMessageHanlder()<WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate>//用户交互代理,导航代理

@property (nonatomic, strong)BaseWebViewController *webViewController;
@property (nonatomic, strong)WKWebView *webView;

@end

@implementation BaseScriptMessageHanlder

- (instancetype)initWithWebViewController:(BaseWebViewController *)webViewController withWebView:(WKWebView *)webView{
    if (self = [super init]) {
        self.webViewController = webViewController;
        self.webView = webView;
        [self setConfig];
    }
    return self;
}

- (void)loadRequest:(NSURLRequest *)request{
    [self.webView loadRequest:request];
}

- (void)setConfig{
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"scriptMeans"];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:@"scriptMeans"]) {
        [self webCallNative:message];
    }
}

- (void)webCallNative:(WKScriptMessage *)message{
    NSString *method = [base_scriptMessageName(message) stringByAppendingString:@":"];
    if ([self respondsToSelector:NSSelectorFromString(method)]) {
        return;
    }
    [self performSelector:NSSelectorFromString(method) withObject:message afterDelay:0];
}

@end
