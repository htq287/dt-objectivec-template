//
//  Database.m
//  Core
//
//  Created by TPLAuthor on 8/28/19.
//

#import "Database.h"
#import "FMDB.h"

@interface Database () {
    NSBundle        *_migrationsBundle;
    NSString        *_dbSchema;
    FMDatabaseQueue     *_write;
    FMDatabasePool      *_read;
}

@end


@implementation Database

- (NSString *)password {
    return @"0x32";
}

#pragma mark - Initializer

- (instancetype)initWithDatabasePath:(NSString *)databasePath schema:(NSString *)schema migrationsBundle:(NSBundle *)migrationsBundle {
    if(self = [super init]) {
        _path = databasePath;
        _dbSchema = schema;
        _migrationsBundle = migrationsBundle;
        [self initializeDatabase];
    }
    
    return self;
}

- (void)dealloc {
    NSLog(@"%@ released", self.description);
}

- (void)initializeDatabase {
    BOOL dBExisted = [[NSFileManager defaultManager] fileExistsAtPath:_path];
    if (_path != nil) {
        _write = [[FMDatabaseQueue alloc] initWithPath:_path];
        _read = [[FMDatabasePool alloc] initWithPath:_path];
        _read.delegate = self;
    }
    
    // Enable WAL mode for writes
    [_write inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *sql = [NSString stringWithFormat:@"PRAGMA key='%@'", [self password]];
        [db executeStatements:sql];
        if(![db executeStatements:@"PRAGMA journal_mode=WAL"]) {
            NSLog(@"Unable to set WAL mode, error: %@,", db.lastError);
        }
    }];
    
    // Create default tables if needed
    if(!dBExisted) {
        if(_dbSchema != nil && _dbSchema.length > 0) {
            [_write inDatabase:^(FMDatabase * _Nonnull db) {
                BOOL success = [db executeStatements:self->_dbSchema];
                if(!success) {
                    @throw ([NSException exceptionWithName:@"Import Schema" reason:@"Failed to import schema to database" userInfo:nil]);
                }
            }];
        }
    }
}

- (void)close {
    [_write close];
    _write = nil;
    _read = nil;
}


#pragma mark FMDatabasePoolDelegate

- (void)databasePool:(FMDatabasePool *)pool didAddDatabase:(FMDatabase *)database {
    // Decrypt the database
    [database executeStatements:[NSString stringWithFormat:@"PRAGMA key='%@'", [self password]]];
    
    // Enable WAL mode for reads
    [database executeStatements:@"PRAGMA journal_mode=WAL"];
}

@end
