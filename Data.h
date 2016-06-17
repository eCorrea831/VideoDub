//
//  Data.h
//  VideoDub
//
//  Created by Thomas on 6/17/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "User.h"
#import "Videos.h"

@interface Data : NSObject

@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSMutableArray *arrayOfVideos;
@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) NSManagedObjectModel *model;
@property (nonatomic, retain) NSPredicate *predicate;
@property (nonatomic, retain) NSEntityDescription *entity;

+ (instancetype)sharedInstance;
- (instancetype)initWithData;

@end
