//
//  AddPageViewController.m
//  RecipieBook
//
//  Created by Coby Plain on 6/06/13.
//  Copyright (c) 2013 Coby Plain. All rights reserved.
//

#import "AddPageViewController.h"
#import "AutocompletionTableView.h"
#import "TimeViewController.h"

@interface AddPageViewController ()

@property (nonatomic) CGRect originalScrollerDimens;

-(void)keyboardWasShown:(NSNotification *)notification;
-(void)keyboardWillHide:(NSNotification *)notification;

@end

@implementation AddPageViewController

@synthesize recipeList;
@synthesize nameField;
@synthesize catergoryField;
@synthesize difficultyControl;
@synthesize prepTimeField;
@synthesize cookTimeField;
@synthesize ingredientsField;
@synthesize methodField;
@synthesize saveButton;
@synthesize scrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Add recipe";
    [self configureBackButton];
    [self addButtonImage:saveButton];
    [self addButtonImage:prepTimeField];
    [self addButtonImage:cookTimeField];
    [self readPList];
    [self.catergoryField addTarget:[self autoCompleter] action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)configureBackButton
{
    UIImage *buttonImage = [[UIImage imageNamed:@"orangeButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"orangeButtonHighlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    
    [backButton setBackgroundImage:buttonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [backButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    self.navigationItem.leftBarButtonItem = backButton;
}

-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"RecipeList.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
        plistPath = [[NSBundle mainBundle] pathForResource:@"RecipeList" ofType:@"plist"];
    
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    
    self.recipeList = (NSMutableArray *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];

}

- (AutocompletionTableView *)autoCompleter
{
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithCapacity:2];
    [options setValue:[NSNumber numberWithBool:YES] forKey:ACOCaseSensitive];
    [options setValue:nil forKey:ACOUseSourceFont];
        
    AutocompletionTableView *autoCompleter = [[AutocompletionTableView alloc] initWithTextField:self.catergoryField inViewController:self withOptions:options];
    autoCompleter.autoCompleteDelegate = self;
    autoCompleter.suggestionsDictionary = [self produceNoCopysList];
    
    return autoCompleter;
}

-(NSArray*)produceNoCopysList
{
    NSMutableSet *tempSet = [[NSMutableSet alloc]init];
    
    for (int i = 0; i < [self.recipeList count]; i++)
        [tempSet addObject:[[self.recipeList objectAtIndex:i] valueForKey:@"Catergory"]];
    
    return [tempSet allObjects];
}

-(void)commit:(id)sender
{
    if (![self allValuesPresent])
    {
        [self displayAlert];
        return;
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"RecipeList.plist"];
    
    NSDictionary *recipeDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                                    self.nameField.text,
                                                                    self.catergoryField.text,
                                                                    [self getDifficulty],
                                                                    [[self.prepTimeField titleLabel]text],
                                                                    [[self.cookTimeField titleLabel]text],
                                                                    self.servesField.text,
                                                                    self.ingredientsField.text,
                                                                    self.methodField.text,
                                                                    @"false",
                                                                    nil]
                                
                                                           forKeys:[NSArray arrayWithObjects:
                                                                    @"Recipe name",
                                                                    @"Catergory",
                                                                    @"Difficulty",
                                                                    @"Time to prep",
                                                                    @"Time to cook",
                                                                    @"Serves",
                                                                    @"Ingredients",
                                                                    @"Method",
                                                                    @"Favorite",
                                                                    nil]];
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObjectsFromArray:self.recipeList];
    [array addObject:recipeDict];
    
    self.recipeList = array;
    
    NSString *error = nil;
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:array format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];

    if(plistData)
        [plistData writeToFile:plistPath atomically:YES];
    
    else
        NSLog(@"Error in saveData: %@", error);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (BOOL)allValuesPresent
{
    return
    
    ![self.nameField.text isEqualToString:@""] &&
    ![self.catergoryField.text isEqualToString:@""] &&
    ![[[self.prepTimeField titleLabel]text] isEqualToString:@"0 mins"] &&
    ![[[self.cookTimeField titleLabel]text] isEqualToString:@"0 mins"] &&
    ![self.servesField.text isEqualToString:@""] &&
    ![self.ingredientsField.text isEqualToString:@""] &&
    ![self.methodField.text isEqualToString:@""];

}

-(void)displayAlert
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Empty fields" message:@"You must fill in all fields before you can save this recipe" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(NSString*)getDifficulty
{
    NSString *difficulty = @"Easy";
    
    switch ([self.difficultyControl selectedSegmentIndex]) {
        case 1:
            difficulty = @"Medium";
            break;
        
        case 2:
            difficulty = @"Hard";
            break;
            
        default:
            break;
    }
    
    return difficulty;
}

-(IBAction)toTime:(id)sender
{
    TimeViewController *next = [[TimeViewController alloc]initWithNibName:@"TimeViewController" bundle:nil];
    
    if ([sender tag] == 1)
        next.buttonToMod = self.prepTimeField;
    else
        next.buttonToMod = self.cookTimeField;
    
    next.mode = [sender tag];
    [self.navigationController pushViewController:next animated:YES];
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
