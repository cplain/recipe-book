//
//  MainMenu.m
//  RecipieBook
//
//  Created by Coby Plain on 31/05/13.
//  Copyright (c) 2013 Coby Plain. All rights reserved.
//

#import "MainMenuViewController.h"

@implementation MainMenu

@synthesize browseButton;
@synthesize catergoriesButton;
@synthesize favouritesButton;
@synthesize addButton;

-(IBAction)buttonPressed:(id)sender
{
    int tag = [sender tag];
    
    switch (tag)
    
    {
    
        case 0:
            break;
        case 1:
            break;
            
    }
    
}

-(void)viewDidLoad
{
    [self setUpView];    
}

- (void)setUpView
{
    self.navigationController.navigationBarHidden = FALSE;
    self.navigationItem.hidesBackButton = TRUE;
    self.title = @"Menu";
    
    [self setUpButtons];
}

- (void)setUpButtons
{
    [self addButtonImage: browseButton];
    [self addButtonImage: catergoriesButton];
    [self addButtonImage: favouritesButton];
    [self addButtonImage: addButton];
}

- (void)addButtonImage:(UIButton*)button
{
    UIImage *buttonImage = [[UIImage imageNamed:@"orangeButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"orangeButtonHighlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
}

@end
