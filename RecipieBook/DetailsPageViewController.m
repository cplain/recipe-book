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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [self.recipe valueForKey:@"Recipe name"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
