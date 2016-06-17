//
//  User.h
//  VideoDub
//
//  Created by Thomas on 6/17/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

- (instancetype)initWithUsername:(NSString *)username;

@end

NS_ASSUME_NONNULL_END

#import "User+CoreDataProperties.h"
