//
//  BdController.h
//  Navegador
//
//  Created by Murilo Campaner on 18/01/14.
//  Copyright (c) 2014 Murilo Campaner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ItemHistorico.h"

@interface BdController : NSObject

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *DB;
- (BOOL) insertIntoHistoric: (ItemHistorico *)item;
- (NSMutableArray *) getAllHistoric;

@end

