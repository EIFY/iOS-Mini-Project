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
    CGFloat nameLabelHeight = 144/2;
    UIColor* nameFontColor = [UIColor colorWithRed:39.0/255 green:49.0/255 blue:55.0/255 alpha:1.0];
    //NSMutableDictionary AllerTextAttributes
    
    UINavigationBar* usernameNavbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, navbarHeight)];
    [self.view addSubview:usernameNavbar];
    
    //usernameNavbar.topItem.title = @"Jane Doe";
    
    [usernameNavbar pushNavigationItem:[[UINavigationItem alloc] initWithTitle:@"Anda Gansca"] animated:NO];
    
    [usernameNavbar setBackgroundColor:[UIColor whiteColor]];
    usernameNavbar.tintColor = [UIColor whiteColor];
    usernameNavbar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:nameFontColor, UITextAttributeTextColor, [UIFont fontWithName:@"Aller" size:15], UITextAttributeFont, [UIColor clearColor], UITextAttributeTextShadowColor, nil];
    //RGB = (39, 49, 55)
    [usernameNavbar setTitleVerticalPositionAdjustment:3 forBarMetrics:UIBarMetricsDefault];
    
    usernameNavbar.layer.masksToBounds = YES;//Eliminates shadow
    
    UIScrollView* containerScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    containerScrollView.backgroundColor = [UIColor whiteColor];
    
    UIView* colorStripView = [[UIView alloc] initWithFrame:CGRectMake(0, navbarHeight, 320, colorStripHeight)];
    colorStripView.backgroundColor = [UIColor colorWithRed:1.0 green:0.8 blue:0.263 alpha:1.0];//Sentiment 14
    
    [containerScrollView addSubview:colorStripView];
    
    [self.view insertSubview:containerScrollView belowSubview:usernameNavbar];
    
    UIImageView* profilePictureView = [[UIImageView alloc] initWithFrame:CGRectMake(31.0/2, navbarHeight+192/2, 167.0/2, 153.0/2)];//Bizarre layout, but it's what it is...
    [containerScrollView insertSubview:profilePictureView aboveSubview:colorStripView];
    
    profilePictureView.backgroundColor = [UIColor blackColor];
    
    UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, navbarHeight + colorStripHeight, 320, nameLabelHeight)];
    
    nameLabel.text = @"Anda Ganscaç";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont fontWithName:@"Aller" size:17.5];
    nameLabel.textColor = nameFontColor;
    
    //NSMutableAttributedString *attributedString;
    //attributedString = [[NSMutableAttributedString alloc] initWithString:@"Anda Gansca"];
    //[attributedString addAttribute:NSKernAttributeName value:@0.5 range:NSMakeRange(0, 10)];
    //[attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Aller" size:17.5] range:NSMakeRange(0, 10)];
    //[attributedString addAttribute:<#(NSString *)#> value:<#(id)#> range:<#(NSRange)#>]
    
    //nameLabel.attributedText = attributedString;
    
    //nameLabel.shadowColor = [UIColor blackColor];
    //nameLabel.shadowOffset = CGSizeMake(0, 1);
    
    [containerScrollView insertSubview:nameLabel belowSubview:colorStripView];
    
    //UIOffsetMake(0, 0), UITextAttributeTextShadowOffset
    
    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
