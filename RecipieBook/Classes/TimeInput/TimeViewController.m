//
//  TimeViewController.m
//  RecipieBook
//
//  Created by Coby Plain on 12/06/13.
//  Copyright (c) 2013 Coby Plain. All rights reserved.
//

#import "TimeViewController.h"
#import "AddPageViewController.h"

@interface TimeViewController ()

@end

@implementation TimeViewController

@synthesize buttonToMod;
@synthesize timePicker;
@synthesize saveButton;
@synthesize mode;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureBackButton];
    [self configureTitle];
    [self addButtonImage:self.saveButton];
}

-(void)configureBackButton
{
    UIImage *buttonImage = [[UIImage imageNamed:@"orangeButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"orangeButtonHighlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    
    [backButton setBackgroundImage:buttonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [backButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    self.navigationItem.leftBarButtonItem = backButton;
}

-(void)configureTitle
{
    switch (self.mode) {
        case 1:
            self.title = @"Prep time";
            break;
            
        case 2:
            self.title = @"Cook time";
            break;
            
        default:
            break;
    }
}

-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addButtonImage:(UIButton*)button
{
    UIImage *buttonImage = [[UIImage imageNamed:@"orangeButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"orangeButtonHighlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
}

-(IBAction)buttonPressed:(id)sender
{
    NSString *buttonDisplay = @"";
    
    NSInteger seconds = (NSInteger)self.timePicker.countDownDuration;
    NSInteger hours = (seconds / 60) / 60;
    NSInteger minutes = (seconds / 60) - (hours * 60);
    
    
    if (hours > 0 && hours < 2)
        buttonDisplay = [NSString stringWithFormat:@"%ld hr ", (long)hours];
    
    else if (hours > 0)
        buttonDisplay = [NSString stringWithFormat:@"%ld hrs ", (long)hours];
    
    
    if (minutes > 0 && minutes < 2)
        buttonDisplay = [NSString stringWithFormat:@"%@%ld min", buttonDisplay, (long)minutes];
    
    else if (minutes > 0)
        buttonDisplay = [NSString stringWithFormat:@"%@%ld mins", buttonDisplay, (long)minutes];
    
    
    [self.buttonToMod setTitle:buttonDisplay forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
