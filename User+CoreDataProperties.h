//
//  User+CoreDataProperties.h
//  VideoDub
//
//  Created by Thomas on 6/17/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSManagedObject *videos;

@end

NS_ASSUME_NONNULL_END
