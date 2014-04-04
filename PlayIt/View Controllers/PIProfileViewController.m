//
//  PIProfileViewController.m
//  PlayIt
//
//  Created by Ankit on 26/03/14.
//  Copyright (c) 2014 PlayIt. All rights reserved.
//

#import "PIProfileViewController.h"

@interface PIProfileViewController ()

@end

@implementation PIProfileViewController
@synthesize fbLoginView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [fbLoginView setReadPermissions:@[@"basic_info"]];
    
    [_profileView setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    NSLog(@"You're logged in as");
    
    
}
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    NSDictionary *responseDict = (NSDictionary *)user;
    SNLogTrace(@"User dict has %@", responseDict);
    
    [_profileView setHidden:NO];
    
    userName = [NSString stringWithFormat:@"%@ %@", [responseDict valueForKey:@"first_name"], [responseDict valueForKey:@"last_name"]];
    userLocation = [NSString stringWithFormat:@"%@", [[responseDict valueForKey:@"location"] valueForKey:@"name"]];
    userGender = [responseDict valueForKey:@"gender"];
    userCompany = [[[[responseDict valueForKey:@"work"] objectAtIndex:0] valueForKey:@"employer"] valueForKey:@"name"];
    
    _profileUserName.text = userName;
    _ProfileUserLocation.text = userLocation;
    _profileCompanyName.text = userCompany;
    if ([[userGender lowercaseString] isEqual:@"male"]) {
        [_profileImageView setImage:[UIImage imageNamed:@"maleProfile"]];
    } else {
        [_profileImageView setImage:[UIImage imageNamed:@"femaleProfile"]];
    }
    
    //self.profilePictureView.profileID = user.id;
    //self.nameLabel.text = user.name;
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    [_profileView setHidden:YES];
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

@end
