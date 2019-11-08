//
//  IUnitOfWork.h
//  Core
//
//  Created by TPLAuthor on 8/28/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Item;

typedef NS_ENUM(NSInteger, UOWOperation) {
    INSERT = 0,
    UPDATE,
    DELETE
};

@protocol IUnitOfWork <NSObject>

- (void)registerInserted:(NSObject<Item> *)object;
- (void)registerUpdated:(NSObject<Item> *)object;
- (void)registerDeleted:(NSObject<Item> *)object;
- (void)commit;

@end

NS_ASSUME_NONNULL_END
