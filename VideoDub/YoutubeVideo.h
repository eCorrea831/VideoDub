//
//  YoutubeVideo.h
//  VideoDub
//
//  Created by Aditya Narayan on 6/17/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YoutubeVideo : NSObject

@property(nonatomic, retain) NSString * title;
@property(nonatomic) int videoID;
@property(nonatomic, retain) NSString * imageName;
@property(nonatomic, retain) NSURL * url;
@property(nonatomic, retain) UIImage * thumbnail;

@end
