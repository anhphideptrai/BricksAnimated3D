//
//  SQLiteManager.m
//  Bricks Animated 3D
//
//  Created by Phi Nguyen on 5/29/15.
//  Copyright (c) 2015 Thien Nguyen. All rights reserved.
//

#import "SQLiteManager.h"
#import <sqlite3.h>

@interface SQLiteManager()

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;

@end

@implementation SQLiteManager
static SQLiteManager *thisInstance;


+ (SQLiteManager *)getInstance {
    return thisInstance;
}
+ (void)initialize {
    static BOOL initialized = NO;
    if(!initialized)
    {
        initialized = YES;
        thisInstance = [[SQLiteManager alloc] init];
    }
}
- (SQLiteManager *)init {
    self = [super init];
    if (self) {
        return self;
    }
    return nil;
}
- (void)copyDatabase {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    _databasePath = [documentsDirectory stringByAppendingPathComponent:_NAME_DB_STRING_];
    
    if ([fileManager fileExistsAtPath:_databasePath] == NO) {
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:_NAME_DB_STRING_ ofType:@""];
        [fileManager copyItemAtPath:resourcePath toPath:_databasePath error:&error];
    }
    if (_contactDB) {
        sqlite3_close(_contactDB);
    }
}
- (NSMutableArray*)getArrLegoWithiDGroup:(NSString*)iDGroup{
    [self copyDatabase];
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    Lego *lego;
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"select * from lego where iDGroup = '%@' group by name", iDGroup];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                lego = [[Lego alloc] init];
                lego.iDLego = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)];
                lego.iDGroup = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 1)];
                lego.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 2)];
                lego.bricks = [self getLegoBricks:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 3)]];
                lego.icon = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 4)];
                lego.preview = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 5)];
                lego.totalBricks = sqlite3_column_int(statement, 6);
                lego.size = sqlite3_column_int(statement, 7);
                lego.isDownloaded = sqlite3_column_int(statement, 8);
                [resultArray addObject:lego];
            }
            sqlite3_finalize(statement);
        }
        
        
        sqlite3_close(_contactDB);
    }
    return resultArray;
    
}
- (NSMutableArray*)getLegoBricks:(NSString*)bricks{
    NSMutableArray *result = [NSMutableArray new];
    NSArray *arr = [bricks componentsSeparatedByString:@","];
    for (NSString *tmp in arr) {
        NSArray *arrTmp = [tmp componentsSeparatedByString:@"x"];
        if (arrTmp.count > 1) {
            LegoBrick *brick = [LegoBrick new];
            [brick setName:[arrTmp[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            [brick setCount:[arrTmp[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            [result addObject:brick];
        }
    }
    return result;
}
- (NSMutableArray*)getAllLegoGroup{
    [self copyDatabase];
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    LegoGroup *lego;
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"select * from legogroup group by name"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                lego = [[LegoGroup alloc] init];
                lego.iDGroup = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)];
                lego.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 1)];
                lego.legoes = [self getArrLegoWithiDGroup:lego.iDGroup];
                [resultArray addObject:lego];
            }
            sqlite3_finalize(statement);
        }
        
        
        sqlite3_close(_contactDB);
    }
    return resultArray;

}
@end
