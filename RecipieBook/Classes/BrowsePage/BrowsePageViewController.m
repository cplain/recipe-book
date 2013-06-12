//
//  BrowsePageViewController.m
//  RecipieBook
//
//  Created by Coby Plain on 6/06/13.
//  Copyright (c) 2013 Coby Plain. All rights reserved.
//

#import "BrowsePageViewController.h"
#import "DetailsPageViewController.h"

@interface BrowsePageViewController ()

@end

@implementation BrowsePageViewController

@synthesize recipeList;
@synthesize recipeNameList;
@synthesize searchKey;
@synthesize tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureTitle];
    [self configureBackButton];
    
}

- (void)viewWillAppear:(BOOL)animated
{    
    self.recipeNameList = [NSMutableArray array];

    if (![self.searchKey isEqualToString:@"List provided"])
        [self readPList];
    
    else
        [self produceCompleteList];
    
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)configureTitle
{
    NSString *title = @"Recipes";
    
    if ([self.searchKey isEqualToString:@"Catergory"])
        title = @"Catergories";
        
    self.title = title;
}

-(void)configureBackButton
{
    NSString *title = @"Back";
    
    if ([self.searchKey isEqualToString:@"List provided"])
        title = @"Catergories";
    
    UIImage *buttonImage = [[UIImage imageNamed:@"orangeButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"orangeButtonHighlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    
    [backButton setBackgroundImage:buttonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [backButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
  
    self.navigationItem.leftBarButtonItem = backButton;

}

-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)readPList
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"RecipeList.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
        plistPath = [[NSBundle mainBundle] pathForResource:@"RecipeList" ofType:@"plist"];
    
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    
    self.recipeList = (NSMutableArray *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    
    if([self.searchKey isEqualToString:@"Recipe name"])
        [self produceCompleteList];
    
    else if ([self.searchKey isEqualToString:@"Catergory"])
        [self produceNoCopysList];
    
    else if ([self.searchKey isEqualToString:@"Favorite"])
        [self produceFavoritesList];
}

- (void)produceCompleteList
{
    for (int i = 0; i < [self.recipeList count]; i++)
    {
        NSString *recipe = [[self.recipeList objectAtIndex:i] valueForKey:@"Recipe name"];
        [self.recipeNameList addObject:recipe];
    }
}

-(void)produceNoCopysList
{
    NSMutableSet *tempSet = [[NSMutableSet alloc]init];
    
    for (int i = 0; i < [self.recipeList count]; i++)
        [tempSet addObject:[[self.recipeList objectAtIndex:i] valueForKey:@"Catergory"]];
    
    self.recipeNameList = [NSMutableArray arrayWithArray:[tempSet allObjects]];
}

-(void)produceFavoritesList
{
    for (int i = 0; i < [self.recipeList count]; i++)
    {
        if ([[[self.recipeList objectAtIndex:i] valueForKey:@"Favorite"] isEqualToString:@"true"])
        {
            NSString *recipe = [[self.recipeList objectAtIndex:i] valueForKey:@"Recipe name"];
            [self.recipeNameList addObject:recipe];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [recipeNameList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.recipeNameList objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    if ([self.searchKey isEqualToString:@"Catergory"])
        [self isCatAndPressedRow:indexPath];
    else
        [self isNameAndPressedRow:indexPath];
}

-(void)isNameAndPressedRow: (NSIndexPath *)indexPath
{
    NSString *recipeName = [self.recipeNameList objectAtIndex:indexPath.row];
    NSDictionary *selectedRecipe = [[NSDictionary alloc] init];
    
    for (int i = 0; i < [self.recipeList count]; i++)
    {
        if([[[self.recipeList objectAtIndex:i] valueForKey:@"Recipe name"] isEqualToString:recipeName])
        {
            selectedRecipe = [self.recipeList objectAtIndex:i];
            break;
        }
    }
    
    DetailsPageViewController *detailsPage = [[DetailsPageViewController alloc] initWithNibName:@"DetailsPageViewController" bundle:nil];
    
    detailsPage.recipe = selectedRecipe;
    detailsPage.recipeList = self.recipeList;
    [self.navigationController pushViewController:detailsPage animated:YES];
    
}

-(void)isCatAndPressedRow: (NSIndexPath *)indexPath
{
    NSString *catName = [self.recipeNameList objectAtIndex:indexPath.row];
    
    NSMutableArray *catContentsArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [self.recipeList count]; i++)
    {
        if([[[self.recipeList objectAtIndex:i] valueForKey:@"Catergory"] isEqualToString:catName])
            [catContentsArray addObject:[self.recipeList objectAtIndex:i]];
    }
    
    BrowsePageViewController *browse = [[BrowsePageViewController alloc] initWithNibName:@"BrowsePageViewController" bundle:nil];
    browse.searchKey = @"List provided";
    browse.recipeList = catContentsArray;
    [self.navigationController pushViewController:browse animated:YES];
}

@end
