//
//  AFHTTPManager.m
//  Core
//
//  Created by TPLAuthor on 8/28/19.
//

#import <AFNetworking.h>
#import "AFHTTPManager.h"
#import "APIConfig.h"

@interface AFHTTPManager ()

@property (nonatomic, strong) APIConfig *apiConfig;
@property (nonatomic, strong) AFHTTPSessionManager *afhttpManager;
@property (nonatomic, strong) NSString *baseUrl;
@end

@implementation AFHTTPManager

- (instancetype)initWithConfig:(APIConfig *)apiConfig {
    if(self = [super init]) {
        self.apiConfig = apiConfig;
        self.baseUrl = self.apiConfig.baseUrl;
        _afhttpManager = [[AFHTTPSessionManager manager] initWithBaseURL:nil];
        
        AFJSONRequestSerializer *serializerRequest = [AFJSONRequestSerializer serializer];
        AFJSONResponseSerializer *serializerResponse = [AFJSONResponseSerializer serializer];
        serializerResponse.readingOptions = NSJSONReadingAllowFragments;
        serializerResponse.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
        
        _afhttpManager.requestSerializer = serializerRequest;
        _afhttpManager.responseSerializer = serializerResponse;
    }
    
    return self;
}

- (void)setAgentInfo {
    [self setValue:[self.apiConfig getAgentInfo] forHTTPHeaderField:@"User-Agent"];
}

- (void)setValue:(nullable NSString *)value forHTTPHeaderField:(nonnull NSString *)field {
    [self.afhttpManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

#pragma mark - Requests

- (void)makeRequest:(NSString *)URL method:(HTTPMethod)method additionalHTTPHeaders:(NSDictionary *)additionalHTTPHeaders parameters:(NSDictionary *)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nonnull))success failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", self.baseUrl, URL];
    NSURLSessionDataTask *task = nil;
    
    for (NSString *field in additionalHTTPHeaders.allKeys) {
        NSString *value = [additionalHTTPHeaders valueForKey:field];
        [self.afhttpManager.requestSerializer setValue:value forHTTPHeaderField:field];
    }
    
    [self setAgentInfo];
    
    switch (method) {
        case POST: {
            task = [self.afhttpManager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(task, responseObject);
                }

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(task, error);
                }
            }];
            
            break;
        }
            
            
        case GET: {
            task = [self.afhttpManager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(task, responseObject);
                }

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(task, error);
                }

            }];
            
            break;
        }
            
        case DELETE: {
            task = [self.afhttpManager DELETE:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(task, responseObject);
                }

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(task, error);
                }

            }];
            
            break;
        }
    
        default: { break; }
    }
}

@end
