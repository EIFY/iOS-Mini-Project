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

const CGFloat KnotchTopicHeight = 52;
const CGFloat KnotchContentHeight = 74;
const CGFloat colorgraphicHeight = 8;

CGFloat colourBarYPosition;

const int SPINNER_TAG = 1000;

@interface ViewController ()
- (void) loadKnotches;
- (void) renderColorgraphic;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	  // Do any additional setup after loading the view, typically from a nib.
    
    CGSize appFrameSize = [UIScreen mainScreen].applicationFrame.size;

    totalWidth = appFrameSize.width;
    totalHeight = appFrameSize.height;
    
    CGFloat navbarHeight = 42.5;
    CGFloat colorStripHeight = 232/2;//There is a 1-px strip of lighter shade below in the sample rendering. Not sure if it's intentional...
    
    CGFloat nameLabelHeight = 20.5;
    CGFloat nameLabelXPosition = 223.0/2;
    CGFloat nameLabelYPosition = navbarHeight + colorStripHeight + 26.0;
    
    CGFloat locationLabelHeight = 13;
    
    CGFloat followerBarYPosition = navbarHeight + colorStripHeight + 145.0/2;//A 1-px strip again, this time of darker shade, above the follower bar. I highly doubt it's intentional given its shade variation along the length.
    CGFloat followerBarHeight = 89.0/2;
    CGFloat followerBarWidth = 479.0/2;
    
    colourBarYPosition = followerBarYPosition + followerBarHeight;
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
    
    //In the sample rendering, the spacing between 'An' and 'da' are both 3 pixels, but this unmodified UILabel renders 2 and 4 pixels respectively.
    //Also, UILabel's font rasterization gives lighter shade around the edges then the sample rendering. Not sure what the story is here...
    //On the positive side, this label is tall enough to render letters like ç and ț
    
    nameLabel.font = [UIFont fontWithName:@"Aller" size:17.5];
    nameLabel.textColor = nameFontColor;
    nameLabel.backgroundColor = [UIColor clearColor];//Defensive measure against strange gray line on simulator. May not be relevant on device.
    
    [containerScrollView insertSubview:nameLabel belowSubview:colorStripView];
    
    locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelXPosition - 0.5, nameLabelYPosition + nameLabelHeight, totalWidth - nameLabelXPosition, locationLabelHeight)];
    
    locationLabel.font = [UIFont fontWithName:@"Aller-Light" size:10.5];
    locationLabel.textColor = [UIColor grayColor];
    locationLabel.backgroundColor = [UIColor clearColor];
    
    [containerScrollView addSubview:locationLabel];
    
    UIImageView* followerBarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, followerBarYPosition, followerBarWidth, followerBarHeight)];
    followerBarImageView.image = [UIImage imageNamed:@"followers-bar.png"];
    
    [containerScrollView addSubview:followerBarImageView];
    
    gloryCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.5, 0, 78.0, followerBarHeight - 12)];
    followerCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.5 + 80, 0, 78.0, followerBarHeight - 12)];
    followingCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.5 + 160, 0, 78.0, followerBarHeight - 12)];
    //These labels are also plagued by discrepancies in rasterization shades and letter spacing in comparison to the sample...
    
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
    
    UIView* colourBarBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, colourBarYPosition, totalWidth, colourBarHeight)];
    colourBarBackgroundView.backgroundColor = [UIColor blackColor];
    [containerScrollView addSubview:colourBarBackgroundView];
    
    colorgraphicViews = @[[[UIView alloc] init],
                          [[UIView alloc] init],
                          [[UIView alloc] init],
                          [[UIView alloc] init],
                          [[UIView alloc] init],
                          [[UIView alloc] init],
                          [[UIView alloc] init],
                          [[UIView alloc] init],
                          [[UIView alloc] init],
                          [[UIView alloc] init],
                          [[UIView alloc] init]];
    
    for (int i = 0; i < 11; ++i) {
        
        UIView* colourView = colorgraphicViews[i];
        
        colourView.backgroundColor = [KnotchColor sentiment:i*2];
        [containerScrollView insertSubview:colourView aboveSubview:colourBarBackgroundView];
    }
    
    containerScrollView.contentSize = CGSizeMake(totalWidth, scrollViewContentHeight);//Just big enough to bring colourBarImageView in touch with the nav bar
    
    knotchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, knotchTableViewYPosition, totalWidth, scrollViewContentHeight - knotchTableViewYPosition) style:UITableViewStylePlain];
    knotchTableView.sectionHeaderHeight = KnotchTopicHeight;
    knotchTableView.rowHeight = KnotchContentHeight;
    
    knotchTableView.delegate = self;
    knotchTableView.dataSource = self;
    
    [containerScrollView addSubview:knotchTableView];
    
    numberOfKnotchesToLoad = 40;
}

- (void) loadKnotches
{
    NSString* userId = @"500e3b57bbcd08696800000a";//Stephanie Volftsun
                       //@"5019296f1f5dc55304003c58";//Anda Gansca
                       //@"51953d29cf0e230f5a001cc6";//Lars Eilstrup Rasmussen
                       //@"5010a4e5e22117476d0000f1";//Lana Volftsun
                       //@"51749a9c3b0d87951700165f";//Kyung Jae Ha
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://dev.knotch.it:8080/miniProject/user_feed/%@/%i", userId, numberOfKnotchesToLoad]]
                                    cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         
         NSDictionary* json = [NSJSONSerialization
                               JSONObjectWithData:data
                               
                               options:kNilOptions
                               error:&error];
         
         NSDictionary* userInfo = json[@"userInfo"];
         
         //Profile picture doesn't change often. It only loads if there isn't one already.
         if (!profilePictureView.image) {
             
             NSMutableURLRequest *pictureRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[userInfo objectForKey:@"profilePicUrl"]]
                                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                                       timeoutInterval:10];
             
             [pictureRequest setHTTPMethod:@"GET"];
             
             [NSURLConnection sendAsynchronousRequest:pictureRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
              {
                  profilePictureView.image = [UIImage imageWithData:data];

              }];
             
         }
         
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
         
         [self renderColorgraphic];
         [knotchTableView reloadData];
     }];
}

- (void) renderColorgraphic
{
    int knotchCounts[11] = {0};

    for (NSDictionary* knotch in knotches)
        ++knotchCounts[[knotch[@"sentiment"] intValue]/2];
    
    int totalCount = 0;
    
    for (int i=0; i<11; ++i)
        totalCount += knotchCounts[i];
    
    CGFloat colorgraphicFullWidth = totalWidth - 2*KnotchMargin;
    CGFloat colorgraphicYPosition = colourBarYPosition + KnotchMargin;
    CGFloat colourViewXPosition = KnotchMargin;
    
    for (int i=0; i<11; ++i)
    {
        UIView* colourView = colorgraphicViews[i];
        
        CGFloat colourViewWidth = colorgraphicFullWidth * knotchCounts[i] / totalCount;
        colourView.frame = CGRectMake(colourViewXPosition, colorgraphicYPosition, colourViewWidth, colorgraphicHeight);
        
        colourViewXPosition += colourViewWidth;
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadKnotches];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    /*
     
     "Transfer" the y offset from the knotch table to the container scroll view if 1. more of the table can be shown or 2. we are at the top of the table, like the official app.
     
     Unlike the full-blown official app, there is no Category bar and Colour bar doesn't serve as filter. So as it is, you can grab the Colour bar and scroll back to the profile info.
     So far, so good. But if the Knotch Table is already scrolled to the middle, resuming scrolling would result in "jumpy" behavior: Knotch Table scrolls to the top and shows from
     the first Knotch onwards. It's not clear what an improvement should be for this edge case, however, so I left it as it is.
     
    */
    
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
    sectionHeaderView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.947];//Alpha value reverse-engineered  from the official app store version
    
    UIImageView* topicArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(topicArrowImageXPosition, 25.0/2, 17, 27)];
    topicArrowImageView.image = [UIImage imageNamed:@"topic-arrow.png"];
    
    [sectionHeaderView addSubview:topicArrowImageView];
    
    UILabel* knotchTopicLabel = [[UILabel alloc] initWithFrame:CGRectMake(KnotchMargin, 0, topicArrowImageXPosition - KnotchMargin, KnotchTopicHeight)];
    knotchTopicLabel.text = knotches[section][@"topic"];
    knotchTopicLabel.font = [UIFont fontWithName:@"Aller" size:15];
    knotchTopicLabel.textColor = nameFontColor;
    knotchTopicLabel.backgroundColor = [UIColor clearColor];
    
    [sectionHeaderView addSubview:knotchTopicLabel];
    
    return sectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        
        //The spinner is exposed: load more knotches!
        
        numberOfKnotchesToLoad += 20;
        [self loadKnotches];
        
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SpinnerCell"];
        
        UIActivityIndicatorView* spinner;
        
        if (cell == nil) {
            cell = [[KnotchTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SpinnerCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, totalWidth, KnotchContentHeight)];
            spinner.tag = SPINNER_TAG;

            [cell.contentView addSubview:spinner];
        }
        else
            spinner = (UIActivityIndicatorView*) [cell viewWithTag:SPINNER_TAG];//Type casting...but I know what I am doing!
        
        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [spinner startAnimating];
        
        return cell;
        
    }
    else
    {    
        KnotchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KnotchCell"];
        
        if (cell == nil) {
            cell = [[KnotchTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"KnotchCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        NSDictionary* knotch = knotches[indexPath.section];
        
        cell.sentiment = [knotch[@"sentiment"] intValue];
        cell.textLabel.text = knotch[@"comment"];
        
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [knotches count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Only the last section has another two rows: KnotchCell and SpinnerCell, the later indicating that more Knotches are coming
    return (section == [knotches count] - 1) ? 2:1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
