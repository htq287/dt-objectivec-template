//
//  NetworkingFactory.m
//  Core
//
//  Created by Hung Truong on 8/28/19.
//

#import "NetworkingFactory.h"
#import "APIConfig.h"

#import "AFHTTPManager.h"

@implementation NetworkingFactory {
    APIConfig *_apiConfig;
}

- (instancetype)initWithConfig:(APIConfig *)apiConfig {
    if(self = [super init]) {
        _apiConfig = apiConfig;
    }
    
    return self;
}

- (AFHTTPManager *)createAFHTTPManager {
    return [[AFHTTPManager alloc] initWithConfig:_apiConfig];
}

@end
