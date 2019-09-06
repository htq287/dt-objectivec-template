//
//  HTTPManagerTests.m
//  CoreTests
//
//  Created by TPLAuthor on 8/28/19.
//

#import <XCTest/XCTest.h>
#import <Core/Core.h>

@interface HTTPManagerTests : XCTestCase

@property (nonatomic, strong) NSObject <INetworkingFactory> *networkingFactory;

@end

@implementation HTTPManagerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSBundle *testsBundle = [NSBundle bundleForClass:[self class]];
    XCTAssertNotNil(testsBundle);
    
    NSDictionary *infoDict = [testsBundle infoDictionary];
    XCTAssertNotNil(infoDict);
    
    NSString *apiRoot = infoDict[@"API_ROOT"];
    APIConfig *apiConfig = [[APIConfig alloc] initWithBundle:testsBundle];
    [apiConfig setBaseUrl:apiRoot];
    
    self.networkingFactory = [[NetworkingFactory alloc] initWithConfig:apiConfig];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testMakeRequest_POST {
    
    XCTestExpectation *userLoginExpectation = [self expectationWithDescription:@"user login"];
    
    NSObject <IHTTPManager> *afhttpManager = [self.networkingFactory createAFHTTPManager];
    NSDictionary *additionalHTTPHeaders = @{@"Content-Type": @"application/json"};
    NSDictionary *parameters = @{ @"user" : @{
                                     @"username" : @"test",
                                     @"email" : @"test@test.net",
                                     @"password" : @"test@123!"
                                   }
                                };
    [afhttpManager makeRequest:@"/drive/api/login" method:POST additionalHTTPHeaders:additionalHTTPHeaders parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"responseObject: %@", responseObject);
        
        [userLoginExpectation fulfill];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        
        [userLoginExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:3 handler:^(NSError *error) {
        
        NSLog(@"Test failed: timeout");
    }];
}

@end
