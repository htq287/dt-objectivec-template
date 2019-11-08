//
//  APIConfig.m
//  Core
//
//  Created by TPLAuthor on 8/28/19.
//

#import "APIConfig.h"
#import <sys/utsname.h>
#import <GBDeviceInfo/GBDeviceInfo.h>

@implementation APIConfig

@synthesize baseUrl = _baseUrl;
@synthesize domainName = _domainName;
@synthesize versionNo = _versionNo;
@synthesize buildNo = _buildNo;
@synthesize bundleId = _bundleId;
@synthesize platformName = _platformName;
@synthesize platformVersion = _platformVersion;
@synthesize deviceName = _deviceName;
@synthesize deviceModel = _deviceModel;
@synthesize deviceType = _deviceType;
@synthesize appGroupIdentifier = _appGroupIdentifier;
@synthesize company = _company;
@synthesize projectName = _projectName;

- (instancetype)initWithBundle:(NSBundle *)bundle {
    if (self = [super init]) {
        _versionNo = [bundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        _buildNo = [bundle objectForInfoDictionaryKey:@"CFBundleVersion"];
        _bundleId = [bundle bundleIdentifier];
        _platformName = @"macOS";
        _platformVersion = [NSString stringWithFormat:@"%ld.%ld.%ld", [GBDeviceInfo deviceInfo].osVersion.major, [GBDeviceInfo deviceInfo].osVersion.minor, [GBDeviceInfo deviceInfo].osVersion.patch];
        _deviceName = [GBDeviceInfo deviceInfo].rawSystemInfoString;
        
        struct utsname systemInfo;
        uname(&systemInfo);
        
        _deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        _deviceType = -1;
        _appGroupIdentifier = @"";
        _company = @"";
        _projectName = @"";
    }
    
    return self;
}

- (void)setBaseUrl:(NSString *)baseUrl {
    _baseUrl = baseUrl;
}

- (NSString *)getAgentInfo {
    return [NSString stringWithFormat:@"%@/%@ (macOS; build %@; macOS Version %@; Device %@)", self.projectName, self.versionNo, self.buildNo, self.platformVersion, self.deviceName];
}

@end
