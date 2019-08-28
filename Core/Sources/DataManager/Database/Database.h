//
//  Database.h
//  Core
//
//  Created by Hung Truong on 8/28/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Database : NSObject {
    NSString *_path;
}

@property (nonatomic, readonly) NSString *path;

- (instancetype)initWithDatabasePath:(NSString *)databasePath schema:(NSString *)schema migrationsBundle:(NSBundle *)migrationsBundle;

- (void)close;

@end

NS_ASSUME_NONNULL_END
