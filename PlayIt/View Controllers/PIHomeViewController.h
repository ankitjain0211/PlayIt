//
//  PIHomeViewController.h
//  PlayIt
//
//  Created by Ankit on 26/03/14.
//  Copyright (c) 2014 PlayIt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "RNFrostedSidebar.h"

@interface PIHomeViewController : UIViewController <RNFrostedSidebarDelegate, MPMediaPickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *songTableView;

// Player View
@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet UILabel *currentSongLbl;
@property (weak, nonatomic) IBOutlet UILabel *currentSongArtistLbl;
- (IBAction)playerRewind:(id)sender;
- (IBAction)playerPlay:(id)sender;
- (IBAction)playerPause:(id)sender;
- (IBAction)playerForward:(id)sender;

@end
