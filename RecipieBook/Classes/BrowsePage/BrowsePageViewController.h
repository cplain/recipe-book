//
//  BrowsePageViewController.h
//  RecipieBook
//
//  Created by Coby Plain on 6/06/13.
//  Copyright (c) 2013 Coby Plain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowsePageViewController : UIViewController

@property (nonatomic, retain) NSMutableArray *recipeList;
@property (nonatomic, retain) NSMutableArray *recipeNameList;
@property (nonatomic, retain) NSString *searchKey;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
