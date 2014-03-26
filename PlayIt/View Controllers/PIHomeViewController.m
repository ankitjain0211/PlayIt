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
}
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@end

@implementation PIHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Defaults
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];
    setAlernativeColor = NO;
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

#pragma mark - TableView Datasource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"SongCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    UIImageView *iconImage = (UIImageView *)[cell viewWithTag:1];
    iconImage.image = [UIImage imageNamed:@"Profile_image.png"];
    iconImage.layer.cornerRadius = iconImage.bounds.size.width / 2;
    [PIUtility applyTwoCornerMask:iconImage.layer withRadius:15];
    
    UILabel *songNameLbl = (UILabel *)[cell viewWithTag:2];
    [songNameLbl setText:@"Im gonna find another you"];
    
    UILabel *singerNameLbl = (UILabel *)[cell viewWithTag:3];
    [singerNameLbl setText:@"John Mayer"];
    
    UIImageView *favouritesImg = (UIImageView *)[cell viewWithTag:4];
    [favouritesImg setImage:[UIImage imageNamed:@"favourites.png"]];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

#pragma mark - TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
}

@end
