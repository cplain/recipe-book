//
//  ViewController.m
//  RecipieBook
//
//  Created by Coby Plain on 31/05/13.
//  Copyright (c) 2013 Coby Plain. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "MainMenuViewController.h"

@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)moveToMenu:(id)sender
{
    MainMenuViewController *mainMenu = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:nil];
    [self.navigationController pushViewController:mainMenu animated:YES];
}

@end
