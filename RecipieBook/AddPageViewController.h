//
//  AddPageViewController.h
//  RecipieBook
//
//  Created by Coby Plain on 6/06/13.
//  Copyright (c) 2013 Coby Plain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPageViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *difficultyField;
@property (nonatomic, retain) IBOutlet UITextField *prepTimeField;
@property (nonatomic, retain) IBOutlet UITextField *cookTimeField;
@property (nonatomic, retain) IBOutlet UITextField *servesField;
@property (nonatomic, retain) IBOutlet UITextField *ingredientsField;
@property (nonatomic, retain) IBOutlet UITextField *methodField;
@property (nonatomic, retain) IBOutlet UIButton *saveButton;

@end
