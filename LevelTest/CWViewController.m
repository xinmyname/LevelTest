//
//  CWViewController.m
//  LevelTest
//
//  Created by Andy Sherwood on 10/9/13.
//  Copyright (c) 2013 Clean Water Services. All rights reserved.
//

#import "CWViewController.h"
#import "DatabaseFactory.h"
#import "APLevelDB.h"
#import "ComplexThing.h"

@implementation CWViewController
{
    __weak IBOutlet UIActivityIndicatorView* _spinner;
    __weak IBOutlet UIProgressView* _progress;
    __weak IBOutlet UILabel* _operation;
    __weak IBOutlet UITextField* _log;

    DatabaseFactory* _dbFactory;
    NSMutableString* _logText;
    ComplexThing* _complexThing;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dbFactory = [[DatabaseFactory alloc] initWithResourceFileName:@"Test.lvdb" andSearchPath:NSDocumentDirectory];
    _logText = [[NSMutableString alloc] init];
    
    NSArray* tiers1 = @[
                       [[Tier alloc] initWithLevel:1 andAmount:2.0],
                       [[Tier alloc] initWithLevel:2 andAmount:5.0],
                       [[Tier alloc] initWithLevel:3 andAmount:12.0],
                       [[Tier alloc] initWithLevel:4 andAmount:20.0]
                       ];

    NSArray* tiers2 = @[
                        [[Tier alloc] initWithLevel:1 andAmount:3.0],
                        [[Tier alloc] initWithLevel:2 andAmount:5.0],
                        [[Tier alloc] initWithLevel:3 andAmount:10.0]
                        ];
    
    NSArray* items = @[
                        [[Item alloc] initWithName:@"Item One" andTiers:tiers1],
                        [[Item alloc] initWithName:@"Item Two" andTiers:tiers2],
                        [[Item alloc] initWithName:@"Item Three" andTiers:tiers1]
                        ];
    
    _complexThing = [[ComplexThing alloc] initWithId:42
                                                name:@"Life"
                                               value:@100001.100001
                                            andItems:items];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchedGo:(id)sender
{
    [_spinner startAnimating];
    [_progress setProgress:0.0f];

    [self performSelectorInBackground:@selector(runTests) withObject:nil];
}

- (void)updateProgress:(float)progress withText:(NSString*)text
{
    [self performSelectorOnMainThread:@selector(_updateProgress:) withObject:[[Progress alloc] initWithValue:progress andText:text] waitUntilDone:NO];
}

- (void)_updateProgress:(Progress*)progress
{
    [_progress setProgress:[progress value]];
    [_operation setText:[progress text]];
}

- (void)runTests
{
    @autoreleasepool
    {
        [self writeRandomNumbers];
        [self readRandomNumbers];
        [self writeComplexThing];
        [self readComplexThing];
        
        [self updateProgress:1.0 withText:@"Complete."];
        [_spinner performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
    }
}

- (void)writeRandomNumbers
{
    [self updateProgress:0.20 withText:@"Writing 10000 Random Numbers..."];
    
    APLevelDB* db = [_dbFactory openDatabase];
    
    id batch = [db beginWriteBatch];
    
    for (int i = 0; i < 10000; i++)
    {
        NSString* key = [[NSString alloc] initWithFormat:@"rnd/%d", i];
        NSNumber* number = [[NSNumber alloc] initWithInteger:arc4random()];
        [db setString:[number stringValue] forKey:key];
    }
    
    [db commitWriteBatch:batch];
    [db close];
}

- (void)readRandomNumbers
{
    [self updateProgress:0.40 withText:@"Reading 10000 Random Numbers..."];

    APLevelDB* db = [_dbFactory openDatabase];

    for (int i = 0; i < 10000; i++)
    {
        NSString* key = [[NSString alloc] initWithFormat:@"rnd/%d", i];
        NSString* value = [db stringForKey:key];
        assert(value != nil);
    }
    
    [db close];
}

- (void)writeComplexThing
{
    [self updateProgress:0.60 withText:@"Writing complex thing..."];
    
    APLevelDB* db = [_dbFactory openDatabase];

    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:_complexThing];
    [db setData:data forKey:@"complex/0"];
    
    [db close];

    NSLog(@"Stored: %@", _complexThing);
}

- (void)readComplexThing
{
    [self updateProgress:0.80 withText:@"Reading complex thing..."];
    
    APLevelDB* db = [_dbFactory openDatabase];

    NSData* data = [db dataForKey:@"complex/0"];
    ComplexThing* storedThing = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSLog(@"");
    NSLog(@"- - - - - - - - - - - - - - - - - ");
    NSLog(@"");
    NSLog(@"Retrieved: %@", storedThing);
    
    [db close];
}

@end


@implementation Progress

@synthesize value=_value;
@synthesize text=_text;

- (id) initWithValue:(float)value andText:(NSString*)text
{
    self = [super init];
    
    if (self != nil)
    {
        _value = value;
        _text = text;
    }
    
    return self;
}

@end