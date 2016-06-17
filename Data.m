//
//  Data.m
//  VideoDub
//
//  Created by Thomas on 6/17/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import "Data.h"

@implementation Data

+ (instancetype)sharedInstance {
  static Data *_sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[Data alloc]initWithData];
  });
  
  return _sharedInstance;
};

- (instancetype)initWithData {
  self.context = [[NSManagedObjectContext alloc]init];
  self.model = [NSManagedObjectModel mergedModelFromBundles:nil];

  NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.model];
  NSString *path = [self archivePath];
  NSURL *storeUrl = [NSURL fileURLWithPath:path];
  NSError *error;
  
  if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
    [NSException raise:@"Failed to open" format:@"Reason: %@", [error localizedDescription]];
  }
  self.context.undoManager = [[NSUndoManager alloc]init];
  self.context.persistentStoreCoordinator = psc;
  
  User *user = (User *)[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.context];
  [user setValue:@"Thomas" forKey:@"username"];
  self.arrayOfVideos = [NSMutableArray array]; 
  
  return self;
}

- (NSString *)archivePath {
  NSArray *documentsDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [documentsDirectories objectAtIndex:0];
  return [documentsDirectory stringByAppendingPathComponent:@"store.data"];
}

- (void)fetchVideosFromContextForUser:(User *)user {
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"Videos" inManagedObjectContext:self.context];
  fetchRequest.entity = entity;
  [self createPredicate:user];
  fetchRequest.predicate = self.predicate;
  NSError *error = nil;
  NSArray *videos = [self.context executeFetchRequest:fetchRequest error:&error];
  if (!videos) {
    abort();
  } else {
    self.arrayOfVideos = [NSMutableArray arrayWithArray:videos];
  }
}

- (void)createPredicate:(User *)user {
  self.predicate = nil;
  NSFetchRequest *fetchUsers = [[NSFetchRequest alloc]init];
  NSPredicate *fetchAllUsersPredicate = [NSPredicate predicateWithFormat:@"username MATCHES '.*'"];
  fetchUsers.predicate = fetchAllUsersPredicate;
  NSEntityDescription *entityForUserFetch = [[self.model entitiesByName]objectForKey:@"User"];
  fetchUsers.entity = entityForUserFetch;
  NSError *error;
  NSArray *result = [self.context executeFetchRequest:fetchUsers error:&error];
  NSMutableArray *arrayOfUsers = [NSMutableArray arrayWithArray:result];
  NSLog(@"%@", arrayOfUsers);
  
  for (User *existingUser in arrayOfUsers) {
    NSLog(@"%@", existingUser);
    if (existingUser) {
      self.predicate = [NSPredicate predicateWithFormat:@"username == %@", user];
    } else {
      [self createNewUser:user];
      self.predicate = [NSPredicate predicateWithFormat:@"username == %@", user];
    }
  }
}

- (void)createNewUser:(User *)user {
  NSString *username = [user valueForKey:@"username"];
  User *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.context];
  [newUser setValue:username forKey:@"username"];
  [self saveChanges];
}

- (void)saveChanges {
  NSError *err = nil;
  BOOL successful = [[self context] save:&err];
  if(!successful) {
    NSLog(@"Error saving: %@", [err localizedDescription]);
  }
}


@end
