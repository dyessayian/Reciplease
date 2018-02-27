//
//  RCPEditRecipeViewController.m
//  Reciplease
//
//  Created by Daniel Yessayian on 10/24/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import "RCPEditRecipeViewController.h"
#import "RCPRecipeCategorySelectCollectionViewCell.h"
#import "RCPEditRecipeIngredientTableViewCell.h"
#import "RCPEditRecipeInstructionTableViewCell.h"
#import "RCPEditRecipeImageCollectionViewCell.h"
#import "RCPEditRecipeTagTableViewCell.h"
#import "RCPTagTextField.h"
#import "RCPIngredientTextField.h"
#import "RCPInstructionTextView.h"
#import "RCPAddCategoryViewController.h"

@interface RCPEditRecipeViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate, RCPAddCategoryViewControllerDelegate>

//Other
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *xCloseButton;
@property (nonatomic) float keyboardHeight;
@property (nonatomic) CGPoint previousOffset;

//Default Image
@property (weak, nonatomic) IBOutlet UIImageView *defaultImageImageView;
@property (weak, nonatomic) IBOutlet UIView *defaultImageParentView;
@property (weak, nonatomic) IBOutlet UIView *noDefaultFoundParentView;
@property (weak, nonatomic) IBOutlet UIButton *defaultImageEditButton;
@property (weak, nonatomic) IBOutlet UIButton *defaultImageDeleteButton;

//Picker View
@property (nonatomic, strong) NSMutableArray *pickerViewArray;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (nonatomic, strong) UIToolbar *toolBar;

//Recipe Name
@property (weak, nonatomic) IBOutlet UITextField *recipeNameTextField;

//Recipe Categories
@property (weak, nonatomic) IBOutlet UICollectionView *selectCategoryCollectionView;
@property (nonatomic, strong) NSMutableArray *selectCategoriesArray;

//Recipe Ingredients
@property (weak, nonatomic) IBOutlet UITableView *ingredientsTableView;
@property (nonatomic, strong) NSMutableArray *ingredientsArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ingredientsParentViewHeightConstraint;
@property (nonatomic, strong) RCPRecipeIngredient *editingIngredient;
@property (nonatomic) NSInteger editingIngredientRow;
@property (weak, nonatomic) IBOutlet UIView *ingredientsParentView;

//Recipe Instructions
@property (weak, nonatomic) IBOutlet UITableView *instructionsTableView;
@property (nonatomic, strong) NSMutableArray *instructionsArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *instructionsParentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *instructionsParentView;

//Recipe Images
@property (weak, nonatomic) IBOutlet UICollectionView *recipeImagesCollectionView;
@property (nonatomic, strong) NSMutableArray *recipeImagesArray;
@property (weak, nonatomic) IBOutlet UIImageView *noImagesPlaceholderImageView;

//Recipe Notes
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *notesParentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;
@property (weak, nonatomic) IBOutlet UIView *notesParentView;
@property (weak, nonatomic) IBOutlet UIView *notesMainParentView;


//Recipe Tags
@property (nonatomic, strong) NSMutableArray *tagsArray;
@property (weak, nonatomic) IBOutlet UITableView *tagsTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagsParentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *tagsParentView;

//Add Category
@property (nonatomic, strong) RCPAddCategoryViewController *addCategoryVC;

//Context
@property (nonatomic) NSManagedObjectContext *contextToUse;

@end

@implementation RCPEditRecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.contextToUse = self.addingRecipe ? [RCPCoreDataManager sharedInstance].creatingRecipeContext : [NSManagedObjectContext MR_defaultContext];
    
    [self addObservers];
    [self setupTableViews];
    [self setupCollectionView];
    [self setupPickerView];
    [self setupToolbar];
    [self setupXButton];
    [self setupGestureRecognizers];
    [self loadRecipe];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //Trigger keyboard observer to get accurate keyboard height.
    if (self.keyboardHeight <= 0){
        [self.recipeNameTextField becomeFirstResponder];
        [self.recipeNameTextField resignFirstResponder];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    //NSLog(@" ");
    //NSLog(@"✳️✳️✳️✳️✳️✳️✳️✳️✳️✳️✳️");
    
    //Ingredients
    self.ingredientsParentViewHeightConstraint.constant = 66 + (self.ingredientsArray.count * 46) + 71;

    //Instructions
    float totalStepsParentViewHeight = 0.0;
    for (RCPRecipeInstruction *instruction in self.instructionsArray){
        NSInteger instructionIndex = [self.instructionsArray indexOfObject:instruction];
        //Determine how tall the textview needs to be for the instruction, then add to the total.
        RCPEditRecipeInstructionTableViewCell *cell = [self.instructionsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:instructionIndex inSection:0]];
        //12 and 12 for top and bottom buffer space, +19 and +10 for top and bottom space to the edges:
        float determinedHeight = ceilf([cell.instructionTextView sizeThatFits:CGSizeMake(cell.instructionTextView.frame.size.width, FLT_MAX)].height + 12 + 12 + 19 + 10);
        determinedHeight = MAX(71, determinedHeight);
        totalStepsParentViewHeight += determinedHeight;
    }
    self.instructionsParentViewHeightConstraint.constant = 58 + 71 + totalStepsParentViewHeight;

    //Tags
    self.tagsParentViewHeightConstraint.constant = 58 + 71 + (self.tagsArray.count * 44);

    //NSLog(@"✳️✳️✳️✳️✳️✳️✳️✳️✳️✳️✳️");
    //NSLog(@" ");
}

- (IBAction)testConstraints:(UIButton *)sender {
    [self viewDidLayoutSubviews];
}

#pragma mark - Observers
-(void)addObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

#pragma mark - Gesture Recognizers
-(void)setupGestureRecognizers {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [tapGestureRecognizer setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)handleTap:(UITapGestureRecognizer*)sender {
    [self.view endEditing:YES];
}

#pragma mark - Helper Methods
-(void)loadRecipe {
    //Recipe Name
    self.recipeNameTextField.text = self.recipe.recipeName.length > 0 ? self.recipe.recipeName : @"";
    [self reloadIngredients];
    [self reloadInstructions];
    [self reloadNotes];
    [self reloadRecipeImages];
    [self reloadTags];
}

-(void)reloadCategories {
    self.selectCategoriesArray = [NSMutableArray new];
    self.selectCategoriesArray = [[RCPRecipeCategory MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"categoryName != %@", @"All"]] mutableCopy];
    [self.selectCategoryCollectionView reloadData];
}

-(void)reloadIngredients {
    self.ingredientsArray = self.recipe.recipeIngredients.allObjects.mutableCopy;
    self.ingredientsArray = [[self.recipe.recipeIngredients.allObjects sortedArrayUsingComparator:^NSComparisonResult(RCPRecipeIngredient *obj1, RCPRecipeIngredient *obj2) {
        return [obj1.ingredientNumber compare:obj2.ingredientNumber];
    }] mutableCopy];
    [self.ingredientsTableView reloadData];
    [self viewDidLayoutSubviews];
}

-(void)reloadInstructions {
    self.instructionsArray = self.recipe.instructions.allObjects.mutableCopy;
    self.instructionsArray = [[self.recipe.instructions.allObjects sortedArrayUsingComparator:^NSComparisonResult(RCPRecipeInstruction *obj1, RCPRecipeInstruction *obj2) {
        return [obj1.instructionNumber compare:obj2.instructionNumber];
    }] mutableCopy];
    [self.instructionsTableView reloadData];
    [self viewDidLayoutSubviews];
}

-(void)reloadNotes {
    //Additional Notes
    self.notesTextView.textContainerInset = UIEdgeInsetsZero;
    self.notesTextView.textContainer.lineFragmentPadding = 0;
    self.notesTextView.text = self.recipe.recipeNotes.length > 0 ? self.recipe.recipeNotes : @"";
    self.notesParentView.layer.borderColor = [UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1.0].CGColor;
    self.notesParentView.layer.borderWidth = 1.0;
    
    self.notesTextView.text = self.recipe.recipeNotes.length > 0 ? self.recipe.recipeNotes : @"";
    float notesTextViewHeight = 0.0;
    notesTextViewHeight += ceilf([self.notesTextView sizeThatFits:CGSizeMake(self.notesTextView.frame.size.width, FLT_MAX)].height + 12 + 12);
    self.notesParentViewHeightConstraint.constant = 58 + 15 + notesTextViewHeight;
    self.notesTextView.editable = YES;
}


-(void)reloadRecipeImages {
    self.recipeImagesArray = [[self.recipe.images.allObjects sortedArrayUsingComparator:^NSComparisonResult(RCPRecipeImage *obj1, RCPRecipeImage *obj2) {
        return [obj1.recipeImageName compare:obj2.recipeImageName];
    }] mutableCopy];
    
    [self.recipeImagesCollectionView reloadData];
    
    if (self.recipeImagesArray.count == 0){
        self.noImagesPlaceholderImageView.hidden = NO;
        self.recipeImagesCollectionView.hidden = YES;
    }
    else {
        self.noImagesPlaceholderImageView.hidden = YES;
        self.recipeImagesCollectionView.hidden = NO;
    }
    
    [self reloadDefaultRecipeImage];
}

-(void)reloadDefaultRecipeImage {
    //Load recipe image.
    RCPRecipeImage *featuredRecipeImageObject = [[self.recipe.images.allObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"isFeatured == TRUE"]] firstObject];
    if (featuredRecipeImageObject){
        self.noDefaultFoundParentView.hidden = YES;
        self.defaultImageParentView.hidden = NO;

        //Found the featured image - use this one.
        UIImage *recipeImage = [UIImage imageNamed:featuredRecipeImageObject.recipeImageName];
        if (recipeImage){
            self.defaultImageImageView.image = recipeImage;
        }
        else {
            NSString *imagePathString = [[RCPAppManager sharedInstance] retrievePathForFilenameWithString:featuredRecipeImageObject.recipeImageName];
            self.defaultImageImageView.image = (imagePathString.length > 0) ? [UIImage imageWithContentsOfFile:imagePathString] : nil;
        }
    }
    else {
        //No featured image found - default to the first one found.
        RCPRecipeImage *defaultedRecipeImageObject = [self.recipe.images.allObjects firstObject];
        if (defaultedRecipeImageObject){
            self.noDefaultFoundParentView.hidden = YES;
            self.defaultImageParentView.hidden = NO;
            //Found the featured image - use this one.
            UIImage *recipeImage = [UIImage imageNamed:defaultedRecipeImageObject.recipeImageName];
            if (recipeImage){
                self.defaultImageImageView.image = recipeImage;
                defaultedRecipeImageObject.isFeatured = TRUE;
            }
            else {
                NSString *imagePathString = [[RCPAppManager sharedInstance] retrievePathForFilenameWithString:defaultedRecipeImageObject.recipeImageName];
                self.defaultImageImageView.image = (imagePathString.length > 0) ? [UIImage imageWithContentsOfFile:imagePathString] : nil;
                defaultedRecipeImageObject.isFeatured = TRUE;
            }
        }
        else {
            self.noDefaultFoundParentView.hidden = NO;
            self.defaultImageParentView.hidden = YES;
            self.noDefaultFoundParentView.layer.borderColor = [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1.0].CGColor;
            self.noDefaultFoundParentView.layer.borderWidth = 1.0;
        }
    }
}

-(void)reloadTags {
    self.tagsArray = self.recipe.tags.allObjects.mutableCopy;
    self.tagsArray = [[self.recipe.tags.allObjects sortedArrayUsingComparator:^NSComparisonResult(RCPRecipeTag *obj1, RCPRecipeTag *obj2) {
        return [obj1.tagNumber compare:obj2.tagNumber];
    }] mutableCopy];
    [self.tagsTableView reloadData];
    [self viewDidLayoutSubviews];
}

-(void)setupTableViews {
    //Register Nibs
    [self.ingredientsTableView registerNib:[UINib nibWithNibName:@"RCPEditRecipeIngredientTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([RCPEditRecipeIngredientTableViewCell class])];
    [self.instructionsTableView registerNib:[UINib nibWithNibName:@"RCPEditRecipeInstructionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([RCPEditRecipeInstructionTableViewCell class])];
    [self.tagsTableView registerNib:[UINib nibWithNibName:@"RCPEditRecipeTagTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([RCPEditRecipeTagTableViewCell class])];
    
    //Estimated Row Height setup for instructions table.
    self.instructionsTableView.rowHeight = UITableViewAutomaticDimension;
    self.instructionsTableView.estimatedRowHeight = 50;
}

-(void)setupXButton {
    self.xCloseButton.transform = CGAffineTransformRotate(self.xCloseButton.transform, M_PI_4);
}

-(void)doneTapped:(UIBarButtonItem*)sender {
    //NSLog(@"Tapped done.");
    [self.view endEditing:YES];
}

-(void)setupToolbar {
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [_toolBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneTapped:)];
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    _toolBar.items = @[flexibleItem, barButtonDone];
    barButtonDone.tintColor = [UIColor blueColor];
}

-(void)setupPickerView {
    //NSLog(@"Setting up picker view.");
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerViewArray = [[[RCPAppManager sharedInstance] measurementTypesArray] mutableCopy];
}

-(void)setupCollectionView {
    [self.selectCategoryCollectionView registerNib:[UINib nibWithNibName:@"RCPRecipeCategorySelectCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([RCPRecipeCategorySelectCollectionViewCell class])];
    [self.recipeImagesCollectionView registerNib:[UINib nibWithNibName:@"RCPEditRecipeImageCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([RCPEditRecipeImageCollectionViewCell class])];
    
    [self reloadCategories];
    //NSLog(@"Categories Array: %@", self.selectCategoriesArray);
}

#pragma mark - Button Actions
- (IBAction)saveButtonTapped:(UIButton *)sender {
    //NSLog(@"Save recipe button tapped.");
    
    //NSLog(@"💚💚💚💚💚💚💚💚💚💚💚💚💚💚💚💚💚💚💚");
    //NSLog(@"The current recipe:");
    //NSLog(@"%@", self.recipe);
    //NSLog(@"💚💚💚💚💚💚💚💚💚💚💚💚💚💚💚💚💚💚💚");
    
    [self.view endEditing:YES];
    if (self.recipe.recipeName.length > 0){
        
        
        [[RCPCoreDataManager sharedInstance].creatingRecipeContext MR_saveToPersistentStoreAndWait];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        if (self.addingRecipe){
            if ([self.delegate respondsToSelector:@selector(recipeWasAdded:)]){
                [self.delegate recipeWasAdded:self.recipe];
            }
            else {
                //NSLog(@"Delegate does not respond to selector: recipeWasAdded:");
            }
        }
        else if (self.editingRecipe){
            if ([self.delegate respondsToSelector:@selector(recipeWasUpdated:)]){
                [self.delegate recipeWasUpdated:self.recipe];
            }
            else {
                //NSLog(@"Delegate does not respond to selector: recipeWasUpdated:");
            }
        }
        
        [self dismissViewControllerAnimated:YES completion:^{
            //NSLog(@"Dismissed add recipe view controller.");
        }];
        
    }
    else {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Missing Recipe Name" message:[NSString stringWithFormat:@"Please fill out a name for this recipe."] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {  }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)closeButtonTapped:(UIButton *)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Discard Changes?" message:[NSString stringWithFormat:@"Are you sure you want to discard any changes?"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              //NSLog(@"Tapped No.");
                                                          }];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Yes, Discard" style:UIAlertActionStyleDestructive
                                                      handler:^(UIAlertAction *action) {
                                                          
                                                          //NSLog(@"Tapped Discard.");
                                                          
                                                          [RCPCoreDataManager sharedInstance].creatingRecipeContext = nil;
                                                          
                                                          //Reset.
                                                          [[NSManagedObjectContext MR_defaultContext] rollback];
                                                          
                                                          [self dismissViewControllerAnimated:YES completion:^{
                                                              //NSLog(@"Dismissed edit recipe view controller.");
                                                              if ([self.delegate respondsToSelector:@selector(recipeWasUpdated:)]){
                                                                  [self.delegate recipeWasUpdated:self.recipe];
                                                              }
                                                              else {
                                                                  //NSLog(@"Delegate does not respond to selector: recipeWasUpdated:");
                                                              }
                                                          }];
                                                      }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)editCategoriesButtonTapped:(UIButton *)sender {
    
    if (!self.addCategoryVC){
        self.addCategoryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RCPAddCategoryViewController"];
        self.addCategoryVC.delegate = self;
    }
    
    //NSLog(@"Add category VC: %@", NSStringFromCGRect(self.addCategoryVC.view.frame));
    
    self.definesPresentationContext = YES;
    
    [self presentViewController:self.addCategoryVC animated:YES completion:^{
        //NSLog(@"Presented!");
        //NSLog(@"Add category VC: %@", NSStringFromCGRect(self.addCategoryVC.view.frame));
        //self.addCategoryVC.view.frame = CGRectMake(0, 0, 944, 327);
    }];

    
    
    
}


- (IBAction)addIngredientButtonTapped:(UIButton *)sender {

    [self.view endEditing:YES];
    
    //Create a new recipe ingredient object & ingredient object.
    RCPRecipeIngredient *newRecipeIngredient = [RCPRecipeIngredient MR_createEntityInContext:self.contextToUse];
    RCPIngredient *newIngredient = [RCPIngredient MR_createEntityInContext:self.contextToUse];
    newRecipeIngredient.ingredient = newIngredient;
    newRecipeIngredient.ingredientNumber = @([[[self.ingredientsArray valueForKey:@"ingredientNumber"] valueForKeyPath:@"@max.intValue"] integerValue] + 1);
    
    [self.recipe addRecipeIngredientsObject:newRecipeIngredient];
    [self reloadIngredients];
}

- (IBAction)addInstructionButtonTapped:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    //Create a new recipe instruction.
    RCPRecipeInstruction *newInstruction = [RCPRecipeInstruction MR_createEntityInContext:self.contextToUse];
    newInstruction.instructionNumber = @([[[self.instructionsArray valueForKey:@"instructionNumber"] valueForKeyPath:@"@max.intValue"] integerValue] + 1);

    [self.recipe addInstructionsObject:newInstruction];
    [self reloadInstructions];
}

- (IBAction)addTagButtonTapped:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add Tag" message:@"Enter a new tag for this recipe: " preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"tag";
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *tagEntered = [[alertController textFields][0] text];
        //NSLog(@"Tag entered: %@", tagEntered);
        
        if (tagEntered.length > 0){
            //Also check if the tag doesn't already exist for this recipe.
            RCPRecipeTag *existingTag = [[self.recipe.tags.allObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"tagString == %@", tagEntered]] firstObject];
            if (existingTag){
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Tag Already Exists" message:[NSString stringWithFormat:@"This recipe already has a tag for '%@'!", tagEntered] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {  }];
                [alertController addAction:cancelAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else {
                //Create a new recipe tag.
                RCPRecipeTag *newTag = [RCPRecipeTag MR_createEntityInContext:self.contextToUse];
                newTag.tagNumber = @([[[self.tagsArray valueForKey:@"tagNumber"] valueForKeyPath:@"@max.intValue"] integerValue] + 1);
                newTag.tagString = tagEntered;
                [self.recipe addTagsObject:newTag];
                [self reloadTags];
            }
        }
        else {
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
    [alertController addAction:confirmAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //NSLog(@"Canelled");
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)editButtonTapped:(UIButton *)sender {
    //NSLog(@"Edit default image button tapped.");
}

- (IBAction)deleteButtonTapped:(UIButton *)sender {
    //NSLog(@"Delete button tapped.");
}

- (IBAction)deleteRecipeButtonTapped:(UIButton *)sender {
    //Prompt for recipe deletion.
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Delete Recipe?" message:[NSString stringWithFormat:@"Are you sure you would like to delete this recipe?"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              //NSLog(@"Tapped Cancel.");
                                                          }];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Yes, Delete" style:UIAlertActionStyleDestructive
                                                      handler:^(UIAlertAction *action) {
                                                          //NSLog(@"Tapped Delete.");
                                                          [self.recipe MR_deleteEntity];
                                                          [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                                                          
                                                          [self dismissViewControllerAnimated:YES completion:^{
                                                              //NSLog(@"Dismissed edit recipe view controller.");
                                                              if ([self.delegate respondsToSelector:@selector(recipeWasDeleted)]){
                                                                  [self.delegate recipeWasDeleted];
                                                              }
                                                              else {
                                                                  //NSLog(@"Delegate does not respond to selector: recipeWasDeleted");
                                                              }
                                                          }];
                                                      }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)deleteRecipeImageButtonTapped:(UIButton*)sender {
    
    //NSLog(@"Delete recipe image button tapped.");
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Delete Image?" message:[NSString stringWithFormat:@"Are you sure you would like to delete this image?"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              //NSLog(@"Tapped Cancel.");
                                                          }];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Yes, Delete" style:UIAlertActionStyleDestructive
                                                      handler:^(UIAlertAction *action) {
                                                          //NSLog(@"Tapped Delete.");
                                                          RCPRecipeImage *imageToDelete = [self.recipeImagesArray objectAtIndex:sender.tag];
                                                          [self.recipe removeImagesObject:imageToDelete];
                                                          [imageToDelete MR_deleteEntity];
                                                          [self reloadRecipeImages];
                                                      }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
}


- (IBAction)cancelButtonTapped:(UIButton *)sender {
    //NSLog(@"Cancel Recipe!");
    if (self.addingRecipe){
        //If adding a new recipe, then cancel will delete it.  If just viewing, then only need to dismiss VC.
        [self.recipe MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    
    if ([self.delegate respondsToSelector:@selector(recipeViewCanceled)]){
        [self.delegate recipeViewCanceled];
    }
    else {
        //NSLog(@"Delegate does not respond to selector: recipeViewCanceled");
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        //NSLog(@"Dismissed add recipe view controller.");
    }];
}

#pragma mark - UICollectionView Delegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.selectCategoryCollectionView]){
        float widthToUse = 0.0;
        RCPRecipeCategory *category = [self.selectCategoriesArray objectAtIndex:indexPath.row];
        CGSize size = [category.categoryName boundingRectWithSize:CGSizeMake(MAXFLOAT, collectionView.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:15.0]} context:nil].size;
        //NSLog(@"Size: %@", NSStringFromCGSize(size));
        widthToUse = ceilf(size.width);
        return CGSizeMake(52 + widthToUse, self.selectCategoryCollectionView.frame.size.height);
    }
    else if ([collectionView isEqual:self.recipeImagesCollectionView]){
        return CGSizeMake(61, 61);
    }
    else {
        return CGSizeMake(61, 61);
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([collectionView isEqual:self.selectCategoryCollectionView]){
        return self.selectCategoriesArray.count;
    }
    else if ([collectionView isEqual:self.recipeImagesCollectionView]){
        return self.recipeImagesArray.count;
    }
    else {
        return 0;
    }
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint pressPoint = [gestureRecognizer locationInView:self.selectCategoryCollectionView];
    NSIndexPath *indexPath = [self.selectCategoryCollectionView indexPathForItemAtPoint:pressPoint];
    if (indexPath == nil){
        //NSLog(@"long press on table view but not on a row");
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"long press on table view at row %ld", indexPath.row);
        
        
        //NSLog(@"Ask to delete category: %@", [self.selectCategoriesArray objectAtIndex:indexPath.row]);
        
        RCPRecipeCategory *deleteCategory = [self.selectCategoriesArray objectAtIndex:indexPath.row];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Delete Category?" message:[NSString stringWithFormat:@"Would you like to delete the category '%@'?", deleteCategory.categoryName] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction *action) {
                                                                      //NSLog(@"Tapped Cancel.");
                                                                  }];
            UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  //NSLog(@"Tapped OK.");
                                                                  
                                                                  //Post a notification for the HomeVC:
                                                                  [[NSNotificationCenter defaultCenter] postNotificationName:@"CategoryDeleted" object:nil userInfo:@{@"categoryName":deleteCategory.categoryName}];
                                                                  
                                                                  [deleteCategory MR_deleteEntity];
                                                                  
                                                                  //Then reload the categories:
                                                                  [self reloadCategories];
                                                              }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        });
    }
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([collectionView isEqual:self.selectCategoryCollectionView]){
        RCPRecipeCategorySelectCollectionViewCell *cell = (RCPRecipeCategorySelectCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([RCPRecipeCategorySelectCollectionViewCell class]) forIndexPath:indexPath];
        
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        lpgr.minimumPressDuration = 1.0; //seconds
        [cell addGestureRecognizer:lpgr];
        
        
        RCPRecipeCategory *category = [self.selectCategoriesArray objectAtIndex:indexPath.row];
        cell.categoryNameLabel.text = category.categoryName.length > 0 ? category.categoryName : @"?";
        cell.categoryImageView.image = [UIImage imageNamed:category.imageName];
        cell.categoryParentView.layer.borderWidth = 1.0;
        
        if ([self.recipe.categories.allObjects containsObject:category]){
            cell.categoryImageView.tintColor = [UIColor whiteColor];
            cell.categoryNameLabel.textColor = [UIColor whiteColor];
            cell.categoryParentView.layer.borderColor = [UIColor colorNamed:@"activeCategoryImageColor"].CGColor;
            cell.categoryParentView.backgroundColor = [UIColor colorNamed:@"activeCategoryImageColor"];
        }
        else {
            cell.categoryImageView.tintColor = [UIColor colorWithRed:87.0/255.0 green:87.0/255.0 blue:87.0/255.0 alpha:1.0];
            cell.categoryNameLabel.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1.0];
            cell.categoryParentView.layer.borderColor = [UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1.0].CGColor;
            cell.categoryParentView.backgroundColor = [UIColor clearColor];
        }
        return cell;
    }
    else { // if ([collectionView isEqual:self.recipeImagesCollectionView]){
    
        RCPEditRecipeImageCollectionViewCell *cell = (RCPEditRecipeImageCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([RCPEditRecipeImageCollectionViewCell class]) forIndexPath:indexPath];
        
        RCPRecipeImage *recipeImage = [self.recipeImagesArray objectAtIndex:indexPath.row];
        
        
        
        //NSLog(@"Loading image: %@", recipeImage.recipeImageName);
        UIImage *image = [UIImage imageNamed:recipeImage.recipeImageName];
        if (image){
            cell.editRecipeImageView.image = image;
        }
        else {
            NSString *imagePathString = [[RCPAppManager sharedInstance] retrievePathForFilenameWithString:recipeImage.recipeImageName];
            //NSLog(@"Image path loading: %@", imagePathString);
            
            if (imagePathString.length > 0){
                cell.editRecipeImageView.image = [UIImage imageWithContentsOfFile:imagePathString];
            }
            else {
                cell.editRecipeImageView.backgroundColor = [UIColor blackColor];
            }
        }
        
        
        cell.deleteImageButton.transform = CGAffineTransformIdentity;
        cell.deleteImageButton.transform = CGAffineTransformRotate(cell.deleteImageButton.transform, M_PI_4);
        [cell.deleteImageButton.imageView setTintColor:[UIColor redColor]];
        
        cell.deleteImageButton.tag = indexPath.row;
        [cell.deleteImageButton addTarget:self action:@selector(deleteRecipeImageButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        //Remove previous sublayers.
        for (CALayer* layer in cell.editRecipeImageView.layer.sublayers){
            [layer removeFromSuperlayer];
        }
        
        //Add Alpha Gradient over messagePreviewLabel
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
        //NSLog(@"Adding gradient at frame: %@", NSStringFromCGRect(gradient.frame));
        gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0.72].CGColor, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1], (id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0] CGColor], nil];
        gradient.startPoint = CGPointMake(1.0f, 0.0f);
        gradient.endPoint = CGPointMake(1.0f, 1.0f);
        [cell.editRecipeImageView.layer insertSublayer:gradient atIndex:0];
        
        return cell;
    }
    
    
    
    
    
    
    
    
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"collectionView:didSelectItemAtIndexPath: %@ (Row: %ld)", indexPath, (long)indexPath.row);

    if ([collectionView isEqual:self.selectCategoryCollectionView]){
        //Toggle the category as selected.
        RCPRecipeCategory *recipeCategory = [self.selectCategoriesArray objectAtIndex:indexPath.row];
        if ([self.recipe.categories.allObjects containsObject:recipeCategory]){
            //NSLog(@"This category already is selected, need to deselect it.");
            [self.recipe removeCategoriesObject:recipeCategory];
            [self.selectCategoryCollectionView reloadData];
        }
        else {
            //NSLog(@"This category is not yet selected, need to select it now.");
            [self.recipe addCategoriesObject:recipeCategory];
            [self.selectCategoryCollectionView reloadData];
        }
    }
    else if ([collectionView isEqual:self.recipeImagesCollectionView]){
        
        //NSLog(@"Beep.");
        
        //Prompt user to set image as default.
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Set as Cover?" message:[NSString stringWithFormat:@"Would you like to set this image as the cover image for this recipe?"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction *action) {
                                                                      //NSLog(@"Tapped Cancel.");
                                                                  }];
            UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  //NSLog(@"Tapped Yes.");
                                                                  
                                                                  RCPRecipeImage *featuredRecipeImageObject = [[self.recipe.images.allObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"isFeatured == TRUE"]] firstObject];
                                                                  featuredRecipeImageObject.isFeatured = NO;
                                                                  
                                                                  RCPRecipeImage *selectedImage = [self.recipeImagesArray objectAtIndex:indexPath.row];
                                                                  selectedImage.isFeatured = YES;
                                                                  
                                                                  
                                                                  [self reloadDefaultRecipeImage];
                                                                  
                                                                  
                                                              }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
            //Try to fix weird animation bug with the images:
            [self.recipeImagesCollectionView reloadData];
        });
    }
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.ingredientsTableView]){
        return self.ingredientsArray.count;
    }
    else if ([tableView isEqual:self.instructionsTableView]){
        return self.instructionsArray.count;
    }
    else if ([tableView isEqual:self.tagsTableView]){
        return self.tagsArray.count;
    }
    else {
        return 0;
    }
}

//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([tableView isEqual:self.ingredientsTableView]){
//        return 46.0;
//    }
////    else if ([tableView isEqual:self.instructionsTableView]){
////
////        //This needs to be done using automatic dimension?
////
////
//////        float instructionHeight = 0.0;
////        //RCPEditRecipeInstructionTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
////
////        //instructionHeight += ceilf([cell.instructionTextView sizeThatFits:CGSizeMake(cell.instructionTextView.frame.size.width, FLT_MAX)].height + 12 + 12); //12 and 12 for top and bottom buffer space.
//////        //NSLog(@"Returning: %f", instructionHeight);
//////        return instructionHeight;
////        return 46.0;
////    }
//    else {
//        return 0;
//    }
//}

-(void)deleteIngredientButtonTapped:(UIButton*)sender {
    [self.view endEditing:YES];
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Remove Ingredient" message:[NSString stringWithFormat:@"Would you like to remove this ingredient from the recipe?"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              //NSLog(@"Tapped Cancel.");
                                                          }];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDestructive
                                                      handler:^(UIAlertAction *action) {
                                                          //NSLog(@"Tapped OK.");
                                                          RCPRecipeIngredient *deletingIngredient = [self.ingredientsArray objectAtIndex:sender.tag];
                                                          [self.recipe removeRecipeIngredientsObject:deletingIngredient];
                                                          [deletingIngredient.ingredient MR_deleteEntity];
                                                          [deletingIngredient MR_deleteEntity];
                                                          [self reloadIngredients];
                                                      }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)deleteInstructionButtonTapped:(UIButton*)sender {
    [self.view endEditing:YES];
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Remove Instruction" message:[NSString stringWithFormat:@"Would you like to remove this step from the recipe?"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              //NSLog(@"Tapped Cancel.");
                                                          }];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDestructive
                                                      handler:^(UIAlertAction *action) {
                                                          //NSLog(@"Tapped OK.");
                                                          RCPRecipeInstruction *deletingInstruction = [self.instructionsArray objectAtIndex:sender.tag];
                                                          [self.recipe removeInstructionsObject:deletingInstruction];
                                                          [deletingInstruction MR_deleteEntity];
                                                          [self reloadInstructions];
                                                      }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
}

-(void)deleteTagButtonTapped:(UIButton*)sender {
    [self.view endEditing:YES];
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Remove Tag" message:[NSString stringWithFormat:@"Would you like to remove this tag from the recipe?"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              //NSLog(@"Tapped Cancel.");
                                                          }];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDestructive
                                                      handler:^(UIAlertAction *action) {
                                                          //NSLog(@"Tapped OK.");
                                                          RCPRecipeTag *deletingTag = [self.tagsArray objectAtIndex:sender.tag];
                                                          [self.recipe removeTagsObject:deletingTag];
                                                          [deletingTag MR_deleteEntity];
                                                          [self reloadTags];
                                                      }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:self.ingredientsTableView]){
        
        RCPEditRecipeIngredientTableViewCell *cell = (RCPEditRecipeIngredientTableViewCell*)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RCPEditRecipeIngredientTableViewCell class])];
        RCPRecipeIngredient *recipeIngredient = [self.ingredientsArray objectAtIndex:indexPath.row];
        
        cell.amountParentView.layer.cornerRadius = 10.0;
        cell.amountParentView.layer.borderWidth = 1.0;
        cell.amountParentView.layer.borderColor = [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1.0].CGColor;
        cell.amountTextField.delegate = self;
        
        cell.unitParentView.layer.cornerRadius = 10.0;
        cell.unitParentView.layer.borderWidth = 1.0;
        cell.unitParentView.layer.borderColor = [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1.0].CGColor;
        cell.unitTextField.delegate = self;
        cell.unitTextField.inputView = self.pickerView;
        cell.unitTextField.inputAccessoryView = self.toolBar;
        
        cell.ingredientParentView.layer.cornerRadius = 10.0;
        cell.ingredientParentView.layer.borderWidth = 1.0;
        cell.ingredientParentView.layer.borderColor = [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1.0].CGColor;
        cell.ingredientTextField.delegate = self;
        
        
        cell.amountTextField.tag = indexPath.row;
        cell.unitTextField.tag = indexPath.row;
        cell.ingredientTextField.tag = indexPath.row;
        
        cell.amountTextField.text = recipeIngredient.ingredientQuantity;
        cell.unitTextField.text = recipeIngredient.ingredientMeasurement;
        cell.ingredientTextField.text = recipeIngredient.ingredient.ingredientName;
        
        cell.xDeleteImageView.transform = CGAffineTransformIdentity;
        cell.xDeleteImageView.transform = CGAffineTransformRotate(cell.xDeleteImageView.transform, M_PI_4);
        
        cell.deleteOverlayButton.tag = indexPath.row;
        [cell.deleteOverlayButton addTarget:self action:@selector(deleteIngredientButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }
    else if ([tableView isEqual:self.instructionsTableView]){
        
        RCPEditRecipeInstructionTableViewCell *cell = (RCPEditRecipeInstructionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RCPEditRecipeInstructionTableViewCell class])];
        RCPRecipeInstruction *instruction = [self.instructionsArray objectAtIndex:indexPath.row];
        
        cell.stepNumberLabel.text = [NSString stringWithFormat:@"Step %@", instruction.instructionNumber];
        
        cell.instructionParentView.layer.cornerRadius = 10.0;
        cell.instructionParentView.layer.borderWidth = 1.0;
        cell.instructionParentView.layer.borderColor = [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1.0].CGColor;
        
        //cell.instructionTextView.text = instruction.instructionText.length > 0 ? instruction.instructionText : @"";
        if (instruction.instructionText.length > 0){
            cell.instructionTextView.text = instruction.instructionText;
        }
        else {
            cell.instructionTextView.text = @"Enter recipe instructions";
        }
        
        cell.instructionTextView.delegate = self;
        cell.instructionTextView.textContainerInset = UIEdgeInsetsZero;
        cell.instructionTextView.textContainer.lineFragmentPadding = 0;
        cell.instructionTextView.tag = indexPath.row;
        
        cell.xDeleteImageView.transform = CGAffineTransformIdentity;
        cell.xDeleteImageView.transform = CGAffineTransformRotate(cell.xDeleteImageView.transform, M_PI_4);
        
        cell.deleteOverlayButton.tag = indexPath.row;
        [cell.deleteOverlayButton addTarget:self action:@selector(deleteInstructionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    else if ([tableView isEqual:self.tagsTableView]){
        
        RCPEditRecipeTagTableViewCell *cell = (RCPEditRecipeTagTableViewCell*)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RCPEditRecipeTagTableViewCell class])];
        RCPRecipeTag *recipeTag = [self.tagsArray objectAtIndex:indexPath.row];
        
        cell.tagParentView.layer.cornerRadius = 10.0;
        cell.tagParentView.layer.borderWidth = 1.0;
        cell.tagParentView.layer.borderColor = [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1.0].CGColor;
        cell.tagTextField.text = recipeTag.tagString;
        cell.tagTextField.delegate = self;
        cell.tagTextField.tag = indexPath.row;
        
        cell.xDeleteImageView.transform = CGAffineTransformIdentity;
        cell.xDeleteImageView.transform = CGAffineTransformRotate(cell.xDeleteImageView.transform, M_PI_4);
        
        cell.deleteOverlayButton.tag = indexPath.row;
        [cell.deleteOverlayButton addTarget:self action:@selector(deleteTagButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }
    else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"tableView:didSelectRowAtIndexPath: %@ (Row: %ld)", indexPath, (long)indexPath.row);
}

#pragma mark - UIPickerView
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerViewArray.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    //NSLog(@"Selected row: %ld", (long)row);
    self.editingIngredient = [self.ingredientsArray objectAtIndex:self.editingIngredientRow];
    if (self.editingIngredient){
        self.editingIngredient.ingredientMeasurement = [self.pickerViewArray objectAtIndex:row];
        
        RCPEditRecipeIngredientTableViewCell *editingCell = [self.ingredientsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.editingIngredientRow inSection:0]];
        editingCell.unitTextField.text = self.editingIngredient.ingredientMeasurement;
        //[self.ingredientsTableView reloadData];
        //NSLog(@"Set to: %@", [self.pickerViewArray objectAtIndex:row]);
    }
    else {
        //NSLog(@"Could not find editing ingredient!");
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.pickerViewArray objectAtIndex:row];
}





#pragma mark - UITextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    //NSLog(@"Text field did begin editing.");
    
    if (![textField isEqual:self.recipeNameTextField]){
        
        float originY = 0.0;
        if ([textField isKindOfClass:[RCPIngredientTextField class]]){
         
            CGRect rectOfCellInTableView = [self.ingredientsTableView rectForRowAtIndexPath: [NSIndexPath indexPathForRow:textField.tag inSection:0]];
            CGRect rectOfCellInSuperview = [self.ingredientsTableView convertRect: rectOfCellInTableView toView: self.ingredientsTableView.superview];
            //NSLog(@"Y of Cell is: %f", rectOfCellInSuperview.origin.y);
            originY = self.ingredientsParentView.frame.origin.y + rectOfCellInTableView.origin.y;
        }
        else {
            CGRect rectOfCellInTableView = [self.tagsTableView rectForRowAtIndexPath: [NSIndexPath indexPathForRow:textField.tag inSection:0]];
            CGRect rectOfCellInSuperview = [self.tagsTableView convertRect: rectOfCellInTableView toView: self.tagsTableView.superview];
            //NSLog(@"Y of Cell is: %f", rectOfCellInSuperview.origin.y);
            originY = self.tagsParentView.frame.origin.y + rectOfCellInTableView.origin.y;
        }
        
        
        //NSLog(@"Scroll to: %f", originY);
        CGPoint scrollPoint = CGPointMake(0, originY);
        self.previousOffset = [self.scrollView contentOffset];
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.scrollView setContentOffset:scrollPoint animated:NO];
        }];
        
        // Add a "buffer" at the bottom of the table
        [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, self.keyboardHeight, 0)];
    }
    
    self.editingIngredientRow = textField.tag;
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    //NSLog(@"Text field did end editing.");
    
    //Scroll
    [self.scrollView setContentOffset:CGPointMake(0, self.previousOffset.y)];
    //[self.scrollView setContentOffset:CGPointMake(0, self.previousOffset.y)];
    //[self.scrollView setContentOffset:CGPointMake(0, -self.scrollView.contentInset.top)];
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    
    
    if ([textField isEqual:self.recipeNameTextField]){
        self.recipe.recipeName = self.recipeNameTextField.text.length > 0 ? self.recipeNameTextField.text : @"";
    }
    else if ([textField isKindOfClass:[RCPTagTextField class]]){
        RCPRecipeTag *editingTag = [self.tagsArray objectAtIndex:textField.tag];
        editingTag.tagString = textField.text;
    }
    else if ([textField isKindOfClass:[RCPIngredientTextField class]]){
        RCPEditRecipeIngredientTableViewCell *recipeIngredientCell = (RCPEditRecipeIngredientTableViewCell*)[self.ingredientsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0]];
        if ([textField isEqual:recipeIngredientCell.amountTextField]){
            RCPRecipeIngredient *editingIngredient = [self.ingredientsArray objectAtIndex:textField.tag];
            editingIngredient.ingredientQuantity = textField.text;
        }
        else if ([textField isEqual:recipeIngredientCell.unitTextField]){
            self.editingIngredient = nil;
        }
        else if ([textField isEqual:recipeIngredientCell.ingredientTextField]){
            RCPRecipeIngredient *editingIngredient = [self.ingredientsArray objectAtIndex:textField.tag];
            editingIngredient.ingredient.ingredientName = textField.text;
        }
        
        
    }

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITextView Delegate
-(void)textViewDidChange:(UITextView *)textView {
    
    if ([textView isEqual:self.notesTextView]){
        self.recipe.recipeNotes = textView.text;
        [self reloadNotes];
    }
    else {
        if (self.instructionsArray.count > 0){
            RCPEditRecipeInstructionTableViewCell *instructionCell = (RCPEditRecipeInstructionTableViewCell*)[self.instructionsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textView.tag inSection:0]];
            if ([textView isEqual:instructionCell.instructionTextView]){
                [self.instructionsTableView beginUpdates];
                [self.instructionsTableView endUpdates];
                [self viewDidLayoutSubviews];
            }
        }
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    //NSLog(@"Text view did begin editing.");
    
    float originY = 0.0;
    if ([textView isKindOfClass:[RCPInstructionTextView class]]){
        CGRect rectOfCellInTableView = [self.instructionsTableView rectForRowAtIndexPath: [NSIndexPath indexPathForRow:textView.tag inSection:0]];
        CGRect rectOfCellInSuperview = [self.instructionsTableView convertRect: rectOfCellInTableView toView: self.instructionsTableView.superview];
        //NSLog(@"Y of Cell is: %f", rectOfCellInSuperview.origin.y);
        originY = self.instructionsParentView.frame.origin.y + rectOfCellInTableView.origin.y;
    }
    else {
        originY = self.notesMainParentView.frame.origin.y;
    }
    
    //NSLog(@"Scroll to: %f", originY);
    CGPoint scrollPoint = CGPointMake(0, originY);
    self.previousOffset = [self.scrollView contentOffset];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.scrollView setContentOffset:scrollPoint animated:NO];
    }];
    
    // Add a "buffer" at the bottom of the table
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, self.keyboardHeight, 0)];
    
    
    
//    if (![textView isEqual:self.recipeNameTextField]){
//        float originY = textView.superview.superview.frame.origin.y;
//        //NSLog(@"Scroll to: %f", originY);
//        CGPoint scrollPoint = CGPointMake(0, originY);
//        self.previousOffset = [self.scrollView contentOffset];
//
//        [UIView animateWithDuration:0.3 animations:^{
//            [self.scrollView setContentOffset:scrollPoint animated:NO];
//        }];
//
//        // Add a "buffer" at the bottom of the table
//        [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, self.keyboardHeight, 0)];
//    }
    
    if ([textView.text isEqualToString:@"Enter recipe instructions"]){
        textView.text = @"";
    }
    
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    //NSLog(@"Text view did end editing.");
    
    //Scroll
//    [UIView animateWithDuration:0.3 animations:^{
        [self.scrollView setContentOffset:CGPointMake(0, self.previousOffset.y)];
//    }];
    //[self.scrollView setContentOffset:CGPointMake(0, self.previousOffset.y)];
    //[self.scrollView setContentOffset:CGPointMake(0, -self.scrollView.contentInset.top)];
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    if ([textView isEqual:self.notesTextView]){
        self.recipe.recipeNotes = self.notesTextView.text.length > 0 ? self.notesTextView.text : @"";
    }
    else if ([textView isKindOfClass:[RCPInstructionTextView class]]){
        //Retrieve cell from the instructions table view.
        //NSLog(@"Updating recipe instruction.");
        RCPRecipeInstruction *editingInstruction = [self.instructionsArray objectAtIndex:textView.tag];
        editingInstruction.instructionText = textView.text;
        [self reloadInstructions];
    }
}



#pragma mark - UIImagePickerController Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *pickedImage;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    else {
        pickedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
//    NSData *imgData = UIImagePNGRepresentation(self.defaultImageImageView.image);
    
//    NSString *imageSize = [NSByteCountFormatter stringFromByteCount:imgData.length countStyle:NSByteCountFormatterCountStyleFile];
//    //NSLog(@"File Size: %@",imageSize);
    
    
    
    
    
    //Get NSData from the image selected.
    NSData *jpegData10Data = UIImageJPEGRepresentation(pickedImage, 0.1);
    //NSLog(@"Image Size (JPEG 10): %@",[NSByteCountFormatter stringFromByteCount:jpegData10Data.length countStyle:NSByteCountFormatterCountStyleFile]);
    

    
    
    
    
    
    
    
    NSString *imageName = [[NSDateFormatter imageNameTimestampFormatter] stringFromDate:[NSDate date]];
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    
    [jpegData10Data writeToFile:fullPathToFile atomically:NO];
    
    //self.recipe.recipeImageName = imageName;
    
    RCPRecipeImage *newRecipeImage = [RCPRecipeImage MR_createEntityInContext:self.contextToUse];
    newRecipeImage.recipeImageName = imageName;
    [self.recipe addImagesObject:newRecipeImage];
    
    [self reloadRecipeImages];
    
    //NSLog(@"fullPathToFile %@", fullPathToFile);
}

- (IBAction)photoButtonTapped:(UIButton *)sender {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        picker.allowsEditing = NO;
    }
    else {
        picker.allowsEditing = YES;
    }
    
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //NSLog(@"Canceled.");
    }]];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    BOOL isCameraPresent = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    UIAlertAction *takePhotoAction;
    
    if (isCameraPresent) {
        takePhotoAction = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            // Add overlay view with custom button on it. Set frames to button as per your choice.
            UIView *viewOverlay = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 100, 0, 100, 40)];
            UIButton *photoLibraryButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
            [photoLibraryButton setTitle:@"Photos" forState:UIControlStateNormal];
            [viewOverlay addSubview:photoLibraryButton];
            picker.cameraOverlayView = viewOverlay;
            [self presentViewController:picker animated:YES completion:nil];
        }];
    }
    else {
        //NSLog(@"Camera not available.");
    }
    UIAlertAction *choosePhotoAction = [UIAlertAction actionWithTitle:@"Choose Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        picker.modalPresentationStyle = UIModalPresentationPopover;
        UIPopoverPresentationController *controller = [picker popoverPresentationController];
        controller.sourceView = sender;
        controller.sourceRect = sender.bounds;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:picker animated:YES completion:nil];
        });
        
        
        
//        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.delegate = self;
//        picker.allowsEditing = YES;
//        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        [self presentViewController:picker animated:YES completion:nil];
        
        
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
    
    if (takePhotoAction){
        [alert addAction:takePhotoAction];
    }
    
    [alert addAction:choosePhotoAction];
    [alert addAction:cancelAction];
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        alert.popoverPresentationController.sourceView = sender;
        alert.popoverPresentationController.sourceRect = sender.bounds;
        [alert setModalPresentationStyle:UIModalPresentationPopover];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
}

#pragma mark - Keyboard
- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.keyboardHeight = kbSize.height;
}

#pragma mark - RCPAddCategoryViewController Delegate
-(void)categoryWasAdded:(RCPRecipeCategory *)addedCategory {
    //NSLog(@"Detected added category.");
    
    //Set the added category as selected.
    [self.recipe addCategoriesObject:addedCategory];
    
    //Reload categories
    [self reloadCategories];
    
}



@end
