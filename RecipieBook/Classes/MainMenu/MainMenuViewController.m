//
//  MainMenu.m
//  RecipieBook
//
//  Created by Coby Plain on 31/05/13.
//  Copyright (c) 2013 Coby Plain. All rights reserved.
//

#import "MainMenuViewController.h"
#import "BrowsePageViewController.h"
#import "AddPageViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

@synthesize browseButton;
@synthesize catergoriesButton;
@synthesize favouritesButton;
@synthesize addButton;

-(IBAction)buttonPressed:(id)sender
{
    int tag = [sender tag];
    
    switch (tag)
    
    {
    
        case 1:
            [self moveToBrowse: @"Recipe name"];
            break;
            
        case 2:
            [self moveToBrowse: @"Catergory"];
            break;
        
        case 3:
            [self moveToBrowse: @"Favorite"];
            break;
            
        case 4:
            [self moveToAdd];
            break;
            
    }
    
}

-(void)viewDidLoad
{
    [self setUpView];
}

- (void)setUpView
{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.title = @"On the menu";
    
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

-(void)moveToBrowse:(NSString*)searchKey
{
    BrowsePageViewController *browse = [[BrowsePageViewController alloc] initWithNibName:@"BrowsePageViewController" bundle:nil];
    browse.searchKey = searchKey;
    [self.navigationController pushViewController:browse animated:YES];
}

-(void)moveToAdd
{
    AddPageViewController *add = [[AddPageViewController alloc] initWithNibName:@"AddPageViewController" bundle:nil];
    [self.navigationController pushViewController:add animated:YES];
}

@end
