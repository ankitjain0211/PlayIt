//
//  PIProfileViewController.h
//  PlayIt
//
//  Created by Ankit on 26/03/14.
//  Copyright (c) 2014 PlayIt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface PIProfileViewController : UIViewController <FBLoginViewDelegate>
{
    NSString *userName, *userLocation, *userCompany, *userGender;
}

@property (weak, nonatomic) IBOutlet FBLoginView *fbLoginView;
@property (weak, nonatomic) IBOutlet UIView *profileView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileUserName;
@property (weak, nonatomic) IBOutlet UILabel *profileCompanyName;
@property (weak, nonatomic) IBOutlet UILabel *ProfileUserLocation;

@end
