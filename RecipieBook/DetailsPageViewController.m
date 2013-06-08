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
@synthesize difficultyField;
@synthesize prepTimeField;
@synthesize cookTimeField;
@synthesize ingredientsField;
@synthesize methodField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadFields];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)loadFields
{
    self.title = [self.recipe valueForKey:@"Recipe name"];
    self.difficultyField.text = [self.recipe valueForKey:@"Difficulty"];
    self.prepTimeField.text = [self.recipe valueForKey:@"Time to prep"];
    self.cookTimeField.text = [self.recipe valueForKey:@"Time to cook"];
    self.ingredientsField.text = [self.recipe valueForKey:@"Ingredients"];
    self.methodField.text = [self.recipe valueForKey:@"Method"];
}

@end
