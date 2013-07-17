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
    
    UINavigationBar* usernameNavbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, navbarHeight)];
    [self.view addSubview:usernameNavbar];
    
    //usernameNavbar.topItem.title = @"Jane Doe";
    
    [usernameNavbar pushNavigationItem:[[UINavigationItem alloc] initWithTitle:@"Anda Gansca"] animated:NO];
    
    [usernameNavbar setBackgroundColor:[UIColor whiteColor]];
    usernameNavbar.tintColor = [UIColor whiteColor];
    usernameNavbar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], UITextAttributeTextColor, [UIFont fontWithName:@"Aller" size:15], UITextAttributeFont, [UIColor clearColor], UITextAttributeTextShadowColor, nil];
    [usernameNavbar setTitleVerticalPositionAdjustment:3 forBarMetrics:UIBarMetricsDefault];
    
    usernameNavbar.layer.masksToBounds = YES;//Eliminates shadow
    
    UIScrollView* containerScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    containerScrollView.backgroundColor = [UIColor whiteColor];
    
    UIView* colorStripView = [[UIView alloc] initWithFrame:CGRectMake(0, navbarHeight, 320, colorStripHeight)];
    colorStripView.backgroundColor = [UIColor colorWithRed:1.0 green:0.8 blue:0.263 alpha:1.0];//Sentiment 14
    
    [containerScrollView addSubview:colorStripView];
    
    [self.view insertSubview:containerScrollView belowSubview:usernameNavbar];
    
    
    
    //UIOffsetMake(0, 0), UITextAttributeTextShadowOffset
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
