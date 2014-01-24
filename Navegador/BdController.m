//
//  BdController.m
//  Navegador
//
//  Created by Murilo Campaner on 18/01/14.
//  Copyright (c) 2014 Murilo Campaner. All rights reserved.
//

#import "BdController.h"
#import "ItemHistorico.h"

@implementation BdController

- (id)init
{
    self = [super init];
    if (self) {
        NSString *docsDir;
        NSArray *dirPaths;
        char *errMsg;
        BOOL BDExist;
        
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = dirPaths[0];
        
        _databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"iNavigator.db"]];
        NSFileManager *filemgr = [NSFileManager defaultManager];
        BDExist = [filemgr fileExistsAtPath:_databasePath];
        
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_DB) == SQLITE_OK) {
            
            // CRIA A TABELA HISTÓRICO
            const char *tblHistorico = "CREATE TABLE IF NOT EXISTS historico (id INTEGER PRIMARY KEY AUTOINCREMENT, link TEXT, data TEXT)";
            if (sqlite3_exec(_DB, tblHistorico, NULL, NULL, &errMsg) != SQLITE_OK)
                NSLog(@"Falha ao criar a tabela histórico");
            
            // CRIA A TABELA FAVORITOS
            const char *tblFavoritos = "CREATE TABLE IF NOT EXISTS favoritos (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, link TEXT)";
            if (sqlite3_exec(_DB, tblFavoritos, NULL, NULL, &errMsg) != SQLITE_OK)
                NSLog(@"Falha ao criar a tabela favoritos");
            
            
            //            [self loadData];
            
            sqlite3_close(_DB);
        } else {
            NSLog(@"Falha ao criar/abrir o BD");
        }
    }
    return self;
}

/* 
 * Métodos do Histórico
 */

- (BOOL) insertIntoHistoric: (ItemHistorico *)item
{
    const char *dbpath = [_databasePath UTF8String];
    BOOL state = YES;
    char *errMsg;
    
    if (sqlite3_open(dbpath, &_DB) == SQLITE_OK) {

            NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO historico (link, data) VALUES (\"%@\", \"%@\")",  item.url, item.date];
            const char *insert_stmt = [insertSQL UTF8String];
            sqlite3_exec(_DB, insert_stmt, NULL, NULL, &errMsg);

        sqlite3_close(_DB);
    } else {
        state = NO;
    }
    
    return state;
}

- (NSMutableArray *) getAllHistoric
{
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    
    NSMutableArray *historico = [[NSMutableArray alloc]init];
    
    if (sqlite3_open(dbpath, &_DB) == SQLITE_OK) {
        const char *query_stmt = [@"SELECT id, link, data FROM historico ORDER BY data" UTF8String];
        if (sqlite3_prepare_v2(_DB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                int id = sqlite3_column_int(statement, 0);
                NSString *url = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *date = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
                ItemHistorico *item = [[ItemHistorico alloc]init];
                [item setIdItem:id];
                [item setUrl:url];
                [item setDate:date];
                
                [historico addObject:item];
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_DB);
    }
    
    return historico;
}





@end
