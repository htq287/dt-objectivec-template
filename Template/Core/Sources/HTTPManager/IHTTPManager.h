//
//  IHTTPManager.h
//  Core
//
//  Created by Hung Truong on 8/28/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HTTPMethod) {
    POST,
    GET,
    PUT,
    DELETE
};

@class APIConfig;

@protocol IHTTPManager <NSObject>

- (instancetype)initWithConfig:(APIConfig *)apiConfig;

#pragma mark - Requests
- (void)makeRequest:(NSString *)URL method:(HTTPMethod)method additionalHTTPHeaders:(NSDictionary * _Nullable)additionalHTTPHeaders parameters:(NSDictionary * _Nullable)parameters success:(void(^)(NSURLSessionDataTask *task, id responseObject))success failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
