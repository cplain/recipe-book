//
//  DetailsPageViewController.h
//  RecipieBook
//
//  Created by Coby Plain on 8/06/13.
//  Copyright (c) 2013 Coby Plain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsPageViewController : UIViewController

@property(nonatomic, retain) NSDictionary *recipe;
@property(nonatomic, retain) IBOutlet UILabel *difficultyField;
@property(nonatomic, retain) IBOutlet UILabel *prepTimeField;
@property(nonatomic, retain) IBOutlet UILabel *cookTimeField;
@property(nonatomic, retain) IBOutlet UITextView *ingredientsField;
@property(nonatomic, retain) IBOutlet UITextView *methodField;

@end
