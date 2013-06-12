//
//  AddPageViewController.h
//  RecipieBook
//
//  Created by Coby Plain on 6/06/13.
//  Copyright (c) 2013 Coby Plain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPageViewController : UIViewController

@property (nonatomic, retain) NSMutableArray *recipeList;
@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *catergoryField;
@property (nonatomic, retain) IBOutlet UISegmentedControl *difficultyControl;
@property (nonatomic, retain) IBOutlet UIButton *prepTimeField;
@property (nonatomic, retain) IBOutlet UIButton *cookTimeField;
@property (nonatomic, retain) IBOutlet UITextField *servesField;
@property (nonatomic, retain) IBOutlet UITextField *ingredientsField;
@property (nonatomic, retain) IBOutlet UITextField *methodField;
@property (nonatomic, retain) IBOutlet UIButton *saveButton;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

-(IBAction)commit:(id)sender;
-(IBAction)toTime:(id)sender;
-(IBAction)valueChanged:(id)sender;

@end
