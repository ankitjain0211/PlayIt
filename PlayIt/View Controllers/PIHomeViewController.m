//
//  PIHomeViewController.m
//  PlayIt
//
//  Created by Ankit on 26/03/14.
//  Copyright (c) 2014 PlayIt. All rights reserved.
//

#import "PIHomeViewController.h"

#define kBlueColor [UIColor colorWithRed:72.0f/255.0f green:105.0f/255.0f blue:171.0f/255.0f alpha:1.0f]
#define kGreenColor [UIColor colorWithRed:17.0f/255.0f green:95.0f/255.0f blue:34.0f/255.0f alpha:1.0f]

@interface PIHomeViewController ()
{
    BOOL setAlernativeColor;
    MPMediaItemCollection	*_userMediaItemCollection;
}

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (nonatomic,strong) MPMusicPlayerController *musicPlayer;

@end

@implementation PIHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Defaults
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];
    setAlernativeColor = NO;
    
    // To fetch media files from phone library
    [self pickAudioFiles];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Fetch Audio Files

-(void)pickAudioFiles {
    // Call only if media files where not fetched previously
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:kCacheMediaFiles] count]) {
        MPMediaPickerController *soundPicker=[[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeAnyAudio];
        soundPicker.delegate=self;
        soundPicker.allowsPickingMultipleItems=YES;
        [self presentViewController:soundPicker animated:YES completion:nil];
    } else {
    
    }
}

#pragma mark - MPMediaPickerController Delegate

-(void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
    // Dismiss controller
    [mediaPicker dismissViewControllerAnimated:YES completion:nil];
    // Update or cache the data
    [self updateTheMediaColledtionsItems:mediaItemCollection];
}

- (void)updateTheMediaColledtionsItems:(MPMediaItemCollection *)mediaItemCollection {
    if (_userMediaItemCollection == nil) {
        _userMediaItemCollection = mediaItemCollection;
        
        // Cache the data to avoid calling next time same method to fetch media files
       // [[NSUserDefaults standardUserDefaults] setValue:[_userMediaItemCollection items] forKey:kCacheMediaFiles];
        //[[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.musicPlayer setQueueWithItemCollection: _userMediaItemCollection];
        
        [self.musicPlayer play];
    } else  {
        BOOL wasPlaying = NO;
        if (self.musicPlayer.playbackState ==
            MPMusicPlaybackStatePlaying) {
            wasPlaying = YES;
        }
        
        MPMediaItem *nowPlayingItem	= self.musicPlayer.nowPlayingItem;
        NSTimeInterval currentPlaybackTime	= self.musicPlayer.currentPlaybackTime;
        NSMutableArray *currentSongsList= [[_userMediaItemCollection items] mutableCopy];
        
        NSArray *nowSelectedSongsList = [mediaItemCollection items];
        
        [currentSongsList addObjectsFromArray:nowSelectedSongsList];
        
        _userMediaItemCollection = [MPMediaItemCollection collectionWithItems:(NSArray *) currentSongsList];
        [self.musicPlayer setQueueWithItemCollection: _userMediaItemCollection];
        self.musicPlayer.nowPlayingItem	= nowPlayingItem;
        self.musicPlayer.currentPlaybackTime = currentPlaybackTime;
        
        if (wasPlaying) {
            
            [self.musicPlayer play];
        }
    }
    [self.songTableView reloadData];
}

#pragma mark - Play 
-(void)playWithMediaItem:(MPMediaItem *)item {
    self.musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    [self.musicPlayer setQueueWithItemCollection:_userMediaItemCollection];
    [self.musicPlayer setNowPlayingItem:item];
    [self.musicPlayer play];
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_userMediaItemCollection.items count] > 0) {
        MPMediaItem *item = [[_userMediaItemCollection items] objectAtIndex:[indexPath row]];
        // Play the item using MPMusicPlayer
        [self playWithMediaItem:item];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TableView Datasource

// Return the number of rows in the section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_userMediaItemCollection.items count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"SongCell";
    UITableViewCell  *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
	if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    
    MPMediaItem *anItem = (MPMediaItem *)[_userMediaItemCollection.items objectAtIndex: [indexPath row]];
    
    UIImageView *iconImage = (UIImageView *)[cell viewWithTag:1];
    iconImage.image = [UIImage imageNamed:@"Profile_image.png"];
    iconImage.layer.cornerRadius = iconImage.bounds.size.width / 2;
    [PIUtility applyTwoCornerMask:iconImage.layer withRadius:15];
    
    UILabel *songNameLbl = (UILabel *)[cell viewWithTag:2];
    if (anItem) {
        [songNameLbl setText:[anItem valueForProperty:MPMediaItemPropertyTitle]];
    }
    
    UILabel *singerNameLbl = (UILabel *)[cell viewWithTag:3];
    if (anItem) {
        [singerNameLbl setText:[anItem valueForProperty:MPMediaItemPropertyAlbumTitle]];
    }
    
    UIImageView *favouritesImg = (UIImageView *)[cell viewWithTag:4];
    [favouritesImg setImage:[UIImage imageNamed:@"favourites.png"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}


#pragma mark - Burger Menu Button

- (IBAction)onBurger:(id)sender {
    NSArray *images = @[
                        [UIImage imageNamed:@"profile"],
                        [UIImage imageNamed:@"play"],
                        [UIImage imageNamed:@"star"],
                        [UIImage imageNamed:@"globe"],
                        [UIImage imageNamed:@"gear"],
                        [UIImage imageNamed:@"about"],
                        [UIImage imageNamed:@"profile"],
                        [UIImage imageNamed:@"logout"]
                        ];
    NSArray *colors = @[
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        ];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    //    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images];
    callout.delegate = self;
    //    callout.showFromRight = YES;
    [callout show];
}

#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    NSLog(@"Tapped item at index %i",index);
    if (index == 3) {
        [sidebar dismissAnimated:YES completion:nil];
    }
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    if (itemEnabled) {
        [self.optionIndices addIndex:index];
    }
    else {
        [self.optionIndices removeIndex:index];
    }
}

@end
