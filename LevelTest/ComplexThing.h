//
//  ComplexThing.h
//  LevelTest
//
//  Created by Andy Sherwood on 10/9/13.
//  Copyright (c) 2013 Clean Water Services. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComplexThing : NSObject<NSCoding>

@property (nonatomic) int id;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSNumber* value;
@property (nonatomic,copy) NSArray* items;

- (id) initWithId:(int)id name:(NSString*)name value:(NSNumber*)value andItems:(NSArray*)items;

- (void) encodeWithCoder:(NSCoder*)coder;
- (id) initWithCoder:(NSCoder*)coder;

@end

@interface Item : NSObject<NSCoding>

@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSArray* tiers;

- (id) initWithName:(NSString*)name andTiers:(NSArray*)tiers;

- (void) encodeWithCoder:(NSCoder*)coder;
- (id) initWithCoder:(NSCoder*)coder;

@end

@interface Tier : NSObject<NSCoding>

@property (nonatomic) int level;
@property (nonatomic) float amount;

- (id) initWithLevel:(int)level andAmount:(float)amount;

- (void) encodeWithCoder:(NSCoder*)coder;
- (id) initWithCoder:(NSCoder*)coder;

@end
