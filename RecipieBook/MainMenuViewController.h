//
//  MainMenu.h
//  RecipieBook
//
//  Created by Coby Plain on 31/05/13.
//  Copyright (c) 2013 Coby Plain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UIViewController

-(IBAction)buttonPressed:(id)sender;

@property (nonatomic, retain) IBOutlet UIButton *browseButton;
@property (nonatomic, retain) IBOutlet UIButton *catergoriesButton;
@property (nonatomic, retain) IBOutlet UIButton *favouritesButton;
@property (nonatomic, retain) IBOutlet UIButton *addButton;

@end
