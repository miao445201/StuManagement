//
//  HSNetWork.h
//  HealthStatus
//
//  Created by 缪宇青 on 16/4/14.
//  Copyright © 2016年 缪宇青. All rights reserved.
//

#import "AFHTTPSessionManager.h"

//请求成功回调的block
typedef void (^requestSuccessBlock)(NSDictionary *dict);

//请求失败回调的block
typedef void (^requestFailureBlock) (NSError *error);

typedef enum {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD,
}HTTPMethods;

@interface HSNetWork : AFHTTPSessionManager

+(instancetype)shareManager;

- (void)requestWithMethod:(HTTPMethods)method
                 WithPath:(NSString*)path
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
         WithFailureBlock:(requestFailureBlock)failure;
@end
