//
//  IDatabase.h
//  Core
//
//  Created by TPLAuthor on 8/28/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IDatabase <NSObject>

- (void)addObject:(id)object;
- (void)updateObject:(id)object;
- (void)deleteObject:(id)object;

@end

NS_ASSUME_NONNULL_END
