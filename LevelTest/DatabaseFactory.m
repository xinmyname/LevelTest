//
//  FMDatabaseFactory.m
//
//  Copyright (c) 2012 Andy Sherwood. All rights reserved.
//

#import "DatabaseFactory.h"
#import "APLevelDB.h"

@implementation DatabaseFactory
{
    NSFileManager* _fileManager;
    NSString* _dbFileName;
    NSSearchPathDirectory _searchPath;
}

- (id)initWithResourceFileName:(NSString*)dbFileName
                 andSearchPath:(NSSearchPathDirectory)searchPath
{
    self = [super init];
    
    if (self)
    {
        _fileManager = [NSFileManager defaultManager];
        _dbFileName = [dbFileName copy];
        _searchPath = searchPath;
    }
    
    return self;
}

- (APLevelDB*)openDatabase
{
    NSString* path = [self databasePath];
    NSError* error;
    APLevelDB* db = [APLevelDB levelDBWithPath:path error:&error];
    
    return db;
}

- (NSString*)databasePath
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(_searchPath, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:_dbFileName];
}

@end
