//
//  BaseScriptMessageHanlder.h
//  Foods Cook
//
//  Created by 邓莎 on 2018/3/22.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@class BaseWebViewController;

static inline id base_scriptMessageName(WKScriptMessage *message){
    return [message.body objectForKey:@"fuction"];
}

static inline id base_scriptMessageParam(WKScriptMessage *message){
    return [message.body objectForKey:@"params"];
}

@interface BaseScriptMessageHanlder : NSObject

- (instancetype)initWithWebViewController:(BaseWebViewController *)webViewController withWebView:(WKWebView *)webView;

- (void)loadRequest:(NSURLRequest *)request;

@end
