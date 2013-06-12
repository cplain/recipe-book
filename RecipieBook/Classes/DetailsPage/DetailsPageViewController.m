//
//  DetailsPageViewController.m
//  RecipieBook
//
//  Created by Coby Plain on 8/06/13.
//  Copyright (c) 2013 Coby Plain. All rights reserved.
//

#import "DetailsPageViewController.h"

@interface DetailsPageViewController ()

@end

@implementation DetailsPageViewController

@synthesize recipe;
@synthesize recipeList;
@synthesize difficultyField;
@synthesize prepTimeField;
@synthesize cookTimeField;
@synthesize ingredientsField;
@synthesize methodField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureBackButton];
    [self loadFields];
    [self setUpFavoritesButton];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)configureBackButton
{
    UIImage *buttonImage = [[UIImage imageNamed:@"orangeButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"orangeButtonHighlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Recipes" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    
    [backButton setBackgroundImage:buttonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [backButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    self.navigationItem.leftBarButtonItem = backButton;
}

-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadFields
{
    self.title = [self.recipe valueForKey:@"Recipe name"];
    self.difficultyField.text = [self.recipe valueForKey:@"Difficulty"];
    
    if ([[self.recipe valueForKey:@"Difficulty"]isEqualToString:@"Easy"])
        [self.difficultyField setTextColor:[UIColor greenColor]];
    
    else if ([[self.recipe valueForKey:@"Difficulty"]isEqualToString:@"Medium"])
        [self.difficultyField setTextColor:[UIColor yellowColor]];
    
    else
        [self.difficultyField setTextColor:[UIColor redColor]];
    
    self.prepTimeField.text = [self.recipe valueForKey:@"Time to prep"];
    self.cookTimeField.text = [self.recipe valueForKey:@"Time to cook"];
    self.ingredientsField.text = [self.recipe valueForKey:@"Ingredients"];
    self.methodField.text = [self.recipe valueForKey:@"Method"];
    self.servesField.text = [self.recipe valueForKey:@"Serves"];

}


- (void)setUpFavoritesButton
{
    UIButton * starButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if ([[self.recipe valueForKey:@"Favorite"] isEqualToString:@"true"]) {
        [starButton setImage:[UIImage imageNamed:@"orangeStarButtonHighlight.png"] forState:UIControlStateNormal];
        [starButton addTarget:self action:@selector(removeFavorite:) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        [starButton setImage:[UIImage imageNamed:@"orangeStarButton.png"] forState:UIControlStateNormal];
        [starButton addTarget:self action:@selector(addFavorite:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    starButton.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem * starBarButton = [[UIBarButtonItem alloc] initWithCustomView:starButton];
    self.navigationItem.rightBarButtonItem = starBarButton;
    self.navigationItem.rightBarButtonItem.target=self;
}

- (IBAction)addFavorite:(id)sender
{
    [self buildModifiedRecipe:@"true"];
}

- (IBAction)removeFavorite:(id)sender
{
    [self buildModifiedRecipe:@"false"];
}

- (void)buildModifiedRecipe:(NSString*)favorite
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"RecipeList.plist"];
    
    NSDictionary *recipeDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                                    [self.recipe valueForKey:@"Recipe name"],
                                                                    [self.recipe valueForKey:@"Catergory"],
                                                                    [self.recipe valueForKey:@"Difficulty"],
                                                                    [self.recipe valueForKey:@"Time to prep"],
                                                                    [self.recipe valueForKey:@"Time to cook"],
                                                                    [self.recipe valueForKey:@"Serves"],
                                                                    [self.recipe valueForKey:@"Ingredients"],
                                                                    [self.recipe valueForKey:@"Method"],
                                                                    favorite,
                                                                    nil]
                                
                                                           forKeys:[NSArray arrayWithObjects:
                                                                    @"Recipe name",
                                                                    @"Catergory",
                                                                    @"Difficulty",
                                                                    @"Time to prep",
                                                                    @"Time to cook",
                                                                    @"Serves",
                                                                    @"Ingredients",
                                                                    @"Method",
                                                                    @"Favorite",
                                                                    nil]];
    

    for (int i = 0; i < [self.recipeList count]; i++)
    {
        if([[[self.recipeList objectAtIndex:i] valueForKey:@"Recipe name"] isEqualToString:[self.recipe valueForKey:@"Recipe name"]])
        {
            [self.recipeList replaceObjectAtIndex:i withObject:recipeDict];
            break;
        }
    }
    
    NSString *error = nil;
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:self.recipeList format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
    
    if(plistData)
        [plistData writeToFile:plistPath atomically:YES];
    
    else
        NSLog(@"Error in saveData: %@", error);
    
    self.recipe = recipeDict;
    [self setUpFavoritesButton];
}

@end
