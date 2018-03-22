//
//  BaseWebViewController.m
//  Foods Cook
//
//  Created by 邓莎 on 2018/3/22.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import "BaseWebViewController.h"
#import <WebKit/WebKit.h>
#import "BaseScriptMessageHanlder.h"

@interface BaseWebViewController ()

@property (nonatomic, strong)WKWebView *webView;
@property (nonatomic, strong)BaseScriptMessageHanlder *messageHandler;
@property (nonatomic, copy)NSString *urlString;
@property (nonatomic, strong)NSDictionary *params;

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addKVOAbserve];
}

- (instancetype)initWithUrl:(NSString *)urlString andParams:(NSDictionary *)params{
    if (self = [super init]) {
        self.urlString = urlString;
        self.params = params;
        [self loadWebView];
    }
    return self;
}

- (void)loadWebView{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlString]];
    [self.messageHandler loadRequest:request];
}

- (void)addKVOAbserve{
    ///监听加载进度
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    ///监听title
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    ///监听是否可以返回
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        [self updateEstimatedBar];
    }
    if ([keyPath isEqualToString:@"title"]) {
        [self updateTitle];
    }
    if ([keyPath isEqualToString:@"canGoBack"]) {
        [self updateLeftButtonItems];
    }
}

#pragma mark private

- (void)updateEstimatedBar{
    
}

- (void)updateTitle{
    
}

- (void)updateLeftButtonItems{
    
}

#pragma mark lazyInit
- (WKWebView *)webView{
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        WKPreferences *prefrence = [[WKPreferences alloc] init];
        prefrence.javaScriptCanOpenWindowsAutomatically = NO;
        config.preferences = prefrence;
        NSMutableString *javascript = [NSMutableString string];
        ///禁止网页的长按
        [javascript appendString:@"document.documentElement.style.webkitTouchCallout='none';"];
        [javascript appendString:@"document.documentElement.style.webkitUserSelect='none';"];
        WKUserScript *script = [[WKUserScript alloc] initWithSource:javascript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        [config.userContentController addUserScript:script];
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    }
    return _webView;
}

- (BaseScriptMessageHanlder *)messageHandler{
    if (!_messageHandler) {
        _messageHandler = [[BaseScriptMessageHanlder alloc] initWithWebViewController:self withWebView:self.webView];
    }
    return _messageHandler;
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

@end
