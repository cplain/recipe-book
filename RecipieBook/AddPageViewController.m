//
//  AddPageViewController.m
//  RecipieBook
//
//  Created by Coby Plain on 6/06/13.
//  Copyright (c) 2013 Coby Plain. All rights reserved.
//

#import "AddPageViewController.h"

@interface AddPageViewController ()

@property (nonatomic) CGRect originalScrollerDimens;

-(void)keyboardWasShown:(NSNotification *)notification;
-(void)keyboardWillHide:(NSNotification *)notification;

@end

@implementation AddPageViewController

@synthesize recipeList;
@synthesize nameField;
@synthesize catergoryField;
@synthesize difficultyField;
@synthesize prepTimeField;
@synthesize cookTimeField;
@synthesize ingredientsField;
@synthesize methodField;
@synthesize saveButton;
@synthesize scrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addButtonImage:saveButton];
    [self readPList];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)addButtonImage:(UIButton*)button
{
    UIImage *buttonImage = [[UIImage imageNamed:@"orangeButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"orangeButtonHighlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
}

- (void)readPList
{
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"RecipeList" ofType:@"plist"];
    self.recipeList = [[NSMutableArray arrayWithContentsOfFile:plistCatPath] copy];
}

-(void)commit:(id)sender
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsPath = [paths objectAtIndex:0];    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"RecipeList.plist"];
//    
//    NSDictionary *recipeDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: self.nameField.text, self.catergoryField.text, self.difficultyField.text, self.prepTimeField.text
//                                                                    , self.cookTimeField.text, self.servesField.text, self.ingredientsField.text, self.methodField.text, nil] forKeys:[NSArray arrayWithObjects: @"Recipe name", @"Catergory", @"Difficulty", @"Time to prep", @"Time to cook", @"Serves", "@Ingredients", @"Method", nil]];
//    
//    [self.recipeList addObject:recipeDict];
//    
//    NSString *error = nil;
//    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:self.recipeList format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
//
//    if(plistData)
//        [plistData writeToFile:plistPath atomically:YES];
//    
//    else
//        NSLog(@"Error in saveData: %@", error);
    
}

-(void)keyboardWasShown:(NSNotification *)notification
{
    float viewWidth = self.view.frame.size.width;
    float viewHeight = self.view.frame.size.height;

    NSDictionary *keyboardInfo = [notification userInfo];
    CGSize keyboardSize = [[keyboardInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    float keyboardHeight = keyboardSize.height;
    
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        keyboardHeight = keyboardSize.width;
        float temp = viewWidth;
        viewWidth = viewHeight;
        viewHeight = temp;
    }
    
    CGRect viewableAreaFrame = CGRectMake(0.0, 0.0, viewWidth, viewHeight - keyboardHeight);
    [self.scrollView setFrame:viewableAreaFrame];
    
}

-(void)keyboardWillHide:(NSNotification *)notification{
    NSLog(@"Keyboard is closing.");
    [self.scrollView setFrame:_originalScrollerDimens];
}

@end
