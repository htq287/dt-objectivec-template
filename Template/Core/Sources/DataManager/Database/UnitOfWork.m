//
//  UnitOfWork.m
//  Core
//
//  Created by Hung Truong on 8/28/19.
//

#import "UnitOfWork.h"

@implementation UnitOfWork {
    id<IDatabase> _db;
    NSMutableDictionary<id<NSCopying>, NSMutableArray<NSObject<Item> *> *> *_context;
}

- (instancetype)initWithDatabase:(id<IDatabase>)database {
    if(self = [super init]) {
        _db = database;
        _context = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

#pragma mark - Implements IUnitOfWork

- (void)registerInserted:(NSObject<Item> *)object {
    [self register:object operation:INSERT];
}

- (void)registerUpdated:(NSObject<Item> *)object {
    [self register:object operation:UPDATE];
}

- (void)registerDeleted:(NSObject<Item> *)object {
    [self register:object operation:DELETE];
}

- (void)commit {
    if(!_context.count) {
        return;
    }
    
    if([_context objectForKey:@(INSERT)]) {
        [self commitInsert];
    }
    
    if([_context objectForKey:@(UPDATE)]) {
        [self commitUpdate];
    }
    
    if([_context objectForKey:@(DELETE)]) {
        [self commitDelete];
    }
}


#pragma mark - Internals

- (void)register:(NSObject<Item> *)object operation:(UOWOperation)operation {
    NSMutableArray *objectsToOperation = [_context objectForKey:@(operation)];
    if(!objectsToOperation) {
        objectsToOperation = [[NSMutableArray alloc] init];
        [_context setObject:objectsToOperation forKey:@(operation)];
    }
    
    [objectsToOperation addObject:object];
}

- (void)commitInsert {
    NSMutableArray *objectsToBeInserted = [_context objectForKey:@(INSERT)];
    for(NSObject<Item> *object in objectsToBeInserted) {
        [_db addObject:object];
    }
}

- (void)commitUpdate {
    NSMutableArray *objectsToBeUpdated = [_context objectForKey:@(UPDATE)];
    for(NSObject<Item> *object in objectsToBeUpdated) {
        [_db updateObject:object];
    }
}

- (void)commitDelete {
    NSMutableArray *objectsToBeDeleted = [_context objectForKey:@(DELETE)];
    for(NSObject<Item> *object in objectsToBeDeleted) {
        [_db deleteObject:object];
    }
}

@end
