//
//  ViewController.m
//  RecipieBook
//
//  Created by Coby Plain on 31/05/13.
//  Copyright (c) 2013 Coby Plain. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "MainMenuViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBarHidden = TRUE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fling:(id)sender
{
    MainMenu *mainMenu = [[MainMenu alloc] initWithNibName:@"MainMenu" bundle:nil];
    [self.navigationController pushViewController:mainMenu animated:YES];
}

@end
