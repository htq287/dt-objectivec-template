//
//  UnitOfWork.h
//  Core
//
//  Created by Hung Truong on 8/28/19.
//

#import <Foundation/Foundation.h>
#import "IUnitOfWork.h"
#import "IDatabase.h"

NS_ASSUME_NONNULL_BEGIN

@interface UnitOfWork : NSObject <IUnitOfWork>

- (instancetype)initWithDatabase:(id<IDatabase>)database;

@end
NS_ASSUME_NONNULL_END
