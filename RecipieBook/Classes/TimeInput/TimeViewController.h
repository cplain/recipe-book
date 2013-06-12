//
//  TimeViewController.h
//  RecipieBook
//
//  Created by Coby Plain on 12/06/13.
//  Copyright (c) 2013 Coby Plain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPageViewController.h"

@interface TimeViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIButton *saveButton;
@property (nonatomic, retain) IBOutlet UIDatePicker *timePicker;
@property (nonatomic, retain) UIButton *buttonToMod;
@property (nonatomic) NSInteger mode;

-(IBAction)buttonPressed:(id)sender;

@end
