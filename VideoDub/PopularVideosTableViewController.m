//
//  PopularVideosTableViewController.m
//  VideoDub
//
//  Created by Aditya Narayan on 6/17/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import "PopularVideosTableViewController.h"
#import "WebViewController.h"

@interface PopularVideosTableViewController ()

@end

@implementation PopularVideosTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.videosArray = [[NSMutableArray alloc]init];
    [self addVideo];
    
    YoutubeVideo * video = [[YoutubeVideo alloc]init];
    video.title = @"test";
    video.thumbnail = [UIImage imageNamed:@"reel"];
    video.videoID = 1;
    video.url = [NSURL URLWithString:@"http://wwww.google.com"];
    [self.videosArray addObject:video];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.videosArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    YoutubeVideo * video = self.videosArray[indexPath.row];
    
    if (video.thumbnail == nil) {
        
        NSURL * URL = [NSURL URLWithString:video.imageName];
        NSURLRequest * request = [NSURLRequest requestWithURL:URL];
        
        NSURLSession * session = [NSURLSession sharedSession];
        NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse *response, NSError * error) {
            
            if (error != nil) {
                NSLog(@"%@", error.localizedDescription);
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage * image = [UIImage imageWithData:data];
                video.thumbnail = image;
            });
        }];
        
        [task resume];
        cell.imageView.image = video.thumbnail;
        [self.tableView reloadData];
    }

    cell.textLabel.text = video.title;
    cell.imageView.image = video.thumbnail;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)addVideo {
    NSString * string = @"https://www.googleapis.com/youtube/v3/videos?chart=mostpopular&key=AIzaSyDcs-Jw6bl_408JHuklf-7wne0DAkBXGfI&part=id,snippet&fields=items(id,snippet(title,thumbnails(default)))";
    NSURL * URL = [NSURL URLWithString:string];
    NSURLRequest * request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse *response, NSError * error) {
        
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString * jsonString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            NSError * jsonError;
            NSDictionary * parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&jsonError];
            NSLog(@"%@", parsedData);
            
            NSArray * array = parsedData[@"items"];
            
            for (NSDictionary * dict in array) {
                
                YoutubeVideo * video = [[YoutubeVideo alloc]init];
                video.videoID = [dict[@"id"] integerValue];
                video.title = dict[@"snippet"][@"title"];
                video.imageName = dict[@"snippet"][@"thumbnails"][@"default"][@"url"];
                video.url = [NSURL URLWithString:[NSString stringWithFormat:@"http://youtube.com/watch?v=%d", video.videoID]];
                
                [self.videosArray addObject:video];
                [self.tableView reloadData];
            }
        });
    }];
    
    [task resume];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([[segue identifier] isEqualToString:@"webViewSegue"]) {

        WebViewController * vc = [segue destinationViewController];
        
        NSIndexPath * indexPath = [self.tableView indexPathForCell:sender];
        
        int row = indexPath.row;
        
        YoutubeVideo * video = self.videosArray[row];

        [vc setUrl:video.url];
    }
}

@end
