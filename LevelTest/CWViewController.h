//
//  CWViewController.h
//  LevelTest
//
//  Created by Andy Sherwood on 10/9/13.
//  Copyright (c) 2013 Clean Water Services. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWViewController : UIViewController

@end

@interface Progress : NSObject

@property (nonatomic) float value;
@property (nonatomic,copy) NSString* text;

- (id) initWithValue:(float)progress andText:(NSString*)text;

@end