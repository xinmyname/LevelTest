//
//  CWViewController.h
//  LevelTest
//
//  Created by Andy Sherwood on 10/9/13.
//  Copyright (c) 2013 Clean Water Services. All rights reserved.
//

#import "APLevelDB.h"

@interface DatabaseFactory : NSObject

- (id)initWithResourceFileName:(NSString*)dbFileName
                 andSearchPath:(NSSearchPathDirectory)searchPath;

- (APLevelDB*)openDatabase;

@end
