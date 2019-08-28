//
//  APIConfig.h
//  Core
//
//  Created by Hung Truong on 8/28/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIConfig : NSObject

@property (nonatomic, copy) NSString * _Nonnull baseUrl;
@property (nonatomic, copy) NSString * _Nonnull domainName;
@property (nonatomic, copy) NSString * _Nonnull versionNo;
@property (nonatomic, copy) NSString * _Nonnull buildNo;
@property (nonatomic, copy) NSString * _Nonnull bundleId;
@property (nonatomic, copy) NSString * _Nonnull platformName;
@property (nonatomic, copy) NSString * _Nonnull platformVersion;
@property (nonatomic, copy) NSString * _Nonnull deviceName;
@property (nonatomic, copy) NSString * _Nonnull deviceModel;
@property (nonatomic) NSInteger deviceType;
@property (nonatomic, copy) NSString * _Nonnull appGroupIdentifier;
@property (nonatomic, copy) NSString * _Nonnull projectName;
@property (nonatomic, copy) NSString * _Nonnull company;

- (instancetype)initWithBundle:(NSBundle *)bundle;
- (NSString *)getAgentInfo;

@end

NS_ASSUME_NONNULL_END
