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

#pragma mark WKNavigationDelegate
///页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}

///加载完成之后
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}

///加载失败之后
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
}

///在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
}

@end
