//
//  ViewController.m
//  Knotch Mini Project
//
//  Created by Chuan-Chih Chou on 13/07/15.
//  Copyright (c) 2013年 Chuan-Chih Chou. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	  // Do any additional setup after loading the view, typically from a nib.
    
    //NSLog(@"%f, %f", self.view.frame.size.width, self.view.frame.size.height);
    //Sanity check: 320.000000, 548.000000 indeed
    
    CGFloat navbarHeight = 42.5;
    CGFloat colorStripHeight = 232/2;//There is a 1-px strip of lighter shade below in the sample rendering. Not sure if it's intentional...
    
    CGFloat nameLabelHeight = 20.5;
    CGFloat nameLabelXPosition = 223.0/2;
    CGFloat nameLabelYPosition = navbarHeight + colorStripHeight + 26.0;
    
    CGFloat locationLabelHeight = 13;
    
    CGFloat followerBarYPosition = navbarHeight + colorStripHeight + 145.0/2;//A 1-px strip again, this time of darker shade, above the follower bar. I highly doubt it's intentional given its shade variation along the length.
    CGFloat followerBarHeight = 89.0/2;
    CGFloat followerBarWidth = 479.0/2;
    
    UIColor* nameFontColor = [UIColor colorWithRed:39.0/255 green:49.0/255 blue:55.0/255 alpha:1.0];
    
    usernameNavbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, navbarHeight)];
    [self.view addSubview:usernameNavbar];
    
    [usernameNavbar pushNavigationItem:[[UINavigationItem alloc] initWithTitle:@""] animated:NO];
    
    [usernameNavbar setBackgroundColor:[UIColor whiteColor]];
    usernameNavbar.tintColor = [UIColor whiteColor];
    usernameNavbar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:nameFontColor, UITextAttributeTextColor, [UIFont fontWithName:@"Aller" size:15], UITextAttributeFont, [UIColor clearColor], UITextAttributeTextShadowColor, nil];
    [usernameNavbar setTitleVerticalPositionAdjustment:3 forBarMetrics:UIBarMetricsDefault];
    
    usernameNavbar.layer.masksToBounds = YES;//Eliminates shadow
    
    UIScrollView* containerScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    containerScrollView.backgroundColor = [UIColor whiteColor];
    
    UIView* colorStripView = [[UIView alloc] initWithFrame:CGRectMake(0, navbarHeight, 320, colorStripHeight)];
    colorStripView.backgroundColor = [UIColor colorWithRed:1.0 green:0.8 blue:0.263 alpha:1.0];//Sentiment 14
    
    [containerScrollView addSubview:colorStripView];
    
    [self.view insertSubview:containerScrollView belowSubview:usernameNavbar];
    
    profilePictureView = [[UIImageView alloc] initWithFrame:CGRectMake(31.0/2, navbarHeight+192/2, 167.0/2, 153.0/2)];//Bizarre layout, but it's what it is...
    [containerScrollView insertSubview:profilePictureView aboveSubview:colorStripView];
    
    profilePictureView.backgroundColor = [UIColor blackColor];
    profilePictureView.contentMode = UIViewContentModeScaleAspectFill;
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelXPosition, nameLabelYPosition, 320.0 - nameLabelXPosition, nameLabelHeight)];
    
    //nameLabel.text = @"Anda Gansca";
    //In the sample rendering, the spacing between 'An' and 'da' are both 3 pixels, but this unmodified UILabel renders 2 and 4 pixels respectively.
    //Also, UILabel's font rasterization gives lighter shade around the edges then the sample rendering. Not sure what the story is here...
    //On the positive side, this label is tall enough to render letters like ç and ț
    
    nameLabel.font = [UIFont fontWithName:@"Aller" size:17.5];
    nameLabel.textColor = nameFontColor;
    
    [containerScrollView insertSubview:nameLabel belowSubview:colorStripView];
    
    locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelXPosition - 0.5, nameLabelYPosition + nameLabelHeight, 320.0 - nameLabelXPosition, locationLabelHeight)];
    
    //locationLabel.text = @"San Francisco, California";
    locationLabel.font = [UIFont fontWithName:@"Aller-Light" size:10.5];
    locationLabel.textColor = [UIColor grayColor];
    
    [containerScrollView addSubview:locationLabel];
    
    UIImageView* followerBarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, followerBarYPosition, followerBarWidth, followerBarHeight)];
    followerBarImageView.image = [UIImage imageNamed:@"followers-bar.png"];
    
    [containerScrollView addSubview:followerBarImageView];
    
    gloryCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.5, 0, 78.0, followerBarHeight - 12)];
    followerCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.5 + 80, 0, 78.0, followerBarHeight - 12)];
    followingCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.5 + 160, 0, 78.0, followerBarHeight - 12)];
    //These labels are also plagued by discrepancies in rasterization shades and letter spacing in comparison to the sample...
    
    
    //gloryCountLabel.text = @"3456";
    //followerCountLabel.text = @"5772";
    //followingCountLabel.text = @"6363";
    
    gloryCountLabel.font = followerCountLabel.font = followingCountLabel.font = [UIFont fontWithName:@"Lato-Bold" size:15.0];
    gloryCountLabel.textColor = followerCountLabel.textColor = followingCountLabel.textColor = [UIColor colorWithRed:15.0/255 green:15.0/255 blue:15.0/255 alpha:1.0];
    gloryCountLabel.backgroundColor = followerCountLabel.backgroundColor = followingCountLabel.backgroundColor = [UIColor clearColor];
    gloryCountLabel.textAlignment = followerCountLabel.textAlignment = followingCountLabel.textAlignment = NSTextAlignmentCenter;
    
    [followerBarImageView addSubview:gloryCountLabel];
    [followerBarImageView addSubview:followerCountLabel];
    [followerBarImageView addSubview:followingCountLabel];
    
    //The corresponding letter labels have true black font color, probably of Aller_Rg
    
    UILabel* gloryTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 79.0, 12)];;
    UILabel* followersTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 + 80, 25, 79.0, 12)];
    UILabel* followingTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 + 160, 25, 79.0, 12)];
    
    gloryTextLabel.text = @"Glory";
    followersTextLabel.text = @"Followers";
    followingTextLabel.text = @"Following";
    
    gloryTextLabel.font = followersTextLabel.font = followingTextLabel.font = [UIFont fontWithName:@"Aller-Light" size:10.0];
    gloryTextLabel.textColor = followersTextLabel.textColor = followingTextLabel.textColor = [UIColor blackColor];
    gloryTextLabel.backgroundColor = followersTextLabel.backgroundColor = followingTextLabel.backgroundColor = [UIColor clearColor];
    gloryTextLabel.textAlignment = followersTextLabel.textAlignment = followingTextLabel.textAlignment = NSTextAlignmentCenter;
    
    [followerBarImageView insertSubview:gloryTextLabel aboveSubview:gloryCountLabel];
    [followerBarImageView insertSubview:followersTextLabel aboveSubview:followerCountLabel];
    [followerBarImageView insertSubview:followingTextLabel aboveSubview:followingCountLabel];
    
    UIImageView* followingButtonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(followerBarWidth, followerBarYPosition, 320.0 - followerBarWidth, followerBarHeight)];
    followingButtonImageView.image = [UIImage imageNamed:@"following-button.png"];
    
    [containerScrollView addSubview:followingButtonImageView];
    
    UIImageView* colourBarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, followerBarYPosition + followerBarHeight, 320.0, 78.0/2)];
    colourBarImageView.image = [UIImage imageNamed:@"colour-bar.png"];
    
    [containerScrollView addSubview:colourBarImageView];
    /*
    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }
    */
}

- (void)viewWillAppear:(BOOL)animated
{
    NSString* userId = //@"500e3b57bbcd08696800000a";//Stephanie Volftsun
                       @"5019296f1f5dc55304003c58";//Anda Gansca
                       //@"51953d29cf0e230f5a001cc6";//Lars Eilstrup Rasmussen
                       //@"5010a4e5e22117476d0000f1";//Lana Volftsun
                       //@"51749a9c3b0d87951700165f";//Kyung Jae Ha
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://dev.knotch.it:8080/miniProject/user_feed/%@/5", userId]]
                                    cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                    timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    
    //NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {
        
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:data
                              
                              options:kNilOptions
                              error:&error];
        
        //NSLog([json description]);
        
        NSDictionary* userInfo = [json objectForKey:@"userInfo"];
        
        NSMutableURLRequest *pictureRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[userInfo objectForKey:@"profilePicUrl"]]
                                               cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                               timeoutInterval:10];
        
        [pictureRequest setHTTPMethod:@"GET"];
        
        [NSURLConnection sendAsynchronousRequest:pictureRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             profilePictureView.image = [UIImage imageWithData:data];
             
         }];
         
        
        usernameNavbar.topItem.title = nameLabel.text = [userInfo objectForKey:@"name"];
        
        NSString* locationString = [userInfo objectForKey:@"location"];
        
        if (locationString) {
            locationLabel.text = locationString;
        }
        else
            locationLabel.text = @"San Francisco, California";  //For some reason, the location data is missing for Anda.
                                                                //If I don't know where you are, you are in SF :D
        
        gloryCountLabel.text = [[userInfo objectForKey:@"num_glory"] stringValue];
        followerCountLabel.text = [[userInfo objectForKey:@"num_followers"] stringValue];
        followingCountLabel.text = [[userInfo objectForKey:@"num_following"] stringValue];
        
    }];
    
    /*
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:response1
                          
                          options:kNilOptions
                          error:&requestError];
    
    //NSLog([json description]);
    
    NSDictionary* userInfo = [json objectForKey:@"userInfo"];
    
    nameLabel.text = [userInfo objectForKey:@"name"];
    gloryCountLabel.text = [[userInfo objectForKey:@"num_glory"] stringValue];
    followerCountLabel.text = [[userInfo objectForKey:@"num_followers"] stringValue];
    followingCountLabel.text = [[userInfo objectForKey:@"num_following"] stringValue];
    */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
