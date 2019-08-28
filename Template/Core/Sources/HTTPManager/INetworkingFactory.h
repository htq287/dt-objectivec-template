//
//  INetworkingFactory.h
//  Core
//
//  Created by Hung Truong on 8/28/19.
//

#import <Foundation/Foundation.h>
#import "IHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@class APIConfig;

@protocol INetworkingFactory <NSObject>

- (instancetype)initWithConfig:(APIConfig *)apiConfig;
- (id<IHTTPManager>)createAFHTTPManager;

@end

NS_ASSUME_NONNULL_END
