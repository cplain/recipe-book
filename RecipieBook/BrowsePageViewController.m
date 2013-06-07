//
//  BrowsePageViewController.m
//  RecipieBook
//
//  Created by Coby Plain on 6/06/13.
//  Copyright (c) 2013 Coby Plain. All rights reserved.
//

#import "BrowsePageViewController.h"

@interface BrowsePageViewController ()

@end

@implementation BrowsePageViewController

@synthesize recipeList;
@synthesize recipeNameList;
@synthesize searchKey;

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
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"RecipeList.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
        plistPath = [[NSBundle mainBundle] pathForResource:@"RecipeList" ofType:@"plist"];
    
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    
    self.recipeList = (NSMutableArray *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    self.recipeNameList = self.recipeNameList ? self.recipeNameList:[NSMutableArray array];
    
    for (int i = 0; i < [self.recipeList count]; i++)
    {
        NSString *recipe = [[self.recipeList objectAtIndex:i] valueForKey:self.searchKey];
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
