//
//  FCHttpNetRequest.h
//  Foods Cook
//
//  Created by 邓莎 on 2017/10/12.
//  Copyright © 2017年 邓莎. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 请求成功回调

 @param responseObject 返回的求情成功数据
 */
typedef void(^SuccessBlock)(id responseObject);

/**
 请求失败回调

 @param error 返回的请求错误数据
 */
typedef void(^FailtureBlock)(NSError *error);

@interface FCHttpNetRequest : NSObject

+ (instancetype)sharedNetRequest;

- (void)getWithURLString:(NSString *)urlString parameters:(id)parameters success:(SuccessBlock)success failture:(FailtureBlock)failture;


- (void)postWithURLString:(NSString *)urlString parameters:(id)parameters success:(SuccessBlock)success failture:(FailtureBlock)failture;

@end
