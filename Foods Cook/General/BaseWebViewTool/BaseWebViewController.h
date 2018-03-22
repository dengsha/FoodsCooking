//
//  BaseWebViewController.h
//  Foods Cook
//
//  Created by 邓莎 on 2018/3/22.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface BaseWebViewController : UIViewController

@property (nonatomic, strong, readonly)WKWebView *webView;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithUrl:(NSString *)urlString andParams:(NSDictionary *)params;

@end
