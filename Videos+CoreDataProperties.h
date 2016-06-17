//
//  Videos+CoreDataProperties.h
//  VideoDub
//
//  Created by Thomas on 6/17/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Videos.h"

NS_ASSUME_NONNULL_BEGIN

@interface Videos (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *videoName;
@property (nullable, nonatomic, retain) NSString *videoFile;
@property (nullable, nonatomic, retain) NSString *audioFile;
@property (nullable, nonatomic, retain) NSString *creatorName;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
