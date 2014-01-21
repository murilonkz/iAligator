//
//  BdController.m
//  Navegador
//
//  Created by Murilo Campaner on 18/01/14.
//  Copyright (c) 2014 Murilo Campaner. All rights reserved.
//

#import "BdController.h"

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


@end
