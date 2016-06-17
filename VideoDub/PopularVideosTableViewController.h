//
//  PopularVideosTableViewController.h
//  VideoDub
//
//  Created by Aditya Narayan on 6/17/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YoutubeVideo.h"

@interface PopularVideosTableViewController : UITableViewController

@property(nonatomic, retain) NSMutableArray <YoutubeVideo*> * videosArray;

@end
