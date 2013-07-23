//
//  ViewController.m
//  Knotch Mini Project
//
//  Created by Chuan-Chih Chou on 13/07/15.
//  Copyright (c) 2013年 Chuan-Chih Chou. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ViewController.h"

#import "KnotchColor.h"

#import "KnotchTableViewCell.h"

CGFloat KnotchTopicHeight = 52;
CGFloat KnotchContentHeight = 74;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	  // Do any additional setup after loading the view, typically from a nib.

    totalWidth = self.view.frame.size.width;
    totalHeight = self.view.frame.size.height;
    
    CGFloat navbarHeight = 42.5;
    CGFloat colorStripHeight = 232/2;//There is a 1-px strip of lighter shade below in the sample rendering. Not sure if it's intentional...
    
    CGFloat nameLabelHeight = 20.5;
    CGFloat nameLabelXPosition = 223.0/2;
    CGFloat nameLabelYPosition = navbarHeight + colorStripHeight + 26.0;
    
    CGFloat locationLabelHeight = 13;
    
    CGFloat followerBarYPosition = navbarHeight + colorStripHeight + 145.0/2;//A 1-px strip again, this time of darker shade, above the follower bar. I highly doubt it's intentional given its shade variation along the length.
    CGFloat followerBarHeight = 89.0/2;
    CGFloat followerBarWidth = 479.0/2;
    
    CGFloat colourBarYPosition = followerBarYPosition + followerBarHeight;
    CGFloat colourBarHeight = 78.0/2;
    
    CGFloat scrollViewContentHeight = totalHeight + colourBarYPosition - navbarHeight;
    CGFloat knotchTableViewYPosition = colourBarYPosition + colourBarHeight;
    
    nameFontColor = [UIColor colorWithRed:39.0/255 green:49.0/255 blue:55.0/255 alpha:1.0];
    
    usernameNavbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, totalWidth, navbarHeight)];
    [self.view addSubview:usernameNavbar];
    
    [usernameNavbar pushNavigationItem:[[UINavigationItem alloc] initWithTitle:@""] animated:NO];
    
    [usernameNavbar setBackgroundColor:[UIColor whiteColor]];
    usernameNavbar.tintColor = [UIColor whiteColor];
    
    usernameNavbar.titleTextAttributes = @{UITextAttributeTextColor:nameFontColor,
                                           UITextAttributeFont:[UIFont fontWithName:@"Aller" size:15],
                                           UITextAttributeTextShadowColor:[UIColor clearColor]};
    
    [usernameNavbar setTitleVerticalPositionAdjustment:3 forBarMetrics:UIBarMetricsDefault];
    
    usernameNavbar.layer.masksToBounds = YES;//Eliminates shadow
    
    containerScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    //containerScrollView.bounces = NO;
    containerScrollView.delegate = self;
    containerScrollView.backgroundColor = [UIColor whiteColor];
    containerScrollView.showsVerticalScrollIndicator = NO;
    
    UIView* colorStripView = [[UIView alloc] initWithFrame:CGRectMake(0, navbarHeight, totalWidth, colorStripHeight)];
    colorStripView.backgroundColor = [KnotchColor sentiment:14];//Sentiment 14
    
    [containerScrollView addSubview:colorStripView];
    
    [self.view insertSubview:containerScrollView belowSubview:usernameNavbar];
    
    profilePictureView = [[UIImageView alloc] initWithFrame:CGRectMake(31.0/2, navbarHeight+192/2, 167.0/2, 153.0/2)];//Bizarre layout, but it's what it is...
    [containerScrollView insertSubview:profilePictureView aboveSubview:colorStripView];
    
    profilePictureView.backgroundColor = [UIColor clearColor];
    profilePictureView.contentMode = UIViewContentModeScaleAspectFill;
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelXPosition, nameLabelYPosition, totalWidth - nameLabelXPosition, nameLabelHeight)];
    
    //nameLabel.text = @"Anda Gansca";
    //In the sample rendering, the spacing between 'An' and 'da' are both 3 pixels, but this unmodified UILabel renders 2 and 4 pixels respectively.
    //Also, UILabel's font rasterization gives lighter shade around the edges then the sample rendering. Not sure what the story is here...
    //On the positive side, this label is tall enough to render letters like ç and ț
    
    nameLabel.font = [UIFont fontWithName:@"Aller" size:17.5];
    nameLabel.textColor = nameFontColor;
    
    [containerScrollView insertSubview:nameLabel belowSubview:colorStripView];
    
    locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelXPosition - 0.5, nameLabelYPosition + nameLabelHeight, totalWidth - nameLabelXPosition, locationLabelHeight)];
    
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
    
    UIImageView* followingButtonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(followerBarWidth, followerBarYPosition, totalWidth - followerBarWidth, followerBarHeight)];
    followingButtonImageView.image = [UIImage imageNamed:@"following-button.png"];
    
    [containerScrollView addSubview:followingButtonImageView];
    
    UIImageView* colourBarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, colourBarYPosition, totalWidth, colourBarHeight)];
    colourBarImageView.image = [UIImage imageNamed:@"colour-bar.png"];
    
    [containerScrollView addSubview:colourBarImageView];
    
    containerScrollView.contentSize = CGSizeMake(totalWidth, scrollViewContentHeight);//Just big enough to bring colourBarImageView in touch with the nav bar
    
    knotchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, knotchTableViewYPosition, totalWidth, scrollViewContentHeight - knotchTableViewYPosition) style:UITableViewStylePlain];
    knotchTableView.sectionHeaderHeight = KnotchTopicHeight;
    knotchTableView.rowHeight = KnotchContentHeight;
    
    knotchTableView.delegate = self;
    knotchTableView.dataSource = self;
    
    [containerScrollView addSubview:knotchTableView];
    
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
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://dev.knotch.it:8080/miniProject/user_feed/%@/40", userId]]
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
        
        NSDictionary* userInfo = json[@"userInfo"];
        
        NSMutableURLRequest *pictureRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[userInfo objectForKey:@"profilePicUrl"]]
                                               cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                               timeoutInterval:10];
        
        [pictureRequest setHTTPMethod:@"GET"];
        
        [NSURLConnection sendAsynchronousRequest:pictureRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             profilePictureView.image = [UIImage imageWithData:data];
             
         }];
         
        
        usernameNavbar.topItem.title = nameLabel.text = userInfo[@"name"];
        
        NSString* locationString = userInfo[@"location"];
        
        if (locationString) {
            locationLabel.text = locationString;
        }
        else
            locationLabel.text = @"San Francisco, California";  //For some reason, the location data is missing for Anda.
                                                                //If I don't know where you are, you are in SF :D
        
        gloryCountLabel.text = [userInfo[@"num_glory"] stringValue];
        followerCountLabel.text = [userInfo[@"num_followers"] stringValue];
        followingCountLabel.text = [userInfo[@"num_following"] stringValue];
        
        knotches = json[@"knotches"];
        
        [knotchTableView reloadData];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //"Transfer" the y offset from the knotch table to the container scroll view if 1. more of the table can be shown or 2. we are at the top of the table, like the official app
    
    if (scrollView == knotchTableView) {
        
        if (containerScrollView.contentOffset.y < 233.0 || knotchTableView.contentOffset.y < 0)
        {
            CGPoint offset = containerScrollView.contentOffset;
            
            offset.y += knotchTableView.contentOffset.y;
            
            //Protection against rare madness
            if (offset.y > 233.0)
                offset.y = 233.0;
            else if (offset.y < 0.0)
                offset.y = 0.0;
            
            containerScrollView.contentOffset = offset;
            
            knotchTableView.contentOffset = CGPointZero;
        }
        
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat topicArrowImageXPosition = 576/2;
    
    UIView* sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, totalWidth, KnotchTopicHeight)];
    sectionHeaderView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.947];//Reverse-engineered alpha value from the official app store version
    
    UIImageView* topicArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(topicArrowImageXPosition, 25.0/2, 17, 27)];
    topicArrowImageView.image = [UIImage imageNamed:@"topic-arrow.png"];
    
    [sectionHeaderView addSubview:topicArrowImageView];
    
    UILabel* knotchTopicLabel = [[UILabel alloc] initWithFrame:CGRectMake(KnotchMargin, 0, topicArrowImageXPosition - KnotchMargin, KnotchTopicHeight)];
    knotchTopicLabel.text = knotches[section][@"topic"];//@"Women In Dresses";
    knotchTopicLabel.font = [UIFont fontWithName:@"Aller" size:15];
    knotchTopicLabel.textColor = nameFontColor;
    knotchTopicLabel.backgroundColor = [UIColor clearColor];
    
    [sectionHeaderView addSubview:knotchTopicLabel];
    
    return sectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KnotchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KnotchCell"];
    
    if (cell == nil) {
        cell = [[KnotchTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"KnotchCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary* knotch = knotches[indexPath.section];
    
    cell.sentiment = [knotch[@"sentiment"] intValue];//cell.colorBlockView.backgroundColor = [KnotchColor sentiment:[knotch[@"sentiment"] intValue]];//KnotchSentimentColors[[knotch[@"sentiment"] intValue]/2];
    cell.detailTextLabel.text = knotch[@"comment"];

    //Or spinner:
    //UIActivityIndicatorView
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [knotches count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
