//
//  CatergoriesPageViewController.m
//  RecipieBook
//
//  Created by Coby Plain on 6/06/13.
//  Copyright (c) 2013 Coby Plain. All rights reserved.
//

#import "CatergoriesPageViewController.h"

@interface CatergoriesPageViewController ()

@end

@implementation CatergoriesPageViewController

@synthesize recipeList;
@synthesize recipeNameList;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self readPList];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)readPList
{
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"RecipeList" ofType:@"plist"];    self.recipeList = [[NSMutableArray arrayWithContentsOfFile:plistCatPath] copy];
    self.recipeNameList = self.recipeNameList ? self.recipeNameList:[NSMutableArray array];
    
    for (int i = 0; i < [self.recipeList count]; i++)
    {
        NSString *recipe = [[self.recipeList objectAtIndex:i] valueForKey:@"Recipe name"];
        [self.recipeNameList addObject:recipe];
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


@end
