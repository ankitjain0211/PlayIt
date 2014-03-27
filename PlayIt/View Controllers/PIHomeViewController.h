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

@end
