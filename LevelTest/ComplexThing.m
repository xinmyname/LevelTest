//
//  ComplexThing.m
//  LevelTest
//
//  Created by Andy Sherwood on 10/9/13.
//  Copyright (c) 2013 Clean Water Services. All rights reserved.
//

#import "ComplexThing.h"

@implementation ComplexThing

@synthesize id=_id;
@synthesize name=_name;
@synthesize value=_value;
@synthesize items=_items;

- (id) initWithId:(int)id name:(NSString*)name value:(NSNumber*)value andItems:(NSArray*)items;
{
    self = [super init];
    
    if (self != nil)
    {
        _id = id;
        _name = name;
        _value = value;
        _items = items;
    }
    
    return self;
}

- (NSString *)description
{
    id desc = [[NSMutableString alloc] init];
    
    [desc appendFormat:@"{ id=%d, name=\"%@\", value=\"%@\", items=[  ", _id, _name, _value];
    
    for (int i = 0; i < [_items count]; i++)
    {
        if (i != 0)
            [desc appendString:@", "];
        
        Item* item = _items[i];
        
        [desc appendString:[item description]];
    }
    
    [desc appendString:@"] }"];
    
    return desc;
}

- (void) encodeWithCoder:(NSCoder*)coder
{
    [coder encodeInt:_id forKey:@"id"];
    [coder encodeObject:_name];
    [coder encodeObject:_value];
    [coder encodeObject:_items];
}

- (id) initWithCoder:(NSCoder*)coder
{
    self = [super init];
    
    if (self)
    {
        _id = [coder decodeIntForKey:@"id"];
        _name = [coder decodeObject];
        _value = [coder decodeObject];
        _items = [coder decodeObject];
    }
    
    return self;
}

@end

@implementation Item

@synthesize name=_name;
@synthesize tiers=_tiers;

- (id) initWithName:(NSString*)name andTiers:(NSArray*)tiers
{
    self = [super init];
    
    if (self != nil)
    {
        _name = name;
        _tiers = tiers;
    }
    
    return self;
}

- (NSString *)description
{
    id desc = [[NSMutableString alloc] init];
    
    [desc appendFormat:@"{ name=\"%@\", tiers=[ ", _name];

    for (int i = 0; i < [_tiers count]; i++)
    {
        if (i != 0)
            [desc appendString:@", "];
        
        Tier* tier = _tiers[i];
        
        [desc appendString:[tier description]];
    }
    
    [desc appendString:@" ] }"];
    
    return desc;
}


- (void) encodeWithCoder:(NSCoder*)coder
{
    [coder encodeObject:_name];
    [coder encodeObject:_tiers];
}

- (id) initWithCoder:(NSCoder*)coder
{
    self = [super init];
    
    if (self)
    {
        _name = [coder decodeObject];
        _tiers = [coder decodeObject];
    }
    
    return self;
}


@end


@implementation Tier

@synthesize level=_level;
@synthesize amount=_amount;

- (id) initWithLevel:(int)level andAmount:(float)amount
{
    self = [super init];
    
    if (self != nil)
    {
        _level = level;
        _amount = amount;
    }

    return self;
}

- (NSString*)description
{
    return [[NSString alloc] initWithFormat:@"{%d:%0.2f}", _level, _amount];
}

- (void) encodeWithCoder:(NSCoder*)coder
{
    [coder encodeInt:_level forKey:@"level"];
    [coder encodeFloat:_amount forKey:@"amount"];
}

- (id) initWithCoder:(NSCoder*)coder
{
    self = [super init];
    
    if (self)
    {
        _level = [coder decodeIntForKey:@"level"];
        _amount = [coder decodeFloatForKey:@"amount"];
    }
    
    return self;
}

@end

