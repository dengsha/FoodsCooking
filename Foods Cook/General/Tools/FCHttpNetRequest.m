//
//  FCHttpNetRequest.m
//  Foods Cook
//
//  Created by 邓莎 on 2017/10/12.
//  Copyright © 2017年 邓莎. All rights reserved.
//

#import "FCHttpNetRequest.h"
#import "AFHTTPRequestOperationManager.h"

static NSString *const APPKey = @"a7440c57747e0f315e77cfd5bce5d038";

@implementation FCHttpNetRequest

+ (instancetype)sharedNetRequest{
    static FCHttpNetRequest *netRequest = nil;
    static dispatch_once_t onceTocken;
    dispatch_once(&onceTocken, ^{
        netRequest = [[FCHttpNetRequest alloc] init];
    });
    return netRequest;
}

- (void)getWithURLString:(NSString *)urlString parameters:(id)parameters success:(SuccessBlock)success failture:(FailtureBlock)failture{
    NSString *url = [self urlConnect:urlString];
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    [operationManager GET:url parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"请求成功");
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"请求失败");
        if (failture) {
            failture(error);
        }
    }];
}

- (void)postWithURLString:(NSString *)urlString parameters:(id)parameters success:(SuccessBlock)success failture:(FailtureBlock)failture{
    NSString *url = [self urlConnect:urlString];
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    [operationManager POST:url parameters:parameters
                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       NSLog(@"请求成功");
                       if (success) {
                           success(responseObject);
                       }
                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@"请求失败");
                       if (failture) {
                           failture(error);
                       }
                   }];
}


/**
 参数拼接

 @param url 传入的url
 @return 拼接好参数的url
 */
- (NSString *)urlConnect:(NSString *)url{
    NSString *connectUrl = @"";
    if ([url containsString:@"?"]) {
        connectUrl = [NSString stringWithFormat:@"%@&key=%@",url,APPKey];
    }else{
        connectUrl = [NSString stringWithFormat:@"%@?key=%@",url,APPKey];
    }
    return connectUrl;
}

@end
